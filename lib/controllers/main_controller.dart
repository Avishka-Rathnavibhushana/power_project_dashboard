import 'package:get/get.dart';
import 'package:power_project_dashboard/app_constants.dart';
import 'package:power_project_dashboard/screens/home_screen.dart';

class MainController extends GetxController {
  var selectedHome = 0.obs;
  var selectedHomeData = HomeData(title: "Home 1").obs;
  var loading = false.obs;

  var itemList = [].obs;

  var dateList = [].obs;
  var maxValue = 0.obs;

  var touchedIndex = -1.obs;

  void onHomeCardPress(int index, String label) {
    selectedHome.value = index;
    selectedHomeData.value.title = label;
    generatePast7Days();
    getDevicesList();
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
        devices: 1 * selectedHome.value * 2,
        percentage: 38,
        date: "2021.05.29",
      ),
      DeviceData(
        image: ImageRasterPath.logo1,
        description: "CFL bulb\n11w, 0.26A",
        devices: 1 * selectedHome.value * 2,
        percentage: 38,
        date: "2021.05.29",
      ),
      DeviceData(
        image: ImageRasterPath.logo1,
        description: "CFL bulb\n11w, 0.26A",
        devices: 1 * selectedHome.value * 2,
        percentage: 38,
        date: "2021.05.29",
      ),
      DeviceData(
        image: ImageRasterPath.logo1,
        description: "CFL bulb\n11w, 0.26A",
        devices: 1 * selectedHome.value * 2,
        percentage: 38,
        date: "2021.05.29",
      ),
      DeviceData(
        image: ImageRasterPath.logo1,
        description: "CFL bulb\n11w, 0.26A",
        devices: 1 * selectedHome.value * 2,
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
      DeviceData(
        image: ImageRasterPath.logo1,
        description: "CFL bulb\n11w, 0.26A",
        devices: 1,
        percentage: 38,
        date: "2021.05.29",
      ),
    ];
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
    generatePast7Days();
    getDevicesList();
  }
}
