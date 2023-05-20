import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:power_project_dashboard/app_constants.dart';
import 'package:power_project_dashboard/screens/home_screen.dart';

class MainController extends GetxController {
  var selectedHome = 0.obs;
  var selectedHomeData = HomeData(title: "Home 1").obs;
  var loading = false.obs;

  var itemList = [].obs;

  var totalPowerDateList = [].obs;

  var dateList = [].obs;
  var maxValue = 0.obs;

  var touchedIndex = -1.obs;
  var touchedIndexPie = -1.obs;

  Future<void> onHomeCardPress(int index, String label) async {
    selectedHome.value = index;
    selectedHomeData.value.title = label;
    generatePast7Days();
    getDevicesList();
    getTotalPowerDateList();

    await Future.delayed(Duration(seconds: 3));
  }

  List<String> monthList = [
    "January",
    "February",
    "March",
    "April",
    "May",
    "June",
    "July",
    "August",
    "Septemebr",
    "October",
    "November",
    "December",
  ];

  void test() {
    generatePast7Days();
  }

  void getDevicesList() {
    itemList.value = [
      DeviceData(
        image: ImageRasterPath.logo1,
        description: "CFL bulb\n11w, 0.26A",
        devices: 1 + selectedHome.value * 2,
        percentage: 38,
        date: "2021.05.29",
      ),
      DeviceData(
        image: ImageRasterPath.logo1,
        description: "CFL bulb\n11w, 0.26A",
        devices: 1 + selectedHome.value * 2,
        percentage: 38,
        date: "2021.05.29",
      ),
      DeviceData(
        image: ImageRasterPath.logo1,
        description: "CFL bulb\n11w, 0.26A",
        devices: 1 + selectedHome.value * 2,
        percentage: 38,
        date: "2021.05.29",
      ),
      DeviceData(
        image: ImageRasterPath.logo1,
        description: "CFL bulb\n11w, 0.26A",
        devices: 1 + selectedHome.value * 2,
        percentage: 38,
        date: "2021.05.29",
      ),
      DeviceData(
        image: ImageRasterPath.logo1,
        description: "CFL bulb\n11w, 0.26A",
        devices: 1 + selectedHome.value * 2,
        percentage: 38,
        date: "2021.05.29",
      ),
      DeviceData(
        image: ImageRasterPath.logo1,
        description: "CFL bulb\n11w, 0.26A",
        devices: 1,
        percentage: 38,
        date: "2021.05.29",
      ),
      DeviceData(
        image: ImageRasterPath.logo1,
        description: "CFL bulb\n11w, 0.26A",
        devices: 1,
        percentage: 38,
        date: "2021.05.29",
      ),
      // DeviceData(
      //   image: ImageRasterPath.logo1,
      //   description: "CFL bulb\n11w, 0.26A",
      //   devices: 1,
      //   percentage: 38,
      //   date: "2021.05.29",
      // ),
      // DeviceData(
      //   image: ImageRasterPath.logo1,
      //   description: "CFL bulb\n11w, 0.26A",
      //   devices: 1,
      //   percentage: 38,
      //   date: "2021.05.29",
      // ),
      // DeviceData(
      //   image: ImageRasterPath.logo1,
      //   description: "CFL bulb\n11w, 0.26A",
      //   devices: 1,
      //   percentage: 38,
      //   date: "2021.05.29",
      // ),
    ];
  }

  List<Color> get availableColors => <Color>[
        Color(0xFF6E1BFF),
        Color(0xFFFFC300),
        Color(0xFF2196F3),
        Color(0xFFFF683B),
        Color(0xFFFF3AF2),
        Color(0xFFE80054),
        Color(0xFFAAE800),
        Color(0xFF00D9E8),
        Color(0xFF6E1BFF).withOpacity(0.5),
        Color(0xFFFFC300).withOpacity(0.5),
        Color(0xFF2196F3).withOpacity(0.5),
        Color(0xFFFF683B).withOpacity(0.5),
        Color(0xFFFF3AF2).withOpacity(0.5),
        Color(0xFFE80054).withOpacity(0.5),
        Color(0xFFAAE800).withOpacity(0.5),
        Color(0xFF00D9E8).withOpacity(0.5),
        Color(0xFF31045A),
        Color(0xFF7C5F00),
        Color(0xFF034379),
        Color(0xFF72220A),
        Color(0xFF61075B),
        Color(0xFF660428),
        Color(0xFF405703),
        Color(0xFF055B61).withOpacity(0.5),
        Color(0xFF31045A).withOpacity(0.5),
        Color(0xFF7C5F00).withOpacity(0.5),
        Color(0xFF034379).withOpacity(0.5),
        Color(0xFF72220A).withOpacity(0.5),
        Color(0xFF61075B).withOpacity(0.5),
        Color(0xFF660428).withOpacity(0.5),
        Color(0xFF405703).withOpacity(0.5),
        Color(0xFF055B61).withOpacity(0.5),
      ];

  void getTotalPowerDateList() {
    totalPowerDateList.value = [];

    totalPowerDateList.value.add({
      "Device": "Fan",
      "Percentage": 37 + selectedHome.value,
      "Description": "65W",
      "Color": availableColors[0],
    });
    totalPowerDateList.value.add({
      "Device": "Incandescent",
      "Percentage": 14 - selectedHome.value,
      "Description": "60W",
      "Color": availableColors[1],
    });
    totalPowerDateList.value.add({
      "Device": "LED",
      "Percentage": 7,
      "Description": "2W",
      "Color": availableColors[2],
    });
    totalPowerDateList.value.add({
      "Device": "CFL",
      "Percentage": 4,
      "Description": "11W",
      "Color": availableColors[3],
    });
    totalPowerDateList.value.add({
      "Device": "TV",
      "Percentage": 22,
      "Description": "47W",
      "Color": availableColors[4],
    });
    totalPowerDateList.value.add({
      "Device": "Router",
      "Percentage": 21,
      "Description": "15W",
      "Color": availableColors[5],
    });
  }

  void generatePast7Days() {
    dateList.value = [];
    for (var i = 0; i < 7; i++) {
      DateTime now = new DateTime.now().subtract(Duration(days: i));
      DateTime date = new DateTime(now.year, now.month, now.day);
      print(selectedHome.value);
      int v = i + 5 + selectedHome.value * 2;
      dateList.add({
        "month": monthList[date.month - 1],
        "day": date.day.toString(),
        "value": v,
      });

      if (v > maxValue.value) {
        maxValue.value = v;
      }
    }
    print(dateList);
  }

  @override
  void onInit() {
    super.onInit();
    onHomeCardPress(0, "Home 1");
  }
}
