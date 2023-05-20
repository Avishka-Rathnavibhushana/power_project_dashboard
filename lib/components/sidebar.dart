import 'dart:developer';

import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:power_project_dashboard/app_constants.dart';
import 'package:power_project_dashboard/components/project_card.dart';
import 'package:power_project_dashboard/components/selection_button.dart';
import 'package:power_project_dashboard/components/upgrade_premium_card.dart';
import 'package:power_project_dashboard/controllers/main_controller.dart';
import 'package:power_project_dashboard/screens/home_screen.dart';

class Sidebar extends StatelessWidget {
  const Sidebar({
    required this.data,
    Key? key,
  }) : super(key: key);

  final ProjectCardData data;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          right: BorderSide(
            color: Colors.black45,
          ),
        ),
      ),
      child: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: const EdgeInsets.all(kSpacing),
                child: ProjectCard(
                  data: data,
                ),
              ),
              const Divider(thickness: 2),
              SelectionButton(
                data: [
                  SelectionButtonData(
                    activeIcon: EvaIcons.home,
                    icon: EvaIcons.homeOutline,
                    label: "Home 1",
                    // index: 1,
                  ),
                  SelectionButtonData(
                    activeIcon: EvaIcons.home,
                    icon: EvaIcons.homeOutline,
                    label: "Home 2",
                    // index: 2,
                  ),
                  SelectionButtonData(
                    activeIcon: EvaIcons.home,
                    icon: EvaIcons.homeOutline,
                    label: "Home 3",
                    // index: 3,
                  ),
                  SelectionButtonData(
                    activeIcon: EvaIcons.home,
                    icon: EvaIcons.homeOutline,
                    label: "Home 4",
                    // index: 4,
                  ),
                  SelectionButtonData(
                    activeIcon: EvaIcons.home,
                    icon: EvaIcons.homeOutline,
                    label: "Home 5",
                    // index: 5,
                  ),
                ],
                onSelected: (index, value) async {
                  MainController controller = Get.find();
                  controller.loading.value = true;

                  print("index : $index | label : ${value.label}");

                  controller.onHomeCardPress(index, value.label);
                  // controller.selectedHomeData.value.title = value.label;

                  // controller.generatePast7Days();
                  // controller.getDevicesList();

                  await Future.delayed(Duration(seconds: 2));
                  controller.loading.value = false;
                },
              ),
              // const Divider(thickness: 1),
              // const SizedBox(height: kSpacing * 2),
              // UpgradePremiumCard(
              //   backgroundColor: Theme.of(context).canvasColor.withOpacity(.4),
              //   onPressed: () {},
              // ),
              // const SizedBox(height: kSpacing),
              Expanded(
                child: Container(
                  height: 10,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
