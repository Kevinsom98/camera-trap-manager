import 'dart:io';
import 'package:camera/camera.dart';
import 'package:camera_trap_app/services/helper_service.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:uuid/uuid.dart';
import '../models/db_model.dart';


class AddCameraTrapScreen extends StatefulWidget {
  final ProjectFolder project;
  const AddCameraTrapScreen({super.key, required this.project});

  @override
  State<AddCameraTrapScreen> createState() => _AddCameraTrapScreenState();
}

class _AddCameraTrapScreenState extends State<AddCameraTrapScreen> {
  final _formKey = GlobalKey<FormState>();
  final DriftService _dbService = DriftService();
  final ImagePicker _picker = ImagePicker();

  // Form Fields
  String _trapName = '';
  String _deployedBy = '';
  String _compassDirection = '';
  String _envConditions = '';
  
  // Hardware status
  Position? _currentPosition;
  bool _isFetchingGPS = false;
  final List<String> _localPhotoPaths = [];

  // Track if hardware is locked out by the user
  bool _permissionsGranted = false; 

  @override
  void initState() {
    super.initState();
    _checkPermissions(); // Run pre-flight check on load
  }

  Future<void> _checkPermissions() async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.camera,
      Permission.locationWhenInUse,
    ].request();

    final cameraGranted = statuses[Permission.camera]!.isGranted;
    final locationGranted = statuses[Permission.locationWhenInUse]!.isGranted;

    setState(() {
      _permissionsGranted = cameraGranted && locationGranted;
    });

    if (statuses[Permission.camera]!.isPermanentlyDenied || 
        statuses[Permission.locationWhenInUse]!.isPermanentlyDenied) {
      _showSettingsDialog();
    }
  }

  void _showSettingsDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Text('Hardware Access Required'),
        content: const Text('Camera and Location permissions are permanently denied. Please enable them in your device settings to deploy traps.'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () {
              openAppSettings(); // Magic function from permission_handler
              Navigator.pop(context);
            },
            child: const Text('Open Settings'),
          )
        ],
      ),
    );
  }

Future<void> _captureGPS() async {
    if (!_permissionsGranted) {
      _checkPermissions();
      return;
    }

    setState(() => _isFetchingGPS = true);
    try {
      Position position = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.bestForNavigation,
          timeLimit: Duration(seconds: 15),
        ),
      );
      setState(() => _currentPosition = position);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('GPS Fault: $e'), backgroundColor: Colors.red),
      );
    } finally {
      setState(() => _isFetchingGPS = false);
    }
  }

Future<void> _takePhoto() async {
    if (!_permissionsGranted) {
      _checkPermissions();
      return;
    }

    try {
      final XFile? photo = await _picker.pickImage(source: ImageSource.camera, imageQuality: 80);
      if (photo == null) return;

      final Directory appDir = await getApplicationDocumentsDirectory();
      final String permanentPath = '${appDir.path}/IMG_${const Uuid().v4()}.jpg';
      final File savedImage = await File(photo.path).copy(permanentPath);

      setState(() {
        _localPhotoPaths.add(savedImage.path);
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Camera error: $e'), backgroundColor: Colors.red),
      );
    }
  }

 // Inside AddCameraTrapScreen -> _submitForm()
void _submitForm() async {
  if (!_formKey.currentState!.validate()) return;
  if (_currentPosition == null) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('GPS coordinates required.'), backgroundColor: Colors.orange),
    );
    return;
  }
  _formKey.currentState!.save();

  // Construct the Drift Companion object
  final trap = CameraTrapsCompanion.insert(
    uuid: const Uuid().v4(),
    projectId: widget.project.id, // Direct foreign key int index
    trapName: _trapName,
    latitude: _currentPosition!.latitude,
    longitude: _currentPosition!.longitude,
    gpsAccuracy: _currentPosition!.accuracy,
    deployedBy: _deployedBy,
    compassDirection: _compassDirection,
    dateTimeDeployed: DateTime.now(),
    envConditions: _envConditions,
  );

  final DriftService dbService = DriftService();
  await dbService.saveCameraTrap(trap, _localPhotoPaths);
  
  Navigator.pop(context, true);
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Deploy to: ${widget.project.name}')),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            TextFormField(
              decoration: const InputDecoration(labelText: 'Camera Trap ID / Name', border: OutlineInputBorder()),
              validator: (v) => v!.isEmpty ? 'Required' : null,
              onSaved: (v) => _trapName = v!,
            ),
            const SizedBox(height: 12),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Deployed By (Name)', border: OutlineInputBorder()),
              validator: (v) => v!.isEmpty ? 'Required' : null,
              onSaved: (v) => _deployedBy = v!,
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    decoration: const InputDecoration(labelText: 'Bearing (e.g. 180° S)', border: OutlineInputBorder()),
                    validator: (v) => v!.isEmpty ? 'Required' : null,
                    onSaved: (v) => _compassDirection = v!,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: TextFormField(
                    decoration: const InputDecoration(labelText: 'Environment (Canopy, Swamp)', border: OutlineInputBorder()),
                    onSaved: (v) => _envConditions = v ?? '',
                  ),
                ),
              ],
            ),
            const Divider(height: 30),
            
            // GPS Functionality Block
            Card(
              color: _currentPosition == null ? Colors.red.shade50 : Colors.green.shade50,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  children: [
                    _isFetchingGPS 
                        ? const LinearProgressIndicator()
                        : Text(_currentPosition == null 
                            ? "No Position Locked" 
                            : "Lat: ${_currentPosition!.latitude.toStringAsFixed(6)}, Lon: ${_currentPosition!.longitude.toStringAsFixed(6)}\nAccuracy Radius: ${_currentPosition!.accuracy.toStringAsFixed(1)}m"),
                    const SizedBox(height: 8),
                    ElevatedButton.icon(
                      onPressed: _isFetchingGPS ? null : _captureGPS,
                      icon: const Icon(Icons.location_searching),
                      label: const Text('Fetch High-Accuracy GPS'),
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(height: 12),

            // Functional Photo Grid Grid
            const Text('Captured Photos', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 6),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, crossAxisSpacing: 4, mainAxisSpacing: 4),
              itemCount: _localPhotoPaths.length + 1,
              itemBuilder: (context, index) {
                if (index == _localPhotoPaths.length) {
                  return InkWell(
                    onTap: _takePhoto,
                    child: Container(color: Colors.grey.shade300, child: const Icon(Icons.add_a_photo, size: 30)),
                  );
                }
                return Image.file(File(_localPhotoPaths[index]), fit: BoxFit.cover);
              },
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              style: ElevatedButton.styleFrom(minimumSize: const Size.fromHeight(50), backgroundColor: Colors.green, foregroundColor: Colors.white),
              onPressed: _submitForm,
              child: const Text('Save Trap Locally', style: TextStyle(fontSize: 16)),
            )
          ],
        ),
      ),
    );
  }
}