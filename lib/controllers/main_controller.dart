import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:power_project_dashboard/app_constants.dart';
import 'package:power_project_dashboard/screens/home_screen.dart';

class MainController extends GetxController {
  // Selected Home data
  var selectedHome = 0.obs;
  var selectedHomeData = HomeData(title: "Home 1", address: "Address 1").obs;

  // Loading on sidebar homecard on pressed
  // TODO : Date on select
  var loading = false.obs;

  // Device list displayed on home screen
  var itemList = [].obs;

  //
  var totalPowerDateList = [].obs;

  var dateList = [].obs;
  var maxValue = 0.obs;

  var touchedIndex = -1.obs;
  var touchedIndexPie = -1.obs;
  var selectedDate = DateTime.now().obs;

  var database = {}.obs;

  var selectedHomeDeviceListOnDate = [].obs;

  var totalItems = 0.obs;

  @override
  Future<void> onInit() async {
    super.onInit();
  }

  Future<void> getData() async {
    final ref = FirebaseDatabase.instance.ref();
    final snapshot = await ref.child('database').get();
    if (snapshot.exists) {
      // {Home1: {S1: {Appliance: CFL, Date: 2023-05-30, Energy: 12}, S2: {Appliance: Heater, Date: 2023-05-30, Energy: 23}}, Home2: {S1: {Appliance: CFL, Date: 2023-05-30, Energy: 12}, S2: {Appliance: CFL, Date: 2023-05-30, Energy: 12}, S3: {Appliance: Heater, Date: 2023-05-30, Energy: 23}}, Home3: {S1: {Appliance: CFL, Date: 2023-05-30, Energy: 12}, S2: {Appliance: Heater, Date: 2023-05-30, Energy: 23}, S3: {Appliance: Refregerator, Date: 2023-05-30, Energy: 34}}, Home4: {S1: {Appliance: CFL, Date: 2023-05-30, Energy: 12}, S2: {Appliance: Refregerator, Date: 2023-05-30, Energy: 34}}, Home5: {S1: {Appliance: CFL, Date: 2023-05-30, Energy: }, S2: {Appliance: CFL, Date: 2023-05-30, Energy: 12}, S3: {Appliance: Heater, Date: 2023-05-30, Energy: 23}, S4: {Appliance: Refregerator, Date: 2023-05-30, Energy: 34}}, Items: CFL, Heater, Refregerator, Incandescent, LED}
      database.value = snapshot.value as Map;
    } else {
      print('No data available.');
    }
  }

  String getDateString(DateTime dateTime) {
    String month = dateTime.month.toString().length == 1
        ? "0" + dateTime.month.toString()
        : dateTime.month.toString();
    String day = dateTime.day.toString().length == 1
        ? "0" + dateTime.day.toString()
        : dateTime.day.toString();
    String date = dateTime.year.toString() + "-" + month + "-" + day;

    return date;
  }

  void onDateSelect(String home, DateTime dateTime) {
    totalItems.value = 0;

    String date = getDateString(dateTime);

    var homeData = database.value[home.split(" ").join()];

    var tempDic = {
      "CFL": 0,
      "Heater": 0,
      "Refregerator": 0,
      "Incandescent": 0,
      "LED": 0,
    };
    var tempDicEnergy = {
      "CFL": 0,
      "Heater": 0,
      "Refregerator": 0,
      "Incandescent": 0,
      "LED": 0,
    };

    num totEnergy = 0;

    for (var v in homeData!.values) {
      if (v["Date"] == date) {
        tempDic[v["Appliance"].toString()] = (tempDic[v["Appliance"]]! + 1);

        if (tempDicEnergy[v["Appliance"].toString()] == 0) {
          tempDicEnergy[v["Appliance"].toString()] = v["Energy"]!;
        }
        totEnergy = totEnergy + v["Energy"]!;
        totalItems.value = totalItems.value + 1;
      }
    }

    var tempDicEnergyPercentage = {
      "CFL": 0.0,
      "Heater": 0.0,
      "Refregerator": 0.0,
      "Incandescent": 0.0,
      "LED": 0.0,
    };

    totalPowerDateList.value = [];

    int i = 0;
    for (var k in tempDic.keys) {
      if (totEnergy != 0) {
        tempDicEnergyPercentage[k] =
            ((tempDicEnergy[k]! * tempDic[k]!) * 100) / totEnergy;
      }

      totalPowerDateList.value.add({
        "Device": k,
        "Percentage":
            double.parse(tempDicEnergyPercentage[k]!.toStringAsFixed(1)),
        "Description": "65W",
        "Color": availableColors[i],
      });
      i = i + 1;
    }

    itemList.value = [];

    itemList.value = [
      DeviceData(
        image: "assets/CFL.png",
        description: "CFL bulb\n11w, 0.26A",
        devices: tempDic["CFL"]!,
        percentage: tempDicEnergyPercentage["CFL"]!.toInt(),
        date: date,
      ),
      DeviceData(
        image: "assets/Heater.png",
        description: "Heater\n11w, 0.26A",
        devices: tempDic["Heater"]!,
        percentage: tempDicEnergyPercentage["Heater"]!.toInt(),
        date: date,
      ),
      DeviceData(
        image: "assets/Refregerator.png",
        description: "Refregerator\n11w, 0.26A",
        devices: tempDic["Refregerator"]!,
        percentage: tempDicEnergyPercentage["Refregerator"]!.toInt(),
        date: date,
      ),
      DeviceData(
        image: "assets/Incandescent.png",
        description: "Incandescent bulb\n11w, 0.26A",
        devices: tempDic["Incandescent"]!,
        percentage: tempDicEnergyPercentage["Incandescent"]!.toInt(),
        date: date,
      ),
      DeviceData(
        image: "assets/LED.png",
        description: "LED bulb\n11w, 0.26A",
        devices: tempDic["LED"]!,
        percentage: tempDicEnergyPercentage["LED"]!.toInt(),
        date: date,
      ),
    ];
  }

  Future<void> onHomeCardPress(int index, String label) async {
    var addressList = [
      "222, New Kathiresan Street, Colombo 13",
      "44/18A, 1st CROSS STREET, Nugegoda",
      "7F4, Orchard Bldg 7, Galle Road, Colombo 06",
      "79/A, Belmont Street, Galle",
      "4, Canal Bank Meeraniya Street, Kandy",
    ];

    await getData();
    selectedHome.value = index;
    selectedHomeData.value.title = label;
    selectedHomeData.value.address = addressList[index];

    selectedDate.value = DateTime.now();

    onDateSelect(selectedHomeData.value.title!, selectedDate.value);
    generatePast7Days(selectedHomeData.value.title!);

    await Future.delayed(Duration(seconds: 3));
  }

  void generatePast7Days(String home) {
    dateList.value = [];
    for (var i = 0; i < 7; i++) {
      DateTime now = new DateTime.now().subtract(Duration(days: i));
      DateTime date = new DateTime(now.year, now.month, now.day);

      String dateTemp = getDateString(date);
      var homeData = database.value[home.split(" ").join()];

      int? val = 0;

      for (var v in homeData!.values) {
        print(v);
        print(dateTemp);
        if (v["Date"] == dateTemp) {
          val = (val! + v["Energy"]!) as int?;
        }
      }

      dateList.add({
        "month": monthList[date.month - 1],
        "day": date.day.toString(),
        "value": val,
      });

      if (val! > maxValue.value) {
        maxValue.value = val;
      }
    }
    print(dateList);

    // for (var i = 0; i < 7; i++) {
    //   DateTime now = new DateTime.now().subtract(Duration(days: i));
    //   DateTime date = new DateTime(now.year, now.month, now.day);
    //   print(selectedHome.value);
    //   int v = i + 5 + selectedHome.value * 2;
    //   dateList.add({
    //     "month": monthList[date.month - 1],
    //     "day": date.day.toString(),
    //     "value": v,
    //   });

    //   if (v > maxValue.value) {
    //     maxValue.value = v;
    //   }
    // }
    // print(dateList);
  }

  // Constants

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
}
