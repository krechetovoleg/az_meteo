import 'package:flutter/material.dart';
import '../theme/theme.dart';
import '../controllers/color_controller.dart';
import 'package:get/get.dart';

class CardWidget extends StatelessWidget {
  final String topStr;
  final double topSize;
  final String centerStr;
  final double centerSize;
  final String bottomStr;
  final double bottomSize;
  final double width;

  const CardWidget({
    Key? key,
    required this.topStr,
    required this.topSize,
    required this.centerStr,
    required this.centerSize,
    required this.bottomStr,
    required this.bottomSize,
    required this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var mainBorderColor = Get.put(ColorController());
    return Obx(
      () {
        return mainBorderColor.isLoading.value
            ? Center(child: const CircularProgressIndicator().reactive())
            : Container(
                width: width,
                height: 200,
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
                  shape: RoundedRectangleBorder(
                    side: BorderSide(color: mainBorderColor.bColor, width: 2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Flexible(
                          flex: 2,
                          child: Padding(
                            padding: const EdgeInsets.only(
                              left: 12.0,
                              top: 6,
                              right: 12,
                              bottom: 6,
                            ),
                            child: Text(
                              topStr,
                              style: TextStyle(fontSize: topSize, color: textColor),
                            ),
                          ),
                        ),
                        Flexible(
                          flex: 1,
                          child: Padding(
                            padding: const EdgeInsets.only(
                              left: 12.0,
                              top: 6,
                              right: 12,
                              bottom: 6,
                            ),
                            child: Text(
                              centerStr,
                              style: TextStyle(
                                fontSize: centerSize,
                                color: textColor,
                              ),
                            ),
                          ),
                        ),
                        Flexible(
                          flex: 1,
                          child: Padding(
                            padding: const EdgeInsets.only(
                              left: 12.0,
                              top: 6,
                              right: 12,
                              bottom: 6,
                            ),
                            child: Text(
                              bottomStr,
                              style: TextStyle(
                                fontSize: bottomSize,
                                color: textColor,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
      },
    );
  }
}

class CardWidgetSmall extends StatelessWidget {
  final String topStr;
  final double topSize;
  final String bottomStr;
  final double bottomSize;
  final double width;

  const CardWidgetSmall({
    Key? key,
    required this.topStr,
    required this.topSize,
    required this.bottomStr,
    required this.bottomSize,
    required this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mainBorderColor = Get.put(ColorController());

    return Obx(
      () {
        return mainBorderColor.isLoading.value
            ? Center(child: const CircularProgressIndicator().reactive())
            : Container(
                width: width,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), boxShadow: [
                  BoxShadow(color: mainBorderColor.bColor.withOpacity(0.5), spreadRadius: 2, blurRadius: 100),
                ]),
                child: Card(
                  color: backgroundColor,
                  shape: RoundedRectangleBorder(
                    side: BorderSide(color: mainBorderColor.bColor, width: 2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        flex: 1,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 12.0, top: 12, right: 12),
                          child: ImageIcon(AssetImage(topStr), size: topSize, color: textColor),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 12.0, top: 2, right: 12, bottom: 12),
                          child: Text(
                            bottomStr,
                            style: TextStyle(fontSize: bottomSize, color: textColor),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
      },
    );
  }
}
