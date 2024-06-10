import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../theme/theme.dart';
import '../controllers/meteogram_chart_controller.dart';
import '../models/meteogram_chart_model.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../controllers/color_controller.dart';

class MeteogramWidget extends StatelessWidget {
  MeteogramWidget({super.key});

  final MeteogramChartController meteogramChartController =
      Get.put(MeteogramChartController());
  final mainBorderColor = Get.put(ColorController());

  final zoomPanBehavior = ZoomPanBehavior(
    enablePinching: true,
  );

  @override
  Widget build(BuildContext context) {
    return Center(
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
                    width: (Get.width * 0.99).roundToDouble(),
                    child: Card(
                      color: backgroundColor,
                      child: SfCartesianChart(
                        legend: Legend(
                          isVisible: true,
                          textStyle:
                              const TextStyle(color: textColor, fontSize: 10.0),
                          position: LegendPosition.bottom,
                          overflowMode: LegendItemOverflowMode.wrap,
                        ),
                        crosshairBehavior: CrosshairBehavior(
                          enable: true,
                          activationMode: ActivationMode.longPress,
                        ),
                        zoomPanBehavior: zoomPanBehavior,
                        plotAreaBorderWidth: 0,
                        backgroundColor: backgroundColor,
                        primaryXAxis: CategoryAxis(
                          title: AxisTitle(
                            text: 'Время',
                            textStyle:
                                const TextStyle(color: textColor, fontSize: 10),
                          ),
                        ),
                        primaryYAxis: NumericAxis(
                          title: AxisTitle(
                            text: 'Температура - Влажность - Скорость ветра',
                            textStyle:
                                const TextStyle(color: textColor, fontSize: 10),
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
                                fontSize: 10,
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
    );
  }
}
