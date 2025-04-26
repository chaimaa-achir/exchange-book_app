import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationStorage {
  static Future<LatLng?> getSavedLocation() async {
    final prefs = await SharedPreferences.getInstance();
    double? lat = prefs.getDouble('latitude');
    double? lng = prefs.getDouble('longitude');

    if (lat != null && lng != null) {
      return LatLng(lat, lng);
    } else {
      return null;
    }
  }
}
