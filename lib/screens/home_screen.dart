import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:power_project_dashboard/controllers/main_controller.dart';

class HomeData {
  String? title;

  HomeData({
    this.title,
  });
}

class HomeScreen extends StatelessWidget {
  HomeData data;

  HomeScreen({super.key, required this.data});

  MainController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => controller.loading.value
          ? SizedBox(
              width: 30,
              height: 30,
              child: CircularProgressIndicator(),
            )
          : Container(
              child: Text(data.title!),
            ),
    );
  }
}
