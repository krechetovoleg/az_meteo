import 'package:get/get.dart';
import '../models/meteogram_model.dart';
import '../services/remote_services.dart';

class MeteogramController extends GetxController {
  var meteogramList = <MeteogramModel>[].obs;
  List<Map<String, dynamic>> meteo = [];
  var isLoading = true.obs;

  @override
  void onInit() {
    fetchMeteogramData();
    super.onInit();
  }

  void fetchMeteogramData() async {
    try {
      isLoading.value = true;
      var meteogramModel = await RemoteServices.fetchMeteogram();
      if (meteogramModel != null) {
        meteogramList.clear();
        meteogramList.add(MeteogramModel(
          temperature: meteogramModel[0],
          humidity: meteogramModel[1],
          pressure: meteogramModel[2],
          wind: meteogramModel[3],
          directionWind: meteogramModel[4],
          times: meteogramModel[5],
        ));

        int i = 0;
        meteo.clear();
        while (i < meteogramList[0].temperature.length) {
          Map<String, dynamic> map = {
            'temperature': '',
            'humidity': '',
            'pressure': '',
            'wind': '',
            'directionWind': '',
            'times': '',
          };
          map['temperature'] = meteogramList[0].temperature[i];
          map['humidity'] = meteogramList[0].humidity[i];
          map['pressure'] = meteogramList[0].pressure[i];
          map['wind'] = meteogramList[0].wind[i];
          map['times'] = meteogramList[0].times[i];

          meteo.insert(i, map);

          i++;
        }
      }
    } finally {
      isLoading.value = false;
    }
  }
}
