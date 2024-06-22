import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ColorController extends GetxController {
  Color bColor = const Color.fromARGB(170, 68, 137, 255).obs();
  Color bColorText = const Color.fromARGB(170, 68, 137, 255).obs();
  int intColor = 0;
  var isLoading = true.obs;

  @override
  void onInit() {
    initMainColor();
    super.onInit();
  }

  void initMainColor() {
    final box = GetStorage();
    Color col;
    Color colText;

    try {
      col = box.read('bColor') != null
          ? Color(int.parse(box.read('bColor').split('(0x')[1].split(')')[0],
              radix: 16))
          : const Color.fromARGB(170, 68, 137, 255);

      colText = box.read('bColorText') != null
          ? Color(int.parse(box.read('bColor').split('(0x')[1].split(')')[0],
              radix: 16))
          : const Color.fromARGB(170, 68, 137, 255);
    } catch (e) {
      col = const Color.fromARGB(170, 68, 137, 255);
      colText = const Color.fromARGB(170, 68, 137, 255);
    }

    changeMainColor(col);
    changeTextColor(colText);
  }

  void changeMainColor(Color inColor) async {
    try {
      isLoading.value = true;
      bColor = inColor;
    } finally {
      isLoading.value = false;
    }
  }

  void changeTextColor(Color inColor) async {
    try {
      isLoading.value = true;
      bColorText = inColor;
    } finally {
      isLoading.value = false;
    }
  }
}
