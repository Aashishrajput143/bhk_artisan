import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class AddressController extends GetxController{
  var nameController = TextEditingController().obs;
  var emailController = TextEditingController().obs;
  var phoneController = TextEditingController().obs;
  var flatNameController = TextEditingController().obs;
  var streetNameController = TextEditingController().obs;
  var lanMarkController = TextEditingController().obs;
  var pinController = TextEditingController().obs;

  var nameFocusNode = FocusNode().obs;
  var emailFocusNode = FocusNode().obs;
  var phoneFocusNode = FocusNode().obs;
  var flatFocusNode = FocusNode().obs;
  var streetFocusNode = FocusNode().obs;
  var landMarkFocusNode = FocusNode().obs;
  var pinFocusNode = FocusNode().obs;

  var type = "Home".obs;

  var countryCode = "+91".obs;

  var countryValue ="India".obs;
  var stateValue = Rxn<String>();
  var cityValue = Rxn<String>();
}
