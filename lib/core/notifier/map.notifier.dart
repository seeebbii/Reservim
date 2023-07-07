import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';

class MapNotifier extends ChangeNotifier {

  late GoogleMapController mapController;
  late Stream<Position> _geoLocationStream;
  late Position userLocation;

  Completer<GoogleMapController> googleMapController = Completer();

  void onMapCreated(GoogleMapController controller) {
    if (!googleMapController.isCompleted) {
      googleMapController.complete(controller);

      mapController = controller;
      notifyListeners();
    }
  }

  Future<void> animateCamera(CameraPosition position) async {
    mapController = await googleMapController.future;
    mapController.animateCamera(CameraUpdate.newCameraPosition(position));
  }

  Future<PermissionStatus> checkLocationPermission() async {
    PermissionStatus permissionStatus = await Permission.location.request();

    return permissionStatus;
  }

  Future<void> listenToUserLocation() async {
    await checkLocationPermission().then((permissionStatus) {
      if (permissionStatus == PermissionStatus.granted) {
        debugPrint("Location permission: $permissionStatus");
        Geolocator.isLocationServiceEnabled().then((geoPermission) async {
          if (geoPermission) {
            _geoLocationStream = Geolocator.getPositionStream(
                locationSettings: const LocationSettings(
                    accuracy: LocationAccuracy.bestForNavigation));
            _geoLocationStream.listen((event) {
              userLocation = event;
              notifyListeners();
            });
            userLocation = await Geolocator.getCurrentPosition(
                desiredAccuracy: LocationAccuracy.bestForNavigation);
            print(userLocation);
          }
        });
      } else {
        listenToUserLocation();
      }
    });
  }
}