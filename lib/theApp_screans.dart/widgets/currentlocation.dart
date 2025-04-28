// import 'package:flutter/material.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';

// class CurrentUserLocation extends StatefulWidget {
//   const CurrentUserLocation({super.key});

//   @override
//   State<CurrentUserLocation> createState() => _CurrentUserLocationState();
// }

// class _CurrentUserLocationState extends State<CurrentUserLocation> {
//   GoogleMapController? _googleMapController;
//   static const CameraPosition initialCameraPosition =
//       CameraPosition(target: LatLng(34.8888, -1.3180), zoom: 14);
//   Set<Marker> markers = {};
//   bool isLoading = false;

//   @override
//   void dispose() {
//     _googleMapController?.dispose(); // ✅ تنظيف الكنترولر
//     super.dispose();
//   }

// Future<void> _determinePosition() async {
//   setState(() {
//     isLoading = true;
//   });

//   try {
//     bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
//     if (!serviceEnabled) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text("Please enable location services from settings")),
//       );
//       return;
//     }

//     LocationPermission permission = await Geolocator.checkPermission();
//     if (permission == LocationPermission.denied) {
//       permission = await Geolocator.requestPermission();
//       if (permission == LocationPermission.denied) {
//         throw Exception("Location permission denied");
//       }
//     }
//     if (permission == LocationPermission.deniedForever) {
//       throw Exception("Location permission is permanently denied");
//     }

//     Position position = await Geolocator.getCurrentPosition(
//       desiredAccuracy: LocationAccuracy.low,
//     ).timeout(const Duration(seconds: 30), onTimeout: () {
//       throw Exception("Location request timed out");
//     });

//     // تحديث العلامة فقط إذا كان الموقع قد تغير
//     if (_googleMapController != null) {
//       setState(() {
//         // تحقق إذا كان الموقع الجديد يختلف بشكل كبير عن الموقع السابق
//         if (markers.isEmpty || markers.first.position.latitude != position.latitude || markers.first.position.longitude != position.longitude) {
//           markers.clear();
//           markers.add(Marker(
//             markerId: const MarkerId('currentlocation'),
//             position: LatLng(position.latitude, position.longitude),
//           ));

//           _googleMapController?.animateCamera(
//             CameraUpdate.newCameraPosition(
//               CameraPosition(
//                 target: LatLng(position.latitude, position.longitude),
//                 zoom: 14,
//               ),
//             ),
//           );
//         }
//       });
//     }
//   } catch (e) {
//     print("Error: $e");
//     if (mounted) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text(e.toString())),
//       );
//     }
//   } finally {
//     if (mounted) {
//       setState(() {
//         isLoading = false;
//       });
//     }
//   }
// }

//   @override
//   Widget build(BuildContext context) {
//     final screenHeight = MediaQuery.of(context).size.height;
//     final screenWidth = MediaQuery.of(context).size.width;

//     return Stack(
//       children: [
//         GoogleMap(
//           initialCameraPosition: initialCameraPosition,
//           zoomControlsEnabled: false,
//           markers: markers,
//           mapType: MapType.normal,
//           onMapCreated: (GoogleMapController controller) {
//             _googleMapController = controller;
//           },
//         ),
//         Positioned(
//           bottom: screenWidth * 0.02,
//           right: screenWidth * 0.009,
//           child: SizedBox(
//             height: screenHeight * 0.04,
//             width: screenWidth * 0.35,
//             child: FloatingActionButton.extended(
//               onPressed: isLoading ? null : _determinePosition,
//               label: isLoading
//                   ? const CircularProgressIndicator()
//                   : const Text("Current location",
//                       style: TextStyle(fontSize: 12)),
//               icon: isLoading
//                   ? Container()
//                   : const Icon(Icons.location_history, size: 20),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:geolocator/geolocator.dart';
// import 'dart:async';

// class UserLocationMap extends StatefulWidget {
//   final void Function(double lat, double lng)? onLocationPicked;

//   const UserLocationMap({super.key, this.onLocationPicked});
//   @override
//   _UserLocationMapState createState() => _UserLocationMapState();
// }

// class _UserLocationMapState extends State<UserLocationMap> {
//   GoogleMapController? mapController;
//   LatLng? currentLocation;
//   Marker? currentMarker;
//   StreamSubscription<Position>? positionStream;
//   bool isLoading = false;

//   // هذه الدالة تطلب الموقع في البداية
//   Future<void> _requestLocationAndShow() async {
//     bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
//     if (!serviceEnabled) {
//       await Geolocator.openLocationSettings();
//       return;
//     }

//     LocationPermission permission = await Geolocator.checkPermission();

//     if (permission == LocationPermission.denied) {
//       permission = await Geolocator.requestPermission();
//     }

//     if (permission == LocationPermission.deniedForever) {
//        if(mounted){
//           ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text("Location permission is permanently denied.")),
//       );
//        }
//       return;
//     }

//     if (permission == LocationPermission.always ||
//         permission == LocationPermission.whileInUse) {
//       Position position = await Geolocator.getCurrentPosition(
//         desiredAccuracy: LocationAccuracy.high,
//       );

//       LatLng newLocation = LatLng(position.latitude, position.longitude);

//       setState(() {
//         currentLocation = newLocation;
//         currentMarker = Marker(
//           markerId: MarkerId("currentLocation"),
//           position: newLocation,
//           infoWindow: InfoWindow(title: "You are here"),
//         );
//       });
//       if (widget.onLocationPicked != null) {
//         widget.onLocationPicked!(newLocation.latitude, newLocation.longitude);
//       }
//       mapController?.animateCamera(
//         CameraUpdate.newLatLngZoom(newLocation, 16),
//       );

//       // بدء تتبع الموقع بشكل مستمر
//       positionStream = Geolocator.getPositionStream(
//         locationSettings: LocationSettings(
//           accuracy: LocationAccuracy.high,
//           distanceFilter: 10,
//         ),
//       ).listen((Position position) {
//         LatLng updatedLocation = LatLng(position.latitude, position.longitude);
//         setState(() {
//           currentLocation = updatedLocation;
//           currentMarker = Marker(
//             markerId: MarkerId("currentLocation"),
//             position: updatedLocation,
//             infoWindow: InfoWindow(title: "You are here"),
//           );
//         });
//         mapController?.animateCamera(
//           CameraUpdate.newLatLngZoom(updatedLocation, 16),
//         );
//         // هنا يمكنك إرسال الموقع الجديد إلى قاعدة البيانات إذا كنت بحاجة إلى ذلك
//       });
//     }
//   }

//   @override
//   void dispose() {
//     // تأكد من إيقاف التتبع عند مغادرة الصفحة
//     positionStream?.cancel();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final screenHeight = MediaQuery.of(context).size.height;
//     final screenWidth = MediaQuery.of(context).size.width;
//     return Stack(
//       children: [
//         GoogleMap(
//           initialCameraPosition: CameraPosition(
//             target:
//                 currentLocation ?? LatLng(24.7136, 46.6753), // Default (Riyadh)
//             zoom: 10,
//           ),
//           onMapCreated: (GoogleMapController controller) {
//             mapController = controller;
//           },
//           markers: currentMarker != null ? {currentMarker!} : {},
//           myLocationEnabled: false,
//         ),
//         Positioned(
//           bottom: screenWidth * 0.3,
//           right: screenWidth * 0.009,
//           child: SizedBox(
//             height: screenHeight * 0.06,
//             width: screenWidth * 0.13,
//             child: FloatingActionButton(
//               onPressed: _requestLocationAndShow,
//               tooltip: "Show my current location",
//               child: Icon(Icons.location_searching),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

class UserLocationMap extends StatefulWidget {
  final void Function(double lat, double lng) onLocationPicked;

  const UserLocationMap({super.key, required this.onLocationPicked});

  @override
  State<UserLocationMap> createState() => _UserLocationMapState();
}

class _UserLocationMapState extends State<UserLocationMap> {
  GoogleMapController? _mapController;
  LatLng? _currentLocation;
  final Set<Marker> _markers = {};
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    try {
      // Get current position (permissions already handled in previous screen)
      final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      _updateLocation(LatLng(position.latitude, position.longitude));
    } catch (e) {
      _updateLocation(const LatLng(24.7136, 46.6753)); // Default to Riyadh
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  void _updateLocation(LatLng newLocation) {
    if (!mounted) return;
    
    setState(() {
      _currentLocation = newLocation;
      _markers.clear();
      _markers.add(
        Marker(
          markerId: const MarkerId("currentLocation"),
          position: newLocation,
          infoWindow: const InfoWindow(title: "Your Location"),
        ),
      );
    });

    widget.onLocationPicked(newLocation.latitude, newLocation.longitude);
    
    if (_mapController != null) {
      _mapController!.animateCamera(
        CameraUpdate.newLatLngZoom(newLocation, 16),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    return GoogleMap(
      mapType: MapType.normal,
      initialCameraPosition: CameraPosition(
        target: _currentLocation ?? const LatLng(24.7136, 46.6753),
        zoom: 16,
      ),
      onMapCreated: (GoogleMapController controller) {
        _mapController = controller;
        if (_currentLocation != null) {
          controller.animateCamera(
            CameraUpdate.newLatLngZoom(_currentLocation!, 16),
          );
        }
      },
      markers: _markers,
      myLocationEnabled: true,
      myLocationButtonEnabled: false, // Disabled as per requirements
      onTap: _updateLocation,
    );
  }

  @override
  void dispose() {
    _mapController?.dispose();
    super.dispose();
  }
}