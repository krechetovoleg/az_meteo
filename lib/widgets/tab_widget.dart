import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../theme/theme.dart';
import '../controllers/color_controller.dart';
import '../widgets/datatable_widget.dart';
import '../widgets/meteogram_chart_widget.dart';

class TabWidget extends StatefulWidget {
  const TabWidget({super.key});

  @override
  State<TabWidget> createState() => _TabWidgetState();
}

class _TabWidgetState extends State<TabWidget> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  var mainBorderColor = Get.put(ColorController());

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      vsync: this,
      length: 2,
    );
    mainBorderColor = Get.put(ColorController());
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Card(
      color: backgroundColor,
      shape: RoundedRectangleBorder(
        side: BorderSide(
          color: mainBorderColor.bColor,
          width: 2,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          const Text(
            'Суточные метеоданные',
            style: TextStyle(
              fontSize: 18.0,
              color: textColor,
            ),
          ),
          SizedBox(
            height: 40,
            child: TabBar(
              indicatorColor: mainBorderColor.bColor,
              indicatorSize: TabBarIndicatorSize.tab,
              indicatorWeight: 2,
              dividerColor: mainBorderColor.bColor,
              controller: _tabController,
              tabs: const [
                ImageIcon(
                  AssetImage('assets/images/white/database.png'),
                  size: 22.0,
                  color: textColor,
                ),
                ImageIcon(
                  AssetImage('assets/images/white/line-chart.png'),
                  size: 22.0,
                  color: textColor,
                ),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                DataTableWidget(),
                MeteogramWidget(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
