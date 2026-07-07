import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart'; // Added for live tracking

import '../models/db_model.dart';
import '../services/helper_service.dart';

class MapViewScreen extends StatefulWidget {
  final ProjectFolder project;
  const MapViewScreen({super.key, required this.project});

  @override
  State<MapViewScreen> createState() => _MapViewScreenState();
}

class _MapViewScreenState extends State<MapViewScreen> {
  final DriftService _dbService = DriftService();
  final MapController _mapController = MapController();
  
  List<CameraTrap> _traps = [];
  bool _isLoading = true;
  LatLng? _currentDeviceLocation; // Holds the user's live position

  @override
  void initState() {
    super.initState();
    _initializeMapData();
  }

  Future<void> _initializeMapData() async {
    // 1. Fetch the user's actual location first
    await _fetchCurrentLocation();

    // 2. Load the deployed traps
    final data = await _dbService.getTrapsWithPhotosForProject(widget.project.id);
    
    setState(() {
      _traps = data.map((item) => item.keys.first).toList();
      _isLoading = false;
    });

    // 3. Route the camera logic
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_currentDeviceLocation != null) {
        // If we found the user, zoom directly to them
        _mapController.move(_currentDeviceLocation!, 15.0);
      } else if (_traps.isNotEmpty) {
        // Fallback: If no GPS signal, zoom to fit the existing traps
        _fitMapToBounds();
      }
    });
  }

  Future<void> _fetchCurrentLocation() async {
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) return;

      LocationPermission permission = await Geolocator.checkPermission();
      // If denied here, we just silently fail and don't show the blue dot.
      // Strict permission enforcement is kept in the deployment screen.
      if (permission == LocationPermission.denied || permission == LocationPermission.deniedForever) {
        return; 
      }

      Position position = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.high,
          timeLimit: Duration(seconds: 10),
        ),
      );

      setState(() {
        _currentDeviceLocation = LatLng(position.latitude, position.longitude);
      });
    } catch (e) {
      debugPrint('GPS query failed: $e');
    }
  }

  void _snapToCurrentLocation() {
    if (_currentDeviceLocation != null) {
      _mapController.move(_currentDeviceLocation!, 16.0);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Locating satellites... please wait.'), backgroundColor: Colors.orange),
      );
      _fetchCurrentLocation(); // Try fetching again if they tap the button
    }
  }

  void _fitMapToBounds() {
    if (_traps.isEmpty) return;

    final points = _traps.map((t) => LatLng(t.latitude, t.longitude)).toList();
    final bounds = LatLngBounds.fromPoints(points);

    _mapController.fitCamera(
      CameraFit.bounds(
        bounds: bounds,
        padding: const EdgeInsets.all(50.0),
      ),
    );
  }

  void _showTrapDetails(CameraTrap trap) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.camera_alt, color: Theme.of(context).colorScheme.primary, size: 28),
                  const SizedBox(width: 12),
                  Text(trap.trapName, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                ],
              ),
              const Divider(height: 30),
              Text('Deployed By: ${trap.deployedBy}', style: const TextStyle(fontSize: 16)),
              const SizedBox(height: 8),
              Text('Bearing: ${trap.compassDirection}', style: const TextStyle(fontSize: 16)),
              const SizedBox(height: 8),
              Text('Environment: ${trap.envConditions}', style: const TextStyle(fontSize: 16)),
              const SizedBox(height: 8),
              Text(
                'Coordinates: ${trap.latitude.toStringAsFixed(5)}, ${trap.longitude.toStringAsFixed(5)}',
                style: const TextStyle(fontSize: 14, color: Colors.grey),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Close'),
                ),
              )
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.project.name} - Navigation'),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : FlutterMap(
              mapController: _mapController,
              options: const MapOptions(
                initialCenter: LatLng(0, 0), // Default, overridden instantly by controller
                initialZoom: 13.0,
              ),
              children: [
                TileLayer(
                  urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                  userAgentPackageName: 'com.example.cameratrapapp',
                ),
                MarkerLayer(
                  markers: [
                    // 1. Plot the camera traps
                    ..._traps.map((trap) {
                      return Marker(
                        point: LatLng(trap.latitude, trap.longitude),
                        width: 50,
                        height: 50,
                        child: GestureDetector(
                          onTap: () => _showTrapDetails(trap),
                          child: Column(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                  color: Theme.of(context).colorScheme.primary,
                                  shape: BoxShape.circle,
                                  boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 4, offset: Offset(0, 2))],
                                ),
                                child: const Icon(Icons.location_on, color: Colors.white, size: 24),
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
                    
                    // 2. Plot the user's current location (The Blue Dot)
                    if (_currentDeviceLocation != null)
                      Marker(
                        point: _currentDeviceLocation!,
                        width: 24,
                        height: 24,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.blueAccent,
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 3),
                            boxShadow: const [BoxShadow(color: Colors.black45, blurRadius: 4)],
                          ),
                        ),
                      ),
                  ],
                ),
              ],
            ),
            
      // Add a quick-action button to center the map on the user
      floatingActionButton: FloatingActionButton(
        onPressed: _snapToCurrentLocation,
        backgroundColor: Colors.white,
        foregroundColor: Colors.blue,
        child: const Icon(Icons.my_location),
      ),
    );
  }
}