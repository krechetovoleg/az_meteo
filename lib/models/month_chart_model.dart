import 'dart:convert';

import 'package:flutter/material.dart';

List<dynamic> monthChartModelFromJson(String str) =>
    List<dynamic>.from(json.decode(str).map((x) => List<dynamic>.from(x.map((x) => x))));

class MonthChartModel {
  MonthChartModel({required this.temperature, required this.times, this.colorPoint});

  final num temperature;
  final String times;
  final Color? colorPoint;

  factory MonthChartModel.fromJson(Map<String, dynamic> json) => MonthChartModel(
        temperature: json["temperature"],
        times: json["times"],
      );
}
