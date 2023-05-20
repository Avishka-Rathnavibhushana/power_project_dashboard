import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:power_project_dashboard/app_constants.dart';
import 'package:power_project_dashboard/components/text_field_two.dart';
import 'package:power_project_dashboard/controllers/main_controller.dart';

class HomeData {
  String? title;

  HomeData({
    this.title,
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

  List<Color> get availableColors => const <Color>[
        Color(0xFF6E1BFF),
        Color(0xFFFFC300),
        Color(0xFF2196F3),
        Color(0xFFFF683B),
        Color(0xFFFF3AF2),
        Color(0xFFE80054),
      ];

  final Color barBackgroundColor = Colors.white.withOpacity(0.3);
  final Color barColor = Colors.white;
  final Color touchedBarColor = Color(0xFF3BFF49);

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
                                  child: Text(
                                    data.title!,
                                    style: TextStyle(
                                      color: Colors.black38,
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
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
                            GestureDetector(
                              onTap: () {
                                controller.test();
                              },
                              child: Container(
                                width: 400,
                                height: 400,
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
                                  ],
                                ),
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
}

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
