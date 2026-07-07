import 'package:geolocator/geolocator.dart';

Future<Position> getHighAccuracyLocation() async {
  bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) return Future.error('Location services are disabled.');

  LocationPermission permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      return Future.error('Location permissions are denied');
    }
  }

  // Configure settings for maximum accuracy
  return await Geolocator.getCurrentPosition(
    locationSettings: const LocationSettings(
      accuracy: LocationAccuracy.bestForNavigation, // Uses precise GNSS
      timeLimit: Duration(seconds: 15), // Prevents infinite battery drain
    ),
  );
}