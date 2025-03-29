import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../theme/theme.dart';
import '../controllers/month_chart_controller.dart';
import '../models/month_chart_model.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../controllers/color_controller.dart';

class MonthScreen extends StatefulWidget {
  const MonthScreen({super.key});

  @override
  State<MonthScreen> createState() => _MonthScreenState();
}

class _MonthScreenState extends State<MonthScreen> {
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
    final MonthChartController monthChartController =
        Get.put(MonthChartController());
    var mainBorderColor = Get.put(ColorController());
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
              if (monthChartController.isLoading.value) {
                return Center(
                  child: const CircularProgressIndicator().reactive(),
                );
              } else {
                return monthChartController.monthChartList.isNotEmpty
                    ? Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                  color:
                                      mainBorderColor.bColor.withOpacity(0.5),
                                  spreadRadius: 2,
                                  blurRadius: 100),
                            ]),
                        width: (widthScreen * 0.99).roundToDouble(),
                        child: Card(
                          color: backgroundColor,
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                                color: mainBorderColor.bColor, width: 2),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: SfCartesianChart(
                            crosshairBehavior: CrosshairBehavior(
                                enable: true,
                                activationMode: ActivationMode.longPress),
                            zoomPanBehavior: zoomPanBehavior,
                            title: ChartTitle(
                              text:
                                  'График t°C за месяц\r\nmax : ${monthChartController.maxx} min : ${monthChartController.minn}',
                              textStyle: const TextStyle(
                                  fontFamily: 'ChakraPetch',
                                  fontSize: 18.0,
                                  color: textColor),
                            ),
                            plotAreaBorderWidth: 0,
                            backgroundColor: backgroundColor,
                            primaryXAxis: const CategoryAxis(
                              title: AxisTitle(
                                text: 'Время',
                                textStyle:
                                    TextStyle(color: textColor, fontSize: 14),
                              ),
                            ),
                            primaryYAxis: const NumericAxis(
                              title: AxisTitle(
                                text: 'Температура',
                                textStyle:
                                    TextStyle(color: textColor, fontSize: 14),
                              ),
                            ),
                            tooltipBehavior: TooltipBehavior(
                                enable: true, header: 'Время : Температура'),
                            series: <CartesianSeries>[
                              SplineSeries<MonthChartModel, String>(
                                dataSource: monthChartController.monthChartList,
                                xValueMapper: (MonthChartModel val, _) =>
                                    val.times,
                                yValueMapper: (MonthChartModel val, _) =>
                                    val.temperature,
                                pointColorMapper: (MonthChartModel val, _) =>
                                    val.colorPoint,
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
