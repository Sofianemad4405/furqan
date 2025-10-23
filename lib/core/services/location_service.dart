import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocationService {
  final SharedPreferences _prefs;
  final String _keyLocationPermission = 'location_permission';

  LocationService(this._prefs);

  Future<void> saveLocationPermission(bool permission) async {
    await _prefs.setBool(_keyLocationPermission, permission);
  }

  bool get locationPermission =>
      _prefs.getBool(_keyLocationPermission) ?? false;

  Future<Position?> getCurrentLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();

      serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        return null;
      }
    }

    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      await saveLocationPermission(false);
      return null;
    }

    await saveLocationPermission(true);

    return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    ).timeout(const Duration(seconds: 10));
  }

  Future<List<String?>?> getUserAddress() async {
    Position? position = await getCurrentLocation();
    if (position == null) return null;

    List<Placemark> placemarks = await placemarkFromCoordinates(
      position.latitude,
      position.longitude,
    ).timeout(const Duration(seconds: 10));

    Placemark place = placemarks.first;

    return ["${place.street}", "${place.locality}", "${place.country}"];
  }
}
