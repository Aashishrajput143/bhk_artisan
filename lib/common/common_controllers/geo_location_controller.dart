import 'package:bhk_artisan/data/response/status.dart';
import 'package:flutter/widgets.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';

class LocationController extends GetxController {
  var latitude = 0.0.obs;
  var longitude = 0.0.obs;
  var place = Rxn<Placemark>();
  var address = "".obs;
  var error = Rxn<String>();

  final rxRequestStatus = Status.COMPLETED.obs;
  void setRxRequestStatus(Status value) => rxRequestStatus.value = value;

  Stream<Position>? _positionStream;

  @override
  void onInit() {
    super.onInit();
    getCurrentLocation();
  }

  Future<void> getCurrentLocation() async {
    error.value = null;
    setRxRequestStatus(Status.LOADING);

    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      error.value = "Location services are disabled.";
      setRxRequestStatus(Status.COMPLETED);
      return;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        error.value = "Location permissions are denied";
        setRxRequestStatus(Status.COMPLETED);
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      error.value = "Location permissions are permanently denied";
      setRxRequestStatus(Status.COMPLETED);
      return;
    }

    _positionStream = Geolocator.getPositionStream(locationSettings: const LocationSettings(accuracy: LocationAccuracy.best, distanceFilter: 0));

    _positionStream!.listen((Position position) async {
      latitude.value = position.latitude;
      longitude.value = position.longitude;

      await _updateAddress(position);
      setRxRequestStatus(Status.COMPLETED);
    });
  }

  Future<void> _updateAddress(Position position) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);

      if (placemarks.isNotEmpty) {
        place.value = placemarks.first;
        final places = placemarks.first;

        List<String> parts = [];
        void addIfNotEmpty(String? value) {
          if (value != null && value.trim().isNotEmpty) {
            parts.add(value.trim());
          }
        }

        addIfNotEmpty(places.name);
        addIfNotEmpty(places.street);
        addIfNotEmpty(places.subLocality);
        places.subLocality?.isEmpty ?? false ? addIfNotEmpty(places.thoroughfare) : null;
        addIfNotEmpty(places.locality);
        addIfNotEmpty(places.administrativeArea);
        addIfNotEmpty(places.postalCode);
        addIfNotEmpty(places.country);

        address.value = parts.join(", ");
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
