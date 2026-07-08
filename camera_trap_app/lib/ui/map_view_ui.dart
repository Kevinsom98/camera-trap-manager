import 'dart:async';
import 'package:dio_cache_interceptor_file_store/dio_cache_interceptor_file_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_map_cache/flutter_map_cache.dart';
import 'package:path_provider/path_provider.dart';

import '../models/db_model.dart';
import '../services/helper_service.dart';

class MapViewScreen extends StatefulWidget {
  final ProjectFolder project;
  const MapViewScreen({super.key, required this.project});

  @override
  State<MapViewScreen> createState() => _MapViewScreenState();
}

enum MapStyle { street, satellite, topography }

class _MapViewScreenState extends State<MapViewScreen> {
  final DriftService _dbService = DriftService();
  final MapController _mapController = MapController();
  StreamSubscription<Position>? _positionStreamSubscription;
  
  List<CameraTrap> _traps = [];
  bool _isLoading = true;
  
  // Breadcrumb Trail State
  List<LatLng> _breadcrumbs = [];
  LatLng? _currentDeviceLocation;
  bool _isLogging = false; // NEW: Track if tracking is actively recording

  // Custom Layer Selection State
  MapStyle _currentStyle = MapStyle.street;
  String? _cacheDirectoryPath;

  final Map<MapStyle, String> _tileUrls = {
    MapStyle.street: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
    MapStyle.satellite: 'https://server.arcgisonline.com/ArcGIS/rest/services/World_Imagery/MapServer/tile/{z}/{y}/{x}',
    MapStyle.topography: 'https://{s}.tile.opentopomap.org/{z}/{x}/{y}.png',
  };

  @override
  void initState() {
    super.initState();
    _setupMapEngine();
  }

  @override
  void dispose() {
    _positionStreamSubscription?.cancel();
    super.dispose();
  }

  Future<void> _setupMapEngine() async {
    final appDir = await getApplicationDocumentsDirectory();
    setState(() {
      _cacheDirectoryPath = '${appDir.path}/map_tile_cache';
    });

    final data = await _dbService.getTrapsWithPhotosForProject(widget.project.id);
    _traps = data.map((item) => item.keys.first).toList();

    // REMOVED: _startLiveTracking() is taken out of init so it doesn't auto-start
    setState(() => _isLoading = false);
  }

