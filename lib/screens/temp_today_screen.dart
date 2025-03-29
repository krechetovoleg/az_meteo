import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../theme/theme.dart';
import '../controllers/today_chart_controller.dart';
import '../models/today_chart_model.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../controllers/color_controller.dart';

class ToDayScreen extends StatefulWidget {
  const ToDayScreen({super.key});

  @override
  State<ToDayScreen> createState() => _ToDayScreenState();
}

class _ToDayScreenState extends State<ToDayScreen> {
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
    final TodayChartController todayChartController =
        Get.put(TodayChartController());
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
              if (todayChartController.isLoading.value) {
                return Center(
                  child: const CircularProgressIndicator().reactive(),
                );
              } else {
                return todayChartController.todayChartList.isNotEmpty
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
                                  'График t°C за сегодня\r\nmax : ${todayChartController.maxx} min : ${todayChartController.minn}',
                              textStyle: const TextStyle(
                                  fontFamily: 'ChakraPetch',
                                  fontSize: 18.0,
                                  color: textColor),
                            ),
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
                              SplineSeries<TodayChartModel, String>(
                                dataSource: todayChartController.todayChartList,
                                xValueMapper: (TodayChartModel val, _) =>
                                    val.times,
                                yValueMapper: (TodayChartModel val, _) =>
                                    val.temperature,
                                pointColorMapper: (TodayChartModel val, _) =>
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
