import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:power_project_dashboard/app_constants.dart';
import 'package:power_project_dashboard/components/project_card.dart';
import 'package:power_project_dashboard/components/sidebar.dart';
import 'package:power_project_dashboard/controllers/main_controller.dart';
import 'package:power_project_dashboard/screens/home_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  MainController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white10,
      body: Row(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 3,
            child: Sidebar(
              data: ProjectCardData(
                percent: .3,
                projectImage: const AssetImage(ImageRasterPath.logo1),
                projectName: "Power app\nDashboard",
                releaseTime: DateTime.now(),
              ),
            ),
          ),
          // VerticalDivider(
          //   color: Colors.black,
          // ),
          Expanded(
            flex: 9,
            child: Column(
              children: [
                HomeScreen(
                  data: controller.selectedHomeData.value,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