  // NEW: Unified Start/Stop toggle controller
  void _toggleTracking() async {
    if (_isLogging) {
      // STOP ENGAGED
      await _positionStreamSubscription?.cancel();
      setState(() {
        _positionStreamSubscription = null;
        _isLogging = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Tracking Paused'), backgroundColor: Colors.redAccent),
      );
    } else {
      // START ENGAGED
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied || permission == LocationPermission.deniedForever) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied || permission == LocationPermission.deniedForever) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Location permissions are required to trail log.'), backgroundColor: Colors.orange),
          );
          return;
        }
      }

      _positionStreamSubscription = Geolocator.getPositionStream(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.bestForNavigation,
          distanceFilter: 5,
        ),
      ).listen((Position position) {
        final loc = LatLng(position.latitude, position.longitude);
        setState(() {
          _currentDeviceLocation = loc;
          _breadcrumbs.add(loc);
        });
      });

      setState(() {
        _isLogging = true;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Tracking Active'), backgroundColor: Colors.green),
      );
    }
  }

  void _cycleMapStyle() {
    setState(() {
      if (_currentStyle == MapStyle.street) {
        _currentStyle = MapStyle.satellite;
      } else if (_currentStyle == MapStyle.satellite) {
        _currentStyle = MapStyle.topography;
      } else {
        _currentStyle = MapStyle.street;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading || _cacheDirectoryPath == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.project.name} - Navigation'),
        actions: [
          IconButton(
            icon: const Icon(Icons.layers_clear),
            tooltip: 'Clear Current Trail Layout',
            onPressed: () => setState(() => _breadcrumbs.clear()),
          )
        ],
      ),
      body: Stack(
        children: [
          FlutterMap(
            mapController: _mapController,
            options: MapOptions(
              initialCenter: _traps.isNotEmpty
                  ? LatLng(_traps.first.latitude, _traps.first.longitude)
                  : const LatLng(0, 0),
              initialZoom: 14.0,
            ),
            children: [
              TileLayer(
                urlTemplate: _tileUrls[_currentStyle],
                subdomains: const ['a', 'b', 'c'],
                userAgentPackageName: 'com.example.cameratrapapp',
                tileProvider: CachedTileProvider(store: FileCacheStore(_cacheDirectoryPath!)),
              ),
              PolylineLayer(
                polylines:[
                        Polyline(
                          points: _breadcrumbs,
                          color: Colors.orangeAccent,
                          strokeWidth: 4.0,
                          borderColor: Colors.deepOrange,
                          borderStrokeWidth: 1.0,
                        ),
                      ],
              ),
              MarkerLayer(
                markers: [
                  ..._traps.map((trap) {
                    return Marker(
                      point: LatLng(trap.latitude, trap.longitude),
                      width: 45,
                      height: 45,
                      child: Container(
                        decoration: const BoxDecoration(
                          color: Colors.green,
                          shape: BoxShape.circle,
                          boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 4)],
                        ),
                        child: const Icon(Icons.photo_camera, color: Colors.white, size: 20),
                      ),
                    );
                  }),
                  if (_currentDeviceLocation != null)
                    Marker(
                      point: _currentDeviceLocation!,
                      width: 26,
                      height: 26,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.blueAccent,
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 3),
                          boxShadow: const [BoxShadow(color: Colors.black38, blurRadius: 6)],
                        ),
                      ),
                    ),
                ],
              ),
            ],
          ),

          // Layer Map Style Control Quick Button
          Positioned(
            top: 16,
            right: 16,
            child: FloatingActionButton.small(
              heroTag: 'styleBtn',
              onPressed: _cycleMapStyle,
              backgroundColor: Colors.white.withOpacity(0.9),
              child: Icon(
                _currentStyle == MapStyle.street 
                    ? Icons.map 
                    : _currentStyle == MapStyle.satellite 
                        ? Icons.satellite_alt 
                        : Icons.terrain,
                color: Colors.black87,
              ),
            ),
          ),

          // NEW: BOTTOM TELEMETRY AND LOGGING CARD OVERLAY
          Positioned(
            bottom: 24,
            left: 16,
            right: 80, // Leaves uniform clearance room for the GPS centering FAB
            child: Card(
              color: Colors.white.withOpacity(0.92),
              elevation: 4,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                child: Row(
                  children: [
                    // Status Beacon Glow
                    Icon(
                      Icons.circle, 
                      size: 14, 
                      color: _isLogging ? Colors.green : Colors.grey
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _isLogging ? 'PATROL ACTIVE' : 'LOGGING PAUSED',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
                              color: _isLogging ? Colors.green.shade800 : Colors.grey.shade700,
                              letterSpacing: 0.8
                            ),
                          ),
                          Text(
                            'Trail Checkpoints: ${_breadcrumbs.length}',
                            style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                    // High-contrast, chunkier control trigger switch
                    IconButton.filled(
                      onPressed: _toggleTracking,
                     
                      
                      icon: Icon(_isLogging ? Icons.stop : Icons.play_arrow),
                      style: IconButton.styleFrom(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                         backgroundColor: _isLogging ? Colors.red : Colors.green, foregroundColor: Colors.white,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: 'gpsBtn',
        onPressed: () {
          if (_currentDeviceLocation != null) {
            _mapController.move(_currentDeviceLocation!, 16.0);
          }
        },
        backgroundColor: Theme.of(context).colorScheme.primary,
        child: const Icon(Icons.my_location, color: Colors.white),
      ),
    );
  }
}