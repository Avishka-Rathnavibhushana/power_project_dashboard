import 'package:get/get.dart';
import 'package:power_project_dashboard/screens/home_screen.dart';

class MainController extends GetxController {
  var selectedHome = 1.obs;
  var selectedHomeData = HomeData(title: "Home 1").obs;
  var loading = false.obs;

  void onHomeCardPress(int index) {
    selectedHome.value = index;
  }
  // @override
  // void onInit() {
  //   // TODO: implement onInit
  //   super.onInit();
  // }
}
