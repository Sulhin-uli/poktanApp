import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FormActivityController extends GetxController {
  // form
  late TextEditingController categoryActivityId;
  late TextEditingController title;
  late TextEditingController file;
  late TextEditingController desc;

  @override
  void onInit() {
    super.onInit();

    // form
    categoryActivityId = TextEditingController();
    title = TextEditingController();
    file = TextEditingController();
    desc = TextEditingController();
  }
}
