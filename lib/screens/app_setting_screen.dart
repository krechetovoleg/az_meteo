import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_storage/get_storage.dart';
import 'package:home_widget/home_widget.dart';
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
    Color mColorText = mainBorderColor.bColorText;
    final box = GetStorage();
    MainController mainController = Get.put(MainController());
    MeteogramController meteogramController = Get.put(MeteogramController());
    double widthScreen = Get.width;

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
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                              color: mainBorderColor.bColor.withOpacity(0.5),
                              spreadRadius: 2,
                              blurRadius: 100),
                        ]),
                    width: (Get.width * 0.99).roundToDouble(),
                    height: Get.height,
                    child: Card(
                      color: backgroundColor,
                      shape: RoundedRectangleBorder(
                        side:
                            BorderSide(color: mainBorderColor.bColor, width: 2),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 12.0, top: 12.0),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            //mainAxisAlignment: MainAxisAlignment.center,

                            children: [
                              ElevatedButton(
                                onPressed: () => showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title:
                                          const Text('Выберите основной цвет'),
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
                                            mainBorderColor
                                                .changeMainColor(mColor);
                                            box.write(
                                              'bColor',
                                              mColor.toString(),
                                            );
                                            mainController.fetchMainData();
                                            meteogramController
                                                .fetchMeteogramData();
                                            Navigator.of(context).pop();
                                          },
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor:
                                                mainBorderColor.bColor,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(12)),
                                          ),
                                          child: const Text(
                                            'Применить',
                                            style: TextStyle(
                                                color: textColor,
                                                fontSize: 16.0),
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                ),
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: mainBorderColor.bColor,
                                    fixedSize: Size(widthScreen * 0.9, 40),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(12))),
                                child: const Text(
                                  'Основной цвет',
                                  style: TextStyle(
                                      color: textColor, fontSize: 16.0),
                                ),
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              ElevatedButton(
                                onPressed: () => showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: const Text(
                                          'Выберите цвет текста Widget'),
                                      content: SingleChildScrollView(
                                        child: ColorPicker(
                                          pickerColor:
                                              mainBorderColor.bColorText,
                                          onColorChanged: (Color color) {
                                            mColorText = color;
                                          },
                                        ),
                                      ),
                                      actions: <Widget>[
                                        ElevatedButton(
                                          onPressed: () async {
                                            mainBorderColor
                                                .changeTextColor(mColorText);
                                            box.write(
                                              'bColorText',
                                              mColorText.toString(),
                                            );

                                            HomeWidget.saveWidgetData(
                                                "colorText",
                                                mainBorderColor.bColorText
                                                    .toHexString());
                                            HomeWidget.updateWidget(
                                                name: "HomeScreenWidget",
                                                qualifiedAndroidName:
                                                    "com.example.az_meteo.HomeScreenWidget",
                                                androidName:
                                                    "HomeScreenWidget");
                                            Navigator.of(context).pop();
                                          },
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor:
                                                mainBorderColor.bColorText,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(12)),
                                          ),
                                          child: const Text(
                                            'Применить',
                                            style: TextStyle(
                                                color: textColor,
                                                fontSize: 16.0),
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                ),
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: mainBorderColor.bColorText,
                                    fixedSize: Size(widthScreen * 0.9, 40),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(12))),
                                child: const Text(
                                  'Цвет текста Widget',
                                  style: TextStyle(
                                      color: textColor, fontSize: 16.0),
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
