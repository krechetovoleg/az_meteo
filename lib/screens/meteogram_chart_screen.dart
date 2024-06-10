import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../theme/theme.dart';
import '../controllers/meteogram_chart_controller.dart';
import '../models/meteogram_chart_model.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../controllers/color_controller.dart';

class MeteogramScreen extends StatefulWidget {
  const MeteogramScreen({super.key});

  @override
  State<MeteogramScreen> createState() => _MeteogramScreenState();
}

class _MeteogramScreenState extends State<MeteogramScreen> {

  @override
  void initState() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);

    super.initState();
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //Не удалять, не работает ориентация
    var isPortrait = MediaQuery.of(context).orientation;
    double widthScreen = Get.width;

    final MeteogramChartController meteogramChartController =
        Get.put(MeteogramChartController());
    final mainBorderColor = Get.put(ColorController());
    final ZoomPanBehavior zoomPanBehavior;

    zoomPanBehavior = ZoomPanBehavior(
      enablePinching: true,
    );

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
        child: Center(
          child: Obx(
            () {
              if (meteogramChartController.isLoading.value) {
                return Center(
                  child: const CircularProgressIndicator().reactive(),
                );
              } else {
                return meteogramChartController.meteogramChartList.isNotEmpty
                    ? Container(
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
                        width: (widthScreen * 0.99).roundToDouble(),
                        child: Card(
                          color: backgroundColor,
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                              color: mainBorderColor.bColor,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: SfCartesianChart(
                            legend: Legend(
                              isVisible: true,
                              textStyle: const TextStyle(
                                color: textColor,
                                fontSize: 12.0,
                              ),
                              position: LegendPosition.bottom,
                              overflowMode: LegendItemOverflowMode.wrap,
                            ),
                            crosshairBehavior: CrosshairBehavior(
                              enable: true,
                              activationMode: ActivationMode.longPress,
                            ),
                            zoomPanBehavior: zoomPanBehavior,
                            title: ChartTitle(
                              text: 'Суточная среднечасовая метеограмма',
                              textStyle: const TextStyle(
                                fontFamily: 'Roboto',
                                fontSize: 18.0,
                                color: textColor,
                              ),
                            ),
                            plotAreaBorderWidth: 0,
                            backgroundColor: backgroundColor,
                            primaryXAxis: CategoryAxis(
                              title: AxisTitle(
                                text: 'Время',
                                textStyle: const TextStyle(
                                  color: textColor,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                            primaryYAxis: NumericAxis(
                              title: AxisTitle(
                                text:
                                    'Температура - Влажность - Скорость ветра',
                                textStyle: const TextStyle(
                                  color: textColor,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                            tooltipBehavior: TooltipBehavior(enable: true),
                            axes: [
                              NumericAxis(
                                name: 'yAsisPressure',
                                title: AxisTitle(
                                  text: 'Давление',
                                  textStyle: const TextStyle(
                                    color: textColor,
                                    fontSize: 14,
                                  ),
                                ),
                                opposedPosition: true,
                                interval: 1.0,
                              ),
                            ],
                            series: <ChartSeries>[
                              SplineSeries<MeteogramCharModel, String>(
                                name: 'Тем-ра',
                                dataSource:
                                    meteogramChartController.meteogramChartList,
                                xValueMapper: (MeteogramCharModel val, _) =>
                                    val.times,
                                yValueMapper: (MeteogramCharModel val, _) =>
                                    val.temperature,
                                pointColorMapper: (MeteogramCharModel val, _) =>
                                    val.colorPoint,
                              ),
                              SplineSeries<MeteogramCharModel, String>(
                                yAxisName: 'yAsisPressure',
                                name: 'Давление',
                                dataSource:
                                    meteogramChartController.meteogramChartList,
                                xValueMapper: (MeteogramCharModel val, _) =>
                                    val.times,
                                yValueMapper: (MeteogramCharModel val, _) =>
                                    val.pressure,
                              ),
                              SplineSeries<MeteogramCharModel, String>(
                                name: 'Влажность',
                                dataSource:
                                    meteogramChartController.meteogramChartList,
                                xValueMapper: (MeteogramCharModel val, _) =>
                                    val.times,
                                yValueMapper: (MeteogramCharModel val, _) =>
                                    val.humidity,
                              ),
                              SplineSeries<MeteogramCharModel, String>(
                                name: 'Скорость ветра',
                                dataSource:
                                    meteogramChartController.meteogramChartList,
                                xValueMapper: (MeteogramCharModel val, _) =>
                                    val.times,
                                yValueMapper: (MeteogramCharModel val, _) =>
                                    val.wind,
                              ),
                            ],
                          ),
                        ),
                      )
                    : Container();
              }
            },
          ),
        ),
      ),
    );
  }
}
