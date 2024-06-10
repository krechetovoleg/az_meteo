import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/year_chart_model.dart';
import '../services/remote_services.dart';

class YearChartController extends GetxController {
  var yearChartList = <YearChartModel>[].obs;
  num maxx = 0;
  num minn = 0;
  var isLoading = true.obs;

  @override
  void onInit() {
    fetchYearChartData();
    super.onInit();
  }

  void fetchYearChartData() async {
    List<num> lN = [];
    List<String> lS = [];
    int i = 0;

    try {
      isLoading.value = true;
      var yearChartModel = await RemoteServices.fetchYearChart();
      if (yearChartModel != null) {
        yearChartModel[0].forEach((e) {
          lN.add(e);
        });
        yearChartModel[1].forEach((e) {
          lS.add(e.toString());
        });

        yearChartModel.clear();
        while (i < lN.length) {
          yearChartList.insert(
            i,
            YearChartModel(
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
