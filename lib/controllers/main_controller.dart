import '../models/main_model.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/get_rx/get_rx.dart';
import '../services/remote_services.dart';
import 'dart:math' as math;

class MainController extends GetxController {
  var mainList = <MainResponse>[].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    fetchMainData();
    super.onInit();
  }

  void fetchMainData() async {
    try {
      isLoading.value = true;
      var mainModel = await RemoteServices.fetchMain();
      if (mainModel != null) {
        mainList.clear();
        mainList.add(MainResponse(
          whens: mainModel.response.whens,
          temperature: mainModel.response.temperature,
          humidity: mainModel.response.humidity,
          pressure: mainModel.response.pressure,
          pointWind: mainModel.response.pointWind,
          wind: mainModel.response.wind,
          directionWind: mainModel.response.directionWind,
        ));
      }
    } finally {
      isLoading.value = false;
    }
  }

  String redDirectionWind(String directionWind) {
    String dw = '';
    switch (directionWind.replaceAll('"', '')) {
      case 'северный':
        dw = 'С';
        break;
      case 'северо-восточный':
        dw = 'СВ';
        break;
      case 'восточный':
        dw = 'В';
        break;
      case 'юго-восточный':
        dw = 'ЮВ';
        break;
      case 'южный':
        dw = 'Ю';
        break;
      case 'юго-западный':
        dw = 'ЮЗ';
        break;
      case 'западный':
        dw = 'З';
        break;
      case 'северо-западный':
        dw = 'СЗ';
        break;
      default:
        dw = '';
    }

    return dw;
  }

  String feelsLike(double temp, double wind) {
    num v10 = 1.5 * wind;
    num vv = math.pow(v10, 0.16);
    num twc = 13.12 + 0.6215 * temp - 11.37 * vv + 0.3965 * temp * vv;

    return 'Ощущается как: ${twc.toStringAsFixed(2)} °C';
  }
}
