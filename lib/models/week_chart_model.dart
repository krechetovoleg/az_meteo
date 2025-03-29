import 'dart:convert';

import 'package:flutter/material.dart';

List<dynamic> weekChartModelFromJson(String str) =>
    List<dynamic>.from(json.decode(str).map((x) => List<dynamic>.from(x.map((x) => x))));

class WeekChartModel {
  WeekChartModel({
    required this.temperature,
    required this.times,
    this.colorPoint,
  });

  final num temperature;
  final String times;
  final Color? colorPoint;

  factory WeekChartModel.fromJson(Map<String, dynamic> json) => WeekChartModel(
        temperature: json["temperature"],
        times: json["times"],
      );
}
