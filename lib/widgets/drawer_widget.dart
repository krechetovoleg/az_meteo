import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';
import '../screens/app_setting_screen.dart';
import '../screens/meteogram_chart_screen.dart';
import '../screens/temp_today_screen.dart';
import '../screens/temp_week_screen.dart';
import '../screens/temp_month_screen.dart';
import '../screens/temp_year_screen.dart';
import '../theme/theme.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: const Color.fromRGBO(26, 44, 60, 0.95),
      child: ListView(
        children: [
          const DrawerHeader(
            child: Center(
              child: Image(
                image: AssetImage('assets/images/weather-app.png'),
                height: 80.0,
                width: 80.0,
              ),
            ),
          ),
          ListTile(
            title: const Text(
              'Суточная метеограмма',
              style: TextStyle(
                fontSize: 20.0,
                color: textColor,
              ),
            ),
            onTap: () {
              Get.to(const MeteogramScreen());
              Scaffold.of(context).openEndDrawer();
            },
          ),
          ListTile(
            title: const Text(
              'График t°C за сегодня',
              style: TextStyle(
                fontSize: 20.0,
                color: textColor,
              ),
            ),
            onTap: () {
              Get.to(const ToDayScreen());
              Scaffold.of(context).openEndDrawer();
            },
          ),
          ListTile(
            title: const Text(
              'График t°C за неделю',
              style: TextStyle(
                fontSize: 20.0,
                color: textColor,
              ),
            ),
            onTap: () {
              Get.to(const WeekScreen());
              Scaffold.of(context).openEndDrawer();
            },
          ),
          ListTile(
            title: const Text(
              'График t°C за месяц',
              style: TextStyle(
                fontSize: 20.0,
                color: textColor,
              ),
            ),
            onTap: () {
              Get.to(const MonthScreen());
              Scaffold.of(context).openEndDrawer();
            },
          ),
          ListTile(
            title: const Text(
              'График t°C за год',
              style: TextStyle(
                fontSize: 20.0,
                color: textColor,
              ),
            ),
            onTap: () {
              Get.to(const YearScreen());
              Scaffold.of(context).openEndDrawer();
            },
          ),
          const Divider(
            color: textColor,
          ),
          ListTile(
            title: const Text(
              'Настройки',
              style: TextStyle(
                fontSize: 20.0,
                color: textColor,
              ),
            ),
            onTap: () {
              Get.to(const AppSettingScreen());
              Scaffold.of(context).openEndDrawer();
            },
          ),
        ],
      ),
    );
  }
}
