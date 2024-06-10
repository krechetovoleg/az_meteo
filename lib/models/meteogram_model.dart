import 'dart:convert';

List<dynamic> meteogramModelFromJson(String str) =>
    List<dynamic>.from(json.decode(str).map((x) => List<dynamic>.from(x.map((x) => x))));

class MeteogramModel {
  MeteogramModel({
    required this.temperature,
    required this.humidity,
    required this.pressure,
    required this.wind,
    required this.directionWind,
    required this.times,
  });

  List temperature;
  List humidity;
  List pressure;
  List wind;
  List directionWind;
  List times;

  factory MeteogramModel.fromJson(Map<String, dynamic> json) => MeteogramModel(
        temperature: json["temperature"],
        humidity: json["humidity"],
        pressure: json["pressure"],
        wind: json["wind"],
        directionWind: json["directionWind"],
        times: json["times"],
      );
}
