import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/week_chart_model.dart';
import '../services/remote_services.dart';

class WeekChartController extends GetxController {
  var weekChartList = <WeekChartModel>[].obs;
  num maxx = 0;
  num minn = 0;
  var isLoading = true.obs;

  @override
  void onInit() {
    fetchWeekChartData();
    super.onInit();
  }

  void fetchWeekChartData() async {
    List<num> lN = [];
    List<String> lS = [];
    int i = 0;

    try {
      isLoading.value = true;
      var weekChartModel = await RemoteServices.fetchWeekChart();
      if (weekChartModel != null) {
        weekChartModel[0].forEach((e) {
          lN.add(e);
        });
        weekChartModel[1].forEach((e) {
          lS.add(e.toString());
        });

        weekChartModel.clear();
        while (i < lN.length) {
          weekChartList.insert(
            i,
            WeekChartModel(
              temperature: lN[i],
              times: lS[i],
              colorPoint: lN[i] > 0 ? Colors.red : Colors.blue,
            ),
          );
          i++;
        }
        maxx = lN.reduce((value, element) => value > element ? value : element);
        minn = lN.reduce((value, element) => value < element ? value : element);
      }
    } finally {
      isLoading.value = false;
    }
  }
}
