import 'dart:convert';

import 'package:flutter/material.dart';

List<dynamic> todayChartModelFromJson(String str) =>
    List<dynamic>.from(json.decode(str).map((x) => List<dynamic>.from(x.map((x) => x))));

class TodayChartModel {
  TodayChartModel({
    required this.temperature,
    required this.times,
    this.colorPoint,
  });

  final num temperature;
  final String times;
  final Color? colorPoint;

  factory TodayChartModel.fromJson(Map<String, dynamic> json) => TodayChartModel(
        temperature: json["temperature"],
        times: json["times"],
      );
}
