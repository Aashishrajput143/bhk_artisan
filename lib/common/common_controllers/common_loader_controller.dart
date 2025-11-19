import 'package:bhk_artisan/data/response/status.dart';
import 'package:get/get.dart';

class GlobalLoaderController extends GetxController {
  final rxRequestStatus = Status.COMPLETED.obs;
  void showLoader() => rxRequestStatus.value = Status.LOADING;
  void hideLoader() => rxRequestStatus.value = Status.COMPLETED;
}
