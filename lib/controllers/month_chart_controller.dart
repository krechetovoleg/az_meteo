import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/month_chart_model.dart';
import '../services/remote_services.dart';

class MonthChartController extends GetxController {
  var monthChartList = <MonthChartModel>[].obs;
  num maxx = 0;
  num minn = 0;
  var isLoading = true.obs;

  @override
  void onInit() {
    fetchMonthChartData();
    super.onInit();
  }

  void fetchMonthChartData() async {
    List<num> lN = [];
    List<String> lS = [];
    int i = 0;

    try {
      isLoading.value = true;
      var monthChartModel = await RemoteServices.fetchMonthChart();
      if (monthChartModel != null) {
        monthChartModel[0].forEach((e) {
          lN.add(e);
        });
        monthChartModel[1].forEach((e) {
          lS.add(e.toString());
        });

        monthChartList.clear();
        while (i < lN.length) {
          monthChartList.insert(
            i,
            MonthChartModel(
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
