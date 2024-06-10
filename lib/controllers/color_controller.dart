import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ColorController extends GetxController {
  Color bColor = const Color.fromARGB(170, 68, 137, 255).obs();
  var isLoading = true.obs;

  @override
  void onInit() {
    initMainColor();
    super.onInit();
  }

  void initMainColor() {
    final box = GetStorage();
    Color col;

    try {
      col = box.read('bColor') != null
          ? Color(int.parse(box.read('bColor').split('(0x')[1].split(')')[0], radix: 16))
          : const Color.fromARGB(170, 68, 137, 255);
    } catch (e) {
      col = const Color.fromARGB(170, 68, 137, 255);
    }
    changeMainColor(col);
  }

  void changeMainColor(Color inColor) async {
    try {
      isLoading.value = true;
      bColor = inColor;
    } finally {
      isLoading.value = false;
    }
  }
}
