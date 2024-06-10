import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_storage/get_storage.dart';
import '../theme/theme.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:get/get.dart';
import '../controllers/color_controller.dart';
import '../controllers/main_controller.dart';
import '../controllers/meteogram_controller.dart';

class AppSettingScreen extends StatefulWidget {
  const AppSettingScreen({super.key});

  @override
  State<AppSettingScreen> createState() => _AppSettingScreenState();
}

class _AppSettingScreenState extends State<AppSettingScreen> {

  @override
  void initState() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var mainBorderColor = Get.put(ColorController());
    Color mColor = mainBorderColor.bColor;
    final box = GetStorage();
    MainController mainController = Get.put(MainController());
    MeteogramController meteogramController = Get.put(MeteogramController());

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: backgroundColor,
        iconTheme: const IconThemeData(color: textColor),
        title: const Text(
          'AzMeteo',
          style: TextStyle(
            fontFamily: 'Roboto',
            fontSize: 34,
            color: textColor,
          ),
        ),
      ),
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Obx(
          () {
            return mainBorderColor.isLoading.value
                ? Center(child: const CircularProgressIndicator().reactive())
                : Container(
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), boxShadow: [
                      BoxShadow(color: mainBorderColor.bColor.withOpacity(0.5), spreadRadius: 2, blurRadius: 100),
                    ]),
                    width: (Get.width * 0.99).roundToDouble(),
                    height: Get.height,
                    child: Card(
                      color: backgroundColor,
                      shape: RoundedRectangleBorder(
                        side: BorderSide(color: mainBorderColor.bColor, width: 2),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 12.0, top: 12.0),
                        child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                          ElevatedButton(
                            onPressed: () => showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text('Выберите цвет'),
                                  content: SingleChildScrollView(
                                    child: ColorPicker(
                                      pickerColor: mainBorderColor.bColor,
                                      onColorChanged: (Color color) {
                                        mColor = color;
                                      },
                                    ),
                                  ),
                                  actions: <Widget>[
                                    ElevatedButton(
                                      onPressed: () async {
                                        mainBorderColor.changeMainColor(mColor);
                                        box.write(
                                          'bColor',
                                          mColor.toString(),
                                        );
                                        mainController.fetchMainData();
                                        meteogramController.fetchMeteogramData();
                                        Navigator.of(context).pop();
                                      },
                                      style: ElevatedButton.styleFrom(backgroundColor: mainBorderColor.bColor),
                                      child: const Text('Применить'),
                                    ),
                                  ],
                                );
                              },
                            ),
                            style: ElevatedButton.styleFrom(backgroundColor: mainBorderColor.bColor),
                            child: const Text(
                              'Основной цвет',
                              style: TextStyle(color: textColor, fontSize: 16.0),
                            ),
                          ),
                        ]),
                      ),
                    ),
                  );
          },
        ),
      ),
    );
  }
}