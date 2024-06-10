import 'dart:convert';

import 'package:flutter/material.dart';

List<dynamic> yearChartModelFromJson(String str) =>
    List<dynamic>.from(json.decode(str).map((x) => List<dynamic>.from(x.map((x) => x))));

class YearChartModel {
  YearChartModel({
    required this.temperature,
    required this.times,
    this.colorPoint,
  });

  final num temperature;
  final String times;
  final Color? colorPoint;

  factory YearChartModel.fromJson(Map<String, dynamic> json) => YearChartModel(
        temperature: json["temperature"],
        times: json["times"],
      );
}
