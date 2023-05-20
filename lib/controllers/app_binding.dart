import 'package:get/get.dart';
import 'package:power_project_dashboard/controllers/main_controller.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MainController());
  }
}
