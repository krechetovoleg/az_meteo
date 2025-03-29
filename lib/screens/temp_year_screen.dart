import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../controllers/color_controller.dart';
import '../theme/theme.dart';
import '../controllers/year_chart_controller.dart';
import '../models/year_chart_model.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class YearScreen extends StatefulWidget {
  const YearScreen({super.key});

  @override
  State<YearScreen> createState() => _YearScreenState();
}

class _YearScreenState extends State<YearScreen> {
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
    final YearChartController yearChartController =
        Get.put(YearChartController());
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
              if (yearChartController.isLoading.value) {
                return Center(
                  child: const CircularProgressIndicator().reactive(),
                );
              } else {
                return yearChartController.yearChartList.isNotEmpty
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
                                  'График t°C за год\r\nmax : ${yearChartController.maxx} min : ${yearChartController.minn}',
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
                              SplineSeries<YearChartModel, String>(
                                dataSource: yearChartController.yearChartList,
                                xValueMapper: (YearChartModel val, _) =>
                                    val.times,
                                yValueMapper: (YearChartModel val, _) =>
                                    val.temperature,
                                pointColorMapper: (YearChartModel val, _) =>
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
