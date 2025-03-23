import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CurrentUserLocation extends StatefulWidget {
  const CurrentUserLocation({super.key});

  @override
  State<CurrentUserLocation> createState() => _CurrentUserLocationState();
}

class _CurrentUserLocationState extends State<CurrentUserLocation> {
  GoogleMapController? _googleMapController;
  static const CameraPosition initialCameraPosition =
      CameraPosition(target: LatLng(34.8888, -1.3180), zoom: 14);
  Set<Marker> markers = {};
  bool isLoading = false;

  Future<void> _determinePosition() async {
    setState(() {
      isLoading = true;
    });

    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        throw Exception("Location services are disabled");
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          throw Exception("Location permission denied");
        }
      }
      if (permission == LocationPermission.deniedForever) {
        throw Exception("Location permission is permanently denied");
      }

      // Get user location with a timeout
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.low,
      ).timeout(const Duration(seconds: 10), onTimeout: () {
        throw Exception("Location request timed out");
      });

      // Update markers only when GoogleMap is ready
      if (_googleMapController != null) {
        setState(() {
          markers.clear();
          markers.add(Marker(
            markerId: const MarkerId('currentlocation'),
            position: LatLng(position.latitude, position.longitude),
          ));

          // Ensure GoogleMap is loaded before moving camera
          _googleMapController?.animateCamera(
            CameraUpdate.newCameraPosition(
              CameraPosition(
                target: LatLng(position.latitude, position.longitude),
                zoom: 14,
              ),
            ),
          );
        });
      }
    } catch (e) {
      print("Error: $e");
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.toString())),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GoogleMap(
          initialCameraPosition: initialCameraPosition,
          zoomControlsEnabled: false,
          markers: markers,
          mapType: MapType.normal,
          onMapCreated: (GoogleMapController controller) {
            _googleMapController = controller;
          },
        ),
        Positioned(
          bottom: MediaQuery.of(context).size.width * 0.02,
          right: MediaQuery.of(context).size.width * 0.009,
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.04,
            width: MediaQuery.of(context).size.width * 0.35,
            child: FloatingActionButton.extended(
              onPressed: isLoading ? null : _determinePosition,
              label: isLoading
                  ? const CircularProgressIndicator()
                  : const Text("Current location", style: TextStyle(fontSize: 12)),
              icon: isLoading ? Container() : Icon(Icons.location_history, size: 20),
            ),
          ),
        ),
      ],
    );
  }
}
