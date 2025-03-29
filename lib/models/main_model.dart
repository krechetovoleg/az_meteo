import 'dart:convert';

MainModel mainModelFromJson(String str) => MainModel.fromJson(json.decode(str));

class MainModel {
  MainModel({
    required this.response,
  });

  MainResponse response;

  factory MainModel.fromJson(Map<String, dynamic> json) => MainModel(
        response: MainResponse.fromJson(json["response"]),
      );
}

class MainResponse {
  MainResponse({
    required this.whens,
    required this.temperature,
    required this.humidity,
    required this.pressure,
    required this.pointWind,
    required this.wind,
    required this.directionWind,
  });

  String whens;
  double temperature;
  double humidity;
  double pressure;
  String pointWind;
  double wind;
  String directionWind;

  factory MainResponse.fromJson(Map<String, dynamic> json) => MainResponse(
        whens: json["whens"],
        temperature: json["temperature"].toDouble(),
        humidity: json["humidity"].toDouble(),
        pressure: json["pressure"].toDouble(),
        pointWind: json["pointWind"],
        wind: json["wind"].toDouble(),
        directionWind: json["directionWind"],
      );

  Map<String, dynamic> toJson() => {
        "whens": whens,
        "temperature": temperature,
        "humidity": humidity,
        "pressure": pressure,
        "pointWind": pointWind,
        "wind": wind,
        "directionWind": directionWind,
      };
}
