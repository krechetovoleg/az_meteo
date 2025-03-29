import 'package:flutter/material.dart';
import '../models/main_model.dart';
import '../models/meteogram_chart_model.dart';
import '../models/meteogram_model.dart';
import '../models/today_chart_model.dart';
import '../models/week_chart_model.dart';
import '../models/month_chart_model.dart';
import '../models/year_chart_model.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';

class RemoteServices {
  static var client = http.Client();

  static Future<MainModel?> fetchMain() async {
    try {
      var response = await client.get(Uri.parse('https://azotirun.azot.kuzbass.net/meteo.php?link=api'));
      if (response.statusCode == 200) {
        var jsonString = response.body;

        return mainModelFromJson(jsonString);
      } else {
        Get.snackbar(
          "Ошибка!",
          "Ошибка(get api) ${response.reasonPhrase.toString()}",
          duration: const Duration(seconds: 4),
          icon: const Icon(
            Icons.error,
            color: Colors.red,
          ),
          snackPosition: SnackPosition.BOTTOM,
        );

        return null;
      }
    } catch (e) {
      Get.snackbar(
        "Ошибка!",
        "Ошибка (api) ${e.hashCode.toString()}",
        duration: const Duration(seconds: 4),
        icon: const Icon(
          Icons.error,
          color: Colors.red,
        ),
        snackPosition: SnackPosition.BOTTOM,
      );
    }

    return null;
  }

  static Future<List<dynamic>?> fetchMeteogram() async {
    try {
      var response = await client.get(Uri.parse('https://azotirun.azot.kuzbass.net/meteo.php?link=sql_meteogram'));

      if (response.statusCode == 200) {
        var jsonString = response.body;

        return meteogramModelFromJson(jsonString);
      } else {
        Get.snackbar(
          "Ошибка!",
          "Ошибка(get sql_meteogram) ${response.reasonPhrase.toString()}",
          duration: const Duration(seconds: 4),
          icon: const Icon(
            Icons.error,
            color: Colors.red,
          ),
          snackPosition: SnackPosition.BOTTOM,
        );

        return null;
      }
    } catch (e) {
      Get.snackbar(
        "Ошибка!",
        "Ошибка(sql_meteogram) ${e.hashCode.toString()}",
        duration: const Duration(seconds: 4),
        icon: const Icon(
          Icons.error,
          color: Colors.red,
        ),
        snackPosition: SnackPosition.BOTTOM,
      );
    }

    return null;
  }

  static Future<List<dynamic>?> fetchTodayChart() async {
    try {
      var response =
          await client.get(Uri.parse('https://azotirun.azot.kuzbass.net/meteo.php?link=sql_temp_today_char'));

      if (response.statusCode == 200) {
        var jsonString = response.body;

        return todayChartModelFromJson(jsonString);
      } else {
        Get.snackbar(
          "Ошибка!",
          "Ошибка (get sql_temp_today_char)${response.reasonPhrase.toString()}",
          duration: const Duration(seconds: 4),
          icon: const Icon(
            Icons.error,
            color: Colors.red,
          ),
          snackPosition: SnackPosition.BOTTOM,
        );

        return null;
      }
    } catch (e) {
      Get.snackbar(
        "Ошибка!",
        "Ошибка (sql_temp_today_char)${e.hashCode.toString()}",
        duration: const Duration(seconds: 4),
        icon: const Icon(
          Icons.error,
          color: Colors.red,
        ),
        snackPosition: SnackPosition.BOTTOM,
      );
    }

    return null;
  }

