import 'package:get/get.dart';

extension StringExtension on String{
  String sentenceCaseToNormal(){
    return split('_').map((a)=>a.capitalize).join(' ');
  }
}