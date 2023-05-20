import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:power_project_dashboard/controllers/app_binding.dart';
import 'package:power_project_dashboard/screens/dashboard_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Power Project',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: DashboardScreen(),
      initialBinding: AppBinding(),
    );
  }
}