  static Future<List<dynamic>?> fetchWeekChart() async {
    try {
      var response = await client.get(Uri.parse('https://azotirun.azot.kuzbass.net/meteo.php?link=sql_temp_week_char'));

      if (response.statusCode == 200) {
        var jsonString = response.body;

        return weekChartModelFromJson(jsonString);
      } else {
        Get.snackbar(
          "Ошибка!",
          "Ошибка (get sql_temp_week_char)${response.reasonPhrase.toString()}",
          duration: const Duration(seconds: 4),
          icon: const Icon(
            Icons.error,
            color: Colors.red,
          ),
          snackPosition: SnackPosition.BOTTOM,
        );

        return null;
      }
    } catch (e) {
      Get.snackbar(
        "Ошибка!",
        "Ошибка (sql_temp_week_char)${e.hashCode.toString()}",
        duration: const Duration(seconds: 4),
        icon: const Icon(
          Icons.error,
          color: Colors.red,
        ),
        snackPosition: SnackPosition.BOTTOM,
      );
    }

    return null;
  }

  static Future<List<dynamic>?> fetchMonthChart() async {
    try {
      var response =
          await client.get(Uri.parse('https://azotirun.azot.kuzbass.net/meteo.php?link=sql_temp_month_char'));

      if (response.statusCode == 200) {
        var jsonString = response.body;

        return monthChartModelFromJson(jsonString);
      } else {
        Get.snackbar(
          "Ошибка!",
          "Ошибка (get sql_temp_month_char)${response.reasonPhrase.toString()}",
          duration: const Duration(seconds: 4),
          icon: const Icon(
            Icons.error,
            color: Colors.red,
          ),
          snackPosition: SnackPosition.BOTTOM,
        );

        return null;
      }
    } catch (e) {
      Get.snackbar(
        "Ошибка!",
        "Ошибка (sql_temp_month_char)${e.hashCode.toString()}",
        duration: const Duration(seconds: 4),
        icon: const Icon(
          Icons.error,
          color: Colors.red,
        ),
        snackPosition: SnackPosition.BOTTOM,
      );
    }

    return null;
  }

  static Future<List<dynamic>?> fetchYearChart() async {
    try {
      var response = await client.get(Uri.parse('https://azotirun.azot.kuzbass.net/meteo.php?link=sql_temp_year_char'));

      if (response.statusCode == 200) {
        var jsonString = response.body;

        return yearChartModelFromJson(jsonString);
      } else {
        Get.snackbar(
          "Ошибка!",
          "Ошибка (get sql_temp_year_char)${response.reasonPhrase.toString()}",
          duration: const Duration(seconds: 4),
          icon: const Icon(
            Icons.error,
            color: Colors.red,
          ),
          snackPosition: SnackPosition.BOTTOM,
        );

        return null;
      }
    } catch (e) {
      Get.snackbar(
        "Ошибка!",
        "Ошибка (sql_temp_year_char)${e.hashCode.toString()}",
        duration: const Duration(seconds: 4),
        icon: const Icon(
          Icons.error,
          color: Colors.red,
        ),
        snackPosition: SnackPosition.BOTTOM,
      );
    }

    return null;
  }

  static Future<List<dynamic>?> fetchMeteogramChart() async {
    try {
      var response = await client.get(Uri.parse('https://azotirun.azot.kuzbass.net/meteo.php?link=sql_meteogram'));

      if (response.statusCode == 200) {
        var jsonString = response.body;

        return meteogramChartModelFromJson(jsonString);
      } else {
        Get.snackbar(
          "Ошибка!",
          "Ошибка(get sql_meteogram) ${response.reasonPhrase.toString()}",
          duration: const Duration(seconds: 4),
          icon: const Icon(
            Icons.error,
            color: Colors.red,
          ),
          snackPosition: SnackPosition.BOTTOM,
        );

        return null;
      }
    } catch (e) {
      Get.snackbar(
        "Ошибка!",
        "Ошибка(sql_meteogram) ${e.hashCode.toString()}",
        duration: const Duration(seconds: 4),
        icon: const Icon(
          Icons.error,
          color: Colors.red,
        ),
        snackPosition: SnackPosition.BOTTOM,
      );
    }

    return null;
  }
}
