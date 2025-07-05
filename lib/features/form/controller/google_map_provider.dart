import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:location/location.dart' as loc;

class GoogleMapProvider with ChangeNotifier {
  LatLng? currentPosition;
  LatLng? pickedPosition;
  String address = "";
  bool isLoading = false;
  int? pincode;
  double? _latitude;
  double? _longitude;
  double? get latitude => _latitude;
  double? get longitude => _longitude;

  Future<void> getCurrentLocation() async {
    try {
      isLoading = true;
      notifyListeners();

      // Request permission using permission_handler
      PermissionStatus permissionStatus = await Permission.location.request();
      if (!permissionStatus.isGranted) {
        address = "Location permission not granted.";
        isLoading = false;
        notifyListeners();
        return;
      }

      // Prompt to turn on GPS using location package
      loc.Location location = loc.Location();
      bool serviceEnabled = await location.serviceEnabled();
      if (!serviceEnabled) {
        serviceEnabled = await location.requestService();
        if (!serviceEnabled) {
          address = "Location services are disabled.";
          isLoading = false;
          notifyListeners();
          return;
        }
      }

      // Get current location using Geolocator
      final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      currentPosition = LatLng(position.latitude, position.longitude);
      pickedPosition = currentPosition;

      await _getAddressFromLatLng(pickedPosition!);
    } catch (e) {
      address = "Error fetching location.";
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> updatePickedPosition(LatLng newPosition) async {
    pickedPosition = newPosition;
    notifyListeners();
    await _getAddressFromLatLng(newPosition);
  }

  Future<void> _getAddressFromLatLng(LatLng pos) async {
    try {
      final placemarks = await placemarkFromCoordinates(
        pos.latitude,
        pos.longitude,
      );
      _latitude = pos.latitude;
      _longitude = pos.longitude;
      if (placemarks.isNotEmpty) {
        final place = placemarks.first;
        address =
            "${place.street}, ${place.subLocality}, ${place.locality}, ${place.administrativeArea}, ${place.country}, ${place.postalCode}";
        pincode = int.parse(place.postalCode!);
      } else {
        address = "No address found.";
      }
    } catch (e) {
      address = "Unable to fetch address";
    }
    notifyListeners();
  }
}
