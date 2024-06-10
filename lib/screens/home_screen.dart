import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../controllers/main_controller.dart';
import '../controllers/meteogram_controller.dart';
import '../widgets/card_widgets.dart';
import '../widgets/drawer_widget.dart';
import '../theme/theme.dart';
import '../widgets/tab_widget.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  @override
  void initState() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double widthScreen = Get.width;
    MainController mainController = Get.put(MainController());
    MeteogramController meteogramController = Get.put(MeteogramController());

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: backgroundColor,
        iconTheme: const IconThemeData(color: textColor),
        title: const Text(
          'AzMeteo',
          style: TextStyle(
            fontFamily: 'Roboto',
            fontSize: 26,
            color: textColor,
          ),
        ),
        actions: [
          GestureDetector(
            child: IconButton(
              onPressed: (() async {
                mainController.fetchMainData();
                meteogramController.fetchMeteogramData();
              }),
              icon: const Icon(Icons.refresh,),
            ),
          ),
        ],
      ),
      drawer: const DrawerWidget(),
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Obx(() {
          if (mainController.isLoading.value && meteogramController.isLoading.value) {
            return Center(
              child: const CircularProgressIndicator().reactive(),
            );
          } else {
            return mainController.mainList.isNotEmpty && meteogramController.meteo.isNotEmpty
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 20,
                        child: CardWidget(
                          topStr: '${mainController.mainList[0].temperature} °C',
                          topSize: 36.0,
                          centerStr: mainController.feelsLike(
                            mainController.mainList[0].temperature,
                            mainController.mainList[0].wind,
                          ),
                          centerSize: 18.0,
                          bottomStr: mainController.mainList[0].whens.replaceAll('"', ''),
                          bottomSize: 14.0,
                          width: double.infinity,
                        ),
                      ),
                      Expanded(
                        flex: 15,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Expanded(
                              flex: 1,
                              child: CardWidgetSmall(
                                topStr: 'assets/images/pressure.png',
                                topSize: 24.0,
                                bottomStr: mainController.mainList[0].pressure.toString(),
                                bottomSize: 18,
                                width: (widthScreen * 0.28).roundToDouble(),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: CardWidgetSmall(
                                topStr: 'assets/images/humidity.png',
                                topSize: 24.0,
                                bottomStr: mainController.mainList[0].humidity.toString(),
                                bottomSize: 18,
                                width: (widthScreen * 0.28).roundToDouble(),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: CardWidgetSmall(
                                topStr: 'assets/images/wind.png',
                                topSize: 24.0,
                                bottomStr: '${mainController.mainList[0].wind} ${mainController.redDirectionWind(mainController.mainList[0].directionWind)}',

                                bottomSize: 18,
                                width: (widthScreen * 0.28).roundToDouble(),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Expanded(
                        flex: 65,
                        child: TabWidget(),
                      ),
                    ],
                  )
                : Container();
          }
        }),
      ),
    );
  }
}
