import 'dart:convert';

import 'package:flutter/material.dart';

List<dynamic> meteogramChartModelFromJson(String str) =>
    List<dynamic>.from(json.decode(str).map((x) => List<dynamic>.from(x.map((x) => x))));

class MeteogramCharModel {
  MeteogramCharModel({
    required this.temperature,
    required this.humidity,
    required this.pressure,
    required this.wind,
    required this.directionWind,
    required this.times,
    this.colorPoint,
  });

  num temperature;
  num humidity;
  num pressure;
  num wind;
  num directionWind;
  String times;
  final Color? colorPoint;

  factory MeteogramCharModel.fromJson(Map<String, dynamic> json) => MeteogramCharModel(
        temperature: json["temperature"],
        humidity: json["humidity"],
        pressure: json["pressure"],
        wind: json["wind"],
        directionWind: json["directionWind"],
        times: json["times"],
      );
}
