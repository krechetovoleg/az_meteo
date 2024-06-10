import 'package:flutter/material.dart';
import '../controllers/meteogram_controller.dart';
import 'package:get/get.dart';
import '../theme/theme.dart';
import '../controllers/color_controller.dart';

class DataTableWidget extends StatelessWidget {
  DataTableWidget({super.key});

  final MeteogramController meteogramController =
      Get.put(MeteogramController());
  final mainBorderColor = Get.put(ColorController());
  final double widthScreen = Get.width;

  final TextStyle textStyle = const TextStyle(
    fontSize: 14.0,
    color: textColor,
  );

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return mainBorderColor.isLoading.value
          ? Center(child: const CircularProgressIndicator().reactive())
          : Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: mainBorderColor.bColor.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 100,
                  ),
                ],
              ),
              child: Card(
                color: backgroundColor,
                child: Column(
                  children: [
                    const SizedBox(height: 12.0),
                    const Padding(
                      padding: EdgeInsets.only(top: 12.0, bottom: 16.0),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Center(
                              child: ImageIcon(
                                  AssetImage('assets/images/time.png'),
                                  size: 20.0,
                                  color: textColor),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Center(
                              child: ImageIcon(
                                  AssetImage('assets/images/temp_plus.png'),
                                  size: 20.0,
                                  color: textColor),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Center(
                              child: ImageIcon(
                                  AssetImage('assets/images/pressure.png'),
                                  size: 20.0,
                                  color: textColor),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Center(
                              child: ImageIcon(
                                  AssetImage('assets/images/humidity.png'),
                                  size: 20.0,
                                  color: textColor),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Center(
                              child: ImageIcon(
                                  AssetImage('assets/images/wind.png'),
                                  size: 20.0,
                                  color: textColor),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: ListView.separated(
                        physics: const ClampingScrollPhysics(),
                        separatorBuilder: (context, index) =>
                            const Divider(color: textColor),
                        itemCount: meteogramController.meteo.length,
                        itemBuilder: (BuildContext context, int index) {
                          return SizedBox(
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Center(
                                    child: Text(
                                      meteogramController.meteo[index]['times']
                                          .toString(),
                                      style: textStyle,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Center(
                                    child: Text(
                                      meteogramController.meteo[index]
                                              ['temperature']
                                          .toString(),
                                      style: textStyle,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Center(
                                    child: Text(
                                      meteogramController.meteo[index]
                                              ['pressure']
                                          .toString(),
                                      style: textStyle,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Center(
                                    child: Text(
                                      meteogramController.meteo[index]
                                              ['humidity']
                                          .toString(),
                                      style: textStyle,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Center(
                                    child: Text(
                                      meteogramController.meteo[index]['wind']
                                          .toString(),
                                      style: textStyle,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            );
    });
  }
}
