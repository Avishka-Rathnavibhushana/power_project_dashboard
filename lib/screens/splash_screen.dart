import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:power_project_dashboard/controllers/main_controller.dart';
import 'package:power_project_dashboard/screens/dashboard_screen.dart';

import '../app_constants.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    method();
  }

  Future<void> method() async {
    MainController mainController = Get.find();
    await mainController.onHomeCardPress(0, "Home 1");

    Navigator.of(context).pushReplacement(
      MaterialPageRoute<void>(
        builder: (BuildContext context) => const DashboardScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _ProgressIndicator(
              percent: 0.25,
              center: _ProfilImage(image: AssetImage(ImageRasterPath.logo1)),
            ),
            const SizedBox(height: 15),
            TitleText(data: "Power App\nDashboard"),
            SizedBox(
              height: 10,
            ),
            SizedBox(
              width: 100,
              height: 100,
              child: LoadingAnimationWidget.staggeredDotsWave(
                color: Color(0xFF2196F3),
                size: 100,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/* -----------------------------> COMPONENTS <------------------------------ */
class _ProgressIndicator extends StatelessWidget {
  const _ProgressIndicator({
    required this.percent,
    required this.center,
    Key? key,
  }) : super(key: key);

  final double percent;
  final Widget center;

  @override
  Widget build(BuildContext context) {
    return CircularPercentIndicator(
      radius: 120,
      lineWidth: 9.0,
      percent: percent,
      center: center,
      circularStrokeCap: CircularStrokeCap.round,
      backgroundColor: Colors.blueGrey,
      progressColor: Colors.blue[500],
    );
  }
}

class _ProfilImage extends StatelessWidget {
  const _ProfilImage({required this.image, Key? key}) : super(key: key);

  final ImageProvider image;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundImage: image,
      radius: 100,
      backgroundColor: Colors.white,
    );
  }
}

class TitleText extends StatelessWidget {
  const TitleText({Key? key, required this.data}) : super(key: key);

  final String data;

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: TextStyle(
        fontSize: 30,
        fontWeight: FontWeight.w600,
        color: Color(0xFF2196F3),
        letterSpacing: 0.8,
      ),
      maxLines: 3,
      overflow: TextOverflow.ellipsis,
    );
  }
}
