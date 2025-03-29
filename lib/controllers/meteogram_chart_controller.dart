import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/meteogram_chart_model.dart';
import '../services/remote_services.dart';

class MeteogramChartController extends GetxController {
  var meteogramChartList = <MeteogramCharModel>[].obs;
  List<Map<String, dynamic>> meteo = [];
  var isLoading = true.obs;
  num maxx = 0;
  num minn = 0;

  @override
  void onInit() {
    fetchMeteogramChartData();
    super.onInit();
  }

  void fetchMeteogramChartData() async {
    List<num> lTemperature = [];
    List<num> lHumidity = [];
    List<num> lPressure = [];
    List<num> lWind = [];
    List<num> lDirectionWind = [];
    List<String> lTimes = [];

    try {
      isLoading.value = true;
      var meteogramChartModel = await RemoteServices.fetchMeteogramChart();
      if (meteogramChartModel != null) {
        meteogramChartModel[0].forEach((e) {
          lTemperature.add(e);
        });

        meteogramChartModel[1].forEach((e) {
          lHumidity.add(e);
        });

        meteogramChartModel[2].forEach((e) {
          lPressure.add(e);
        });

        meteogramChartModel[3].forEach((e) {
          lWind.add(e);
        });

        meteogramChartModel[4].forEach((e) {
          lDirectionWind.add(e);
        });

        meteogramChartModel[5].forEach((e) {
          lTimes.add(e.toString());
        });

        int i = 0;
        meteogramChartList.clear();
        while (i < lTemperature.length) {
          meteogramChartList.insert(
            i,
            MeteogramCharModel(
              temperature: lTemperature[i],
              humidity: lHumidity[i],
              pressure: lPressure[i],
              wind: lWind[i],
              directionWind: lDirectionWind[i],
              times: lTimes[i],
              colorPoint: lTemperature[i] > 0 ? Colors.red : Colors.blue,
            ),
          );
          i++;
        }
        maxx = lTemperature.reduce((value, element) => value > element ? value : element);
        minn = lTemperature.reduce((value, element) => value < element ? value : element);
      }
    } finally {
      isLoading.value = false;
    }
  }
}
