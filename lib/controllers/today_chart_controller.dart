import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/today_chart_model.dart';
import '../services/remote_services.dart';

class TodayChartController extends GetxController {
  var todayChartList = <TodayChartModel>[].obs;
  num maxx = 0;
  num minn = 0;
  var isLoading = true.obs;

  @override
  void onInit() {
    fetchTodayChartData();
    super.onInit();
  }

  void fetchTodayChartData() async {
    List<num> lN = [];
    List<String> lS = [];
    int i = 0;

    try {
      isLoading.value = true;
      var todayChartModel = await RemoteServices.fetchTodayChart();
      if (todayChartModel != null) {
        todayChartModel[0].forEach((e) {
          lN.add(e);
        });
        todayChartModel[1].forEach((e) {
          lS.add(e.toString());
        });

        todayChartList.clear();
        while (i < lN.length) {
          todayChartList.insert(
            i,
            TodayChartModel(
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
