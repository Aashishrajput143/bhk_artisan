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

  @override
  void onInit() {
    super.onInit();
    getCurrentLocation();
  }

  final rxRequestStatus = Status.COMPLETED.obs;
  void setError(String value) => error.value = value;
  RxString error = ''.obs;
  void setRxRequestStatus(Status value) => rxRequestStatus.value = value;

  Future<void> getCurrentLocation() async {
    setRxRequestStatus(Status.LOADING);

    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      setRxRequestStatus(Status.COMPLETED);
      Get.snackbar("Error", "Location services are disabled.");
      return;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        setRxRequestStatus(Status.COMPLETED);
        Get.snackbar("Error", "Location permissions are denied");
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      setRxRequestStatus(Status.COMPLETED);
      Get.snackbar("Error", "Location permissions are permanently denied");
      return;
    }

    Position position = await Geolocator.getCurrentPosition(locationSettings: LocationSettings(accuracy: LocationAccuracy.best, distanceFilter: 0));

    latitude.value = position.latitude;
    longitude.value = position.longitude;

    debugPrint("latitude===>${latitude.value}");
    debugPrint("longitude===>${longitude.value}");

    await getAddressFromLatLng(position);

    setRxRequestStatus(Status.COMPLETED);
  }

  Future<void> getAddressFromLatLng(Position position) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      if (placemarks.isNotEmpty) {
        place.value = placemarks.first;
        address.value =
            "${place.value?.name}, ${place.value?.street}, ${place.value?.subLocality}, ${place.value?.locality}, "
            "${place.value?.administrativeArea}, ${place.value?.postalCode}, ${place.value?.country}";

        debugPrint("Full Address===> ${address.value}");
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
