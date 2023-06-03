import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:power_project_dashboard/controllers/app_binding.dart';
import 'package:power_project_dashboard/screens/dashboard_screen.dart';
import 'package:power_project_dashboard/screens/splash_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: 'AIzaSyCIJi5U9J_ISogPV_1DID9hwxIdF_JtH8A',
      appId: '1:32609991158:web:6b32c977efe86be7b12fd7',
      messagingSenderId: '32609991158',
      projectId: 'power-project-3f5af',
      databaseURL:
          "https://power-project-3f5af-default-rtdb.asia-southeast1.firebasedatabase.app",
    ),
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Power Project',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SplashScreen(),
      initialBinding: AppBinding(),
    );
  }
}
