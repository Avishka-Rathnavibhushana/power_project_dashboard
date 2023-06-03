import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:power_project_dashboard/app_constants.dart';
import 'package:power_project_dashboard/components/indicator.dart';
import 'package:power_project_dashboard/components/text_field_two.dart';
import 'package:power_project_dashboard/controllers/main_controller.dart';

class HomeData {
  String? title;
  String? address;

  HomeData({
    this.title,
    this.address,
  });
}

class DeviceData {
  String image;
  String description;
  int devices;
  int percentage;
  String date;

  DeviceData({
    required this.image,
    required this.description,
    required this.devices,
    required this.percentage,
    required this.date,
  });
}

class HomeScreen extends StatelessWidget {
  HomeData data;

  HomeScreen({super.key, required this.data});

  MainController controller = Get.find();

  final Color barBackgroundColor = Colors.white.withOpacity(0.3);
  final Color barColor = Colors.white;
  final Color touchedBarColor = Color(0xFF3BFF49);

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: controller.selectedDate.value,
      firstDate: DateTime(2015),
      lastDate: DateTime.now(),
    );
    if (pickedDate != null && pickedDate != controller.selectedDate.value) {
      controller.selectedDate.value = pickedDate;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => controller.loading.value
          ? SizedBox(
              width: 100,
              height: 100,
              child: LoadingAnimationWidget.staggeredDotsWave(
                color: Color(0xFF2196F3),
                size: 100,
              ),
            )
          : Container(
              height: MediaQuery.of(context).size.height,
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 20, horizontal: 20),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Color(0xFF5800FC).withOpacity(0.1),
                                  border: Border.all(
                                    color: Color(0xFF5800FC).withOpacity(0.1),
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: <BoxShadow>[
                                    BoxShadow(
                                      color: Color(0xFF5800FC).withOpacity(0.5),
                                      blurRadius: 10,
                                      spreadRadius: 0.3,
                                      blurStyle: BlurStyle.outer,
                                    ),
                                  ],
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 15, horizontal: 15),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        data.title!,
                                        style: TextStyle(
                                          color: Colors.black38,
                                          fontSize: 25,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        data.address!,
                                        style: TextStyle(
                                          color: Colors.black54,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Material(
                        color: Color(0xFF03910F).withOpacity(0.1),
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Color(0xFF03910F).withOpacity(0.1),
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: <BoxShadow>[
                              BoxShadow(
                                color: Color(0xFF03910F).withOpacity(0.5),
                                blurRadius: 10,
                                spreadRadius: 0.3,
                                blurStyle: BlurStyle.outer,
                              ),
                            ],
                          ),
                          child: InkWell(
                            onTap: () async {
                              await _selectDate(context);

                              controller.onDateSelect(
                                  data.title!, controller.selectedDate.value);
                            },
                            borderRadius: BorderRadius.circular(10),
                            child: Padding(
                              padding: const EdgeInsets.all(kSpacing),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.calendar_month,
                                    color: Colors.black,
                                    size: 25,
                                  ),
                                  const SizedBox(width: kSpacing / 2),
                                  Text(
                                    "Select Date : " +
                                        controller.getDateString(
                                            controller.selectedDate.value),
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 25,
                                    ),
                                  ),
                                  // if (data.totalNotif != null)
                                  //   Padding(
                                  //     padding: const EdgeInsets.only(left: kSpacing / 2),
                                  //     child: _notif(data.totalNotif!),
                                  //   )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: Wrap(
                          alignment: WrapAlignment.center,
                          runSpacing: 25,
                          spacing: 25,
                          children: controller.itemList
                              .map((item) => DeviceBox(device: item))
                              .toList(),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Wrap(
                          runSpacing: 25,
                          spacing: 25,
                          children: [
                            Container(
                              width: 400,
                              decoration: BoxDecoration(
                                color: Color(0xFFE80054).withOpacity(0.1),
                                border: Border.all(
                                  color: Color(0xFFE80054).withOpacity(0.1),
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: <BoxShadow>[
                                  BoxShadow(
                                    color: Color(0xFFE80054).withOpacity(0.5),
                                    blurRadius: 10,
                                    spreadRadius: 0.3,
                                    blurStyle: BlurStyle.outer,
                                  ),
                                ],
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 15, horizontal: 10),
                                    child: Text(
                                      "Total Power",
                                      style: TextStyle(
                                        color: Colors.black38,
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 15, horizontal: 10),
                                    child: Container(
                                      width: 300,
                                      height: 200,
                                      child: controller.totalItems == 0
                                          ? Center(
                                              child: Text(
                                                "No electric item used on " +
                                                    controller.getDateString(
                                                        controller.selectedDate
                                                            .value),
                                                style: TextStyle(
                                                  color: Colors.black38,
                                                  fontSize: 25,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                                textAlign: TextAlign.center,
                                              ),
                                            )
                                          : PieChart(
                                              PieChartData(
                                                pieTouchData: PieTouchData(
                                                  touchCallback:
                                                      (FlTouchEvent event,
                                                          pieTouchResponse) {
                                                    if (!event
                                                            .isInterestedForInteractions ||
                                                        pieTouchResponse ==
                                                            null ||
                                                        pieTouchResponse
                                                                .touchedSection ==
                                                            null) {
                                                      controller
                                                          .touchedIndexPie = -1;
                                                      return;
                                                    }
                                                    controller.touchedIndexPie =
                                                        pieTouchResponse
                                                            .touchedSection!
                                                            .touchedSectionIndex;
                                                  },
                                                ),
                                                borderData: FlBorderData(
                                                  show: false,
                                                ),
                                                sectionsSpace: 5,
                                                centerSpaceRadius: 50,
                                                sections: showingSections(),
                                              ),
                                            ),
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.center,
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          bottom: 15, left: 10, right: 10),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisSize: MainAxisSize.min,
                                        children: controller
                                            .totalPowerDateList.value
                                            .map(
                                              (item) => Padding(
                                                padding: const EdgeInsets.only(
                                                    bottom: 4),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [
                                                    Indicator(
                                                      color: item["Color"],
                                                      text: item["Device"]
                                                      // +
                                                      //     ", " +
                                                      //     item["Description"]
                                                      ,
                                                      isSquare: false,
                                                      size: 16,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            )
                                            .toList(),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              width: 400,
                              height: 400,
                              decoration: BoxDecoration(
                                color: Color(0xFF007E2A).withOpacity(0.1),
                                border: Border.all(
                                  color: Color(0xFF007E2A).withOpacity(0.1),
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: <BoxShadow>[
                                  BoxShadow(
                                    color: Color(0xFF007E2A).withOpacity(0.5),
                                    blurRadius: 10,
                                    spreadRadius: 0.3,
                                    blurStyle: BlurStyle.outer,
                                  ),
                                ],
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 15, horizontal: 10),
                                    child: Text(
                                      "Power Consumption History",
                                      style: TextStyle(
                                        color: Colors.black38,
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 15, horizontal: 10),
                                    child: Container(
                                      height: 300,
                                      child: BarChart(
                                        mainBarData(),
                                        swapAnimationDuration:
                                            Duration(milliseconds: 250),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }

  //
  // Bar chart helpers
  //

  BarChartGroupData makeGroupData(
    int x,
    double y, {
    bool isTouched = false,
    Color? barColor,
    double width = 22,
    List<int> showTooltips = const [],
  }) {
    barColor ??= barColor;
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: isTouched ? y + 1 : y,
          color: isTouched ? touchedBarColor : Colors.blue[500],
          width: width,
          borderSide: isTouched
              ? BorderSide(color: touchedBarColor.withOpacity(0.8))
              : const BorderSide(color: Colors.white, width: 0),
          backDrawRodData: BackgroundBarChartRodData(
            show: true,
            toY: (double.parse(controller.maxValue.value.toString())
                        .roundToDouble() +
                    double.parse(controller.maxValue.value.toString())
                            .roundToDouble() *
                        0.2)
                .roundToDouble(),
            color: Colors.blue[500]!.withOpacity(0.2),
          ),
        ),
      ],
      showingTooltipIndicators: showTooltips,
    );
  }

  List<BarChartGroupData> showingGroups() => List.generate(7, (i) {
        switch (i) {
          case 0:
            return makeGroupData(
                0, double.parse(controller.dateList[6 - i]["value"].toString()),
                isTouched: i == controller.touchedIndex);
          case 1:
            return makeGroupData(
                1, double.parse(controller.dateList[6 - i]["value"].toString()),
                isTouched: i == controller.touchedIndex);
          case 2:
            return makeGroupData(
                2, double.parse(controller.dateList[6 - i]["value"].toString()),
                isTouched: i == controller.touchedIndex);
          case 3:
            return makeGroupData(
                3, double.parse(controller.dateList[6 - i]["value"].toString()),
                isTouched: i == controller.touchedIndex);
          case 4:
            return makeGroupData(
                4, double.parse(controller.dateList[6 - i]["value"].toString()),
                isTouched: i == controller.touchedIndex);
          case 5:
            return makeGroupData(
                5, double.parse(controller.dateList[6 - i]["value"].toString()),
                isTouched: i == controller.touchedIndex);
          case 6:
            return makeGroupData(
                6, double.parse(controller.dateList[6 - i]["value"].toString()),
                isTouched: i == controller.touchedIndex);
          default:
            return throw Error();
        }
      });

  BarChartData mainBarData() {
    return BarChartData(
      barTouchData: BarTouchData(
        touchTooltipData: BarTouchTooltipData(
          tooltipBgColor: Color(0xFF004417),
          tooltipHorizontalAlignment: FLHorizontalAlignment.right,
          tooltipMargin: -10,
          getTooltipItem: (group, groupIndex, rod, rodIndex) {
            String weekDay;
            switch (group.x) {
              case 0:
                weekDay = controller.dateList[6 - group.x]["month"] +
                    "," +
                    controller.dateList[6 - group.x]["day"];
                break;
              case 1:
                weekDay = controller.dateList[6 - group.x]["month"] +
                    "," +
                    controller.dateList[6 - group.x]["day"];
                break;
              case 2:
                weekDay = controller.dateList[6 - group.x]["month"] +
                    "," +
                    controller.dateList[6 - group.x]["day"];
                break;
              case 3:
                weekDay = controller.dateList[6 - group.x]["month"] +
                    "," +
                    controller.dateList[6 - group.x]["day"];
                break;
              case 4:
                weekDay = controller.dateList[6 - group.x]["month"] +
                    "," +
                    controller.dateList[6 - group.x]["day"];
                break;
              case 5:
                weekDay = controller.dateList[6 - group.x]["month"] +
                    "," +
                    controller.dateList[6 - group.x]["day"];
                break;
              case 6:
                weekDay = controller.dateList[6 - group.x]["month"] +
                    "," +
                    controller.dateList[6 - group.x]["day"];
                break;
              default:
                throw Error();
            }
            return BarTooltipItem(
              '$weekDay\n',
              const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
              children: <TextSpan>[
                TextSpan(
                  text: (rod.toY - 1).toString(),
                  style: TextStyle(
                    color: touchedBarColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            );
          },
        ),
        touchCallback: (FlTouchEvent event, barTouchResponse) {
          if (!event.isInterestedForInteractions ||
              barTouchResponse == null ||
              barTouchResponse.spot == null) {
            controller.touchedIndex = -1;
            return;
          }
          controller.touchedIndex = barTouchResponse.spot!.touchedBarGroupIndex;
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            getTitlesWidget: getTitles,
            reservedSize: 45,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 28,
            interval: 5,
            // getTitlesWidget: leftTitles,
          ),
        ),
      ),
      borderData: FlBorderData(
        show: false,
      ),
      barGroups: showingGroups(),
      gridData: FlGridData(show: false),
    );
  }

  Widget getTitles(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Color(0xFF004417),
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );
    Widget text;
    switch (value.toInt()) {
      case 0:
        text = Text(
          controller.dateList[6 - value.toInt()]["month"] +
              "\n" +
              controller.dateList[6 - value.toInt()]["day"].toString(),
          style: style,
          textAlign: TextAlign.center,
        );
        break;
      case 1:
        text = Text(
          controller.dateList[6 - value.toInt()]["month"] +
              "\n" +
              controller.dateList[6 - value.toInt()]["day"].toString(),
          style: style,
          textAlign: TextAlign.center,
        );
        break;
      case 2:
        text = Text(
          controller.dateList[6 - value.toInt()]["month"] +
              "\n" +
              controller.dateList[6 - value.toInt()]["day"].toString(),
          style: style,
          textAlign: TextAlign.center,
        );
        break;
      case 3:
        text = Text(
          controller.dateList[6 - value.toInt()]["month"] +
              "\n" +
              controller.dateList[6 - value.toInt()]["day"].toString(),
          style: style,
          textAlign: TextAlign.center,
        );
        break;
      case 4:
        text = Text(
          controller.dateList[6 - value.toInt()]["month"] +
              "\n" +
              controller.dateList[6 - value.toInt()]["day"].toString(),
          style: style,
          textAlign: TextAlign.center,
        );
        break;
      case 5:
        text = Text(
          controller.dateList[6 - value.toInt()]["month"] +
              "\n" +
              controller.dateList[6 - value.toInt()]["day"].toString(),
          style: style,
          textAlign: TextAlign.center,
        );
        break;
      case 6:
        text = Text(
          controller.dateList[6 - value.toInt()]["month"] +
              "\n" +
              controller.dateList[6 - value.toInt()]["day"].toString(),
          style: style,
          textAlign: TextAlign.center,
        );
        break;
      default:
        text = Text(
          controller.dateList[6 - value.toInt()]["day"].toString(),
          style: style,
          textAlign: TextAlign.center,
        );
        break;
    }
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 16,
      child: text,
    );
  }

  //
  // Pie chart helpers
  //

  List<PieChartSectionData> showingSections() {
    return List.generate(controller.totalPowerDateList.value.length, (i) {
      final isTouched = i == controller.touchedIndex;
      final fontSize = isTouched ? 13.0 : 10.0;
      final radius = isTouched ? 60.0 : 50.0;
      const shadows = [Shadow(color: Colors.black, blurRadius: 2)];
      bool returned = false;
      var section = null;
      for (var j = 0; j < controller.totalPowerDateList.value.length; j++) {
        if (i == j) {
          returned = true;
          section = PieChartSectionData(
            color: controller.totalPowerDateList.value[j]["Color"],
            value: double.parse(controller
                .totalPowerDateList.value[j]["Percentage"]
                .toString()),
            title: controller.totalPowerDateList.value[j]["Percentage"]
                    .toString() +
                '%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.w400,
              color: Colors.white,
              shadows: shadows,
            ),
          );
        }
      }
      if (!returned) {
        throw Error();
      } else {
        return section;
      }
    });
  }
}

// Helper widget to display devices data

class DeviceBox extends StatelessWidget {
  const DeviceBox({
    super.key,
    required this.device,
  });

  final DeviceData device;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.blue[500]!.withOpacity(0.1),
        border: Border.all(
          color: Colors.blue[500]!.withOpacity(0.1),
          width: 1,
        ),
        borderRadius: BorderRadius.circular(10),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.blue[500]!.withOpacity(0.5),
            blurRadius: 10,
            spreadRadius: 0.3,
            blurStyle: BlurStyle.outer,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 20,
              ),
              child: Image.asset(
                device.image,
                width: 100,
                height: 100,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Container(
                width: 100,
                child: TextFieldTwo(
                  controller: TextEditingController(
                    text: device.description,
                  ),
                  labelText: "Description",
                  isEditable: false,
                  fontSize: 12,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Devices : ",
                    style: TextStyle(
                      color: Colors.black38,
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    device.devices.toString(),
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Percentage : ",
                    style: TextStyle(
                      color: Colors.black38,
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    device.percentage.toString() + " %",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Text(
                device.date,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 13,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
