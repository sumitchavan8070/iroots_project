import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:iroots/src/controller/attendance/student/student_attendance_controller.dart';
import 'package:iroots/src/ui/dashboard/payment/LoadAttendenceDataController.dart';
import 'package:iroots/src/ui/dashboard/payment/payment_controller.dart';
import 'package:iroots/src/ui/dashboard/student/home/student_attendence_detail_view.dart';
import 'package:iroots/src/utility/const.dart';
import 'package:iroots/src/utility/constant/asset_path.dart';
import 'package:iroots/src/utility/util.dart';
import 'package:lottie/lottie.dart';
import 'package:pie_chart/pie_chart.dart';

final _loadAttendeanceController = Get.put(LoadAttendenceDataController());

class StudentAttendanceScreen extends StatefulWidget {
  const StudentAttendanceScreen({super.key});

  @override
  State<StudentAttendanceScreen> createState() =>
      _StudentAttendanceScreenState();
}

class _StudentAttendanceScreenState extends State<StudentAttendanceScreen> {
  @override
  void initState() {
    super.initState();
    // Initialize the selected year to the first item in the list
    selectedYear = "2024";
  }

  List<Map<String, dynamic>> attendanceData = [];
  List<String> yearList = ["2020", "2021", "2022", "2023", "2024", "2025"];
  String selectedYear = "";

  void _changeYear(String? newYear) {
    if (newYear != null) {
      setState(() {
        selectedYear = newYear;
      });
      _fetchAttendanceData(newYear);
    }

  }

  void _fetchAttendanceData(String year) {
    final stDate = "$year-01-01";
    final etDate = "$year-12-30";

    _loadAttendeanceController.loadAttendece(
      startDate: stDate,
      endDate: etDate,
      fromYear: year,
      toYear: year,
    );
  }

  Color getColor(String status) {
    switch (status) {
      case "present":
        return const Color(0xFF0DB166);
      case "absent":
        return const Color(0xFF9F7CCB);
      case "leave":
        return const Color(0xFFFF0000);
      default:
        return Colors.grey;
    }
  }

  Widget _attendanceWidget({
    required Color color,
    required String attendance,
    required String status,
  }) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(8),
        margin: const EdgeInsets.symmetric(horizontal: 6),
        decoration: BoxDecoration(
          color: color.withOpacity(0.15),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: color.withOpacity(0.6), width: 1),
        ),
        child: Column(
          children: [
            Text(
              attendance,
              style: Theme.of(context)
                  .textTheme
                  .bodySmall
                  ?.copyWith(color: color, fontWeight: FontWeight.w400),
            ),
            Text(
              status,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(color: color, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }

  String _getMonthName(int month) {
    switch (month) {
      case 1:
        return "January";
      case 2:
        return "February";
      case 3:
        return "March";
      case 4:
        return "April";
      case 5:
        return "May";
      case 6:
        return "June";
      case 7:
        return "July";
      case 8:
        return "August";
      case 9:
        return "September";
      case 10:
        return "October";
      case 11:
        return "November";
      case 12:
        return "December";
      default:
        return "Unknown";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF1F5F9),
      appBar: AppBar(title: const Text("Attendance")),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 74,
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 12,
                  spreadRadius: 0,
                  offset: const Offset(0, 0),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Academics year ",
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: const Color(0xFF1575FF),
                      fontSize: 20,
                      fontWeight: FontWeight.w700),
                ),
                DropdownButton<String>(
                  value: selectedYear,
                  onChanged: _changeYear,
                  items: yearList.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            color: const Color(0xFF1575FF),
                            fontSize: 20,
                            fontWeight: FontWeight.w700),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
          // Replace this with your actual attendance data fetching logic
          _loadAttendeanceController.obx(
            (state) {
              if(state?.data?.yearlyAttendanceSummary?.isEmpty == true  ){
                return
                  Lottie.asset(AssetPath.noDataFound);
              }
              return Flexible(
                child: ListView.builder(
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(8),
                  itemCount: state?.data?.yearlyAttendanceSummary?.length ?? 0,
                  itemBuilder: (context, index) {
                    final item = state?.data?.yearlyAttendanceSummary?[index];

                    return Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                _getMonthName(item?.month?.toInt() ?? 0),
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium
                                    ?.copyWith(fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 16),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  _attendanceWidget(
                                    color: getColor("present"),
                                    attendance:
                                        item?.totalPresent.toString() ?? "",
                                    status: "present",
                                  ),
                                  _attendanceWidget(
                                    color: getColor("absent"),
                                    attendance:
                                        item?.totalAbsent.toString() ?? "",
                                    status: "absent",
                                  ),
                                  _attendanceWidget(
                                    color: getColor("leave"),
                                    attendance:
                                        item?.totalLeave.toString() ?? "",
                                    status: "leave",
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                ),
              );
            },
            onLoading: const  Center(child: CircularProgressIndicator()),

            onError: (error) {
              return Lottie.asset(AssetPath.noDataFound);
            },
          ),
        ],
      ),
    );
  }

  // return GetBuilder(
  // init: StudentAttendanceController(),
  // builder: (logic) => DefaultTabController(
  // length: 3,
  // child: Scaffold(
  // backgroundColor: ConstClass.dashBoardColor,
  // appBar: AppBar(
  // elevation: 0,
  // backgroundColor: ConstClass.dashBoardColor,
  // bottom: PreferredSize(
  // preferredSize: const Size.fromHeight(60),
  // child: Container(
  // decoration: BoxDecoration(
  // border: Border.all(color: Colors.white),
  // borderRadius:
  // const BorderRadius.all(Radius.circular(15.0))),
  // margin: const EdgeInsets.all(5),
  // padding: const EdgeInsets.all(3),
  // child: Row(
  // children: [
  // IconButton(
  // onPressed: () {
  // logic.tabController!
  //     .animateTo(logic.tabController!.index - 1);
  // },
  // icon: const Icon(
  // Icons.chevron_left,
  // color: Colors.white,
  // )),
  // const SizedBox(
  // width: 3,
  // ),
  // Expanded(
  // child: TabBar(
  // onTap: (index) {
  // logic.getCurrentYear(index);
  // },
  // controller: logic.tabController,
  // indicatorColor: Colors.transparent,
  // labelStyle: const TextStyle(
  // color: Colors.white,
  // fontFamily: 'Open Sans',
  // fontWeight: FontWeight.bold,
  // fontSize: 12),
  // unselectedLabelStyle: const TextStyle(
  // color: Colors.grey,
  // fontFamily: 'Open Sans',
  // fontWeight: FontWeight.w200,
  // fontSize: 12),
  // isScrollable: true,
  // tabs: logic.yearTabs.map((String tab) {
  // return Tab(
  // text: tab,
  // );
  // }).toList(),
  // ),
  // ),
  // const SizedBox(
  // width: 3,
  // ),
  // IconButton(
  // onPressed: () {
  // logic.tabController!
  //     .animateTo(logic.tabController!.index + 1);
  // },
  // icon: const Icon(
  // Icons.chevron_right,
  // color: Colors.white,
  // )),
  // ],
  // ),
  // ),
  // ),
  // title: AppUtil.customText(
  // text: "Student Attendance",
  // style: const TextStyle(
  // fontFamily: 'Open Sans',
  // fontWeight: FontWeight.w700,
  // fontSize: 16),
  // ),
  // ),
  // body: Obx(() {
  // if (logic.showProgress.value) {
  // return const Center(child: CircularProgressIndicator());
  // } else {
  // if (logic.isDataFound.value) {
  // return Center(
  // child: SizedBox(
  // height: 360,
  // width: Get.width,
  // child: Padding(
  // padding: const EdgeInsets.symmetric(
  // horizontal: 10, vertical: 5),
  // child: TabBarView(
  // physics: const NeverScrollableScrollPhysics(),
  // controller: logic.tabController,
  // children: logic.yearTabs
  //     .map((year) => attendanceWidget(logic))
  //     .toList(),
  // ),
  // ),
  // ),
  // );
  // } else {
  // return emptyGraph(logic);
  // }
  // }
  // })),
  // ),
  // );

  Widget emptyGraph(StudentAttendanceController logic) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: SizedBox(
          height: 280,
          width: Get.width,
          child: Card(
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 150,
                  height: 150,
                  child: PieChart(
                    emptyColor: Colors.lightBlue,
                    dataMap: logic.graphData,
                    animationDuration: const Duration(milliseconds: 800),
                    chartLegendSpacing: 50,
                    initialAngleInDegree: 0,
                    chartType: ChartType.ring,
                    ringStrokeWidth: 35,
                    legendOptions: const LegendOptions(
                      showLegendsInRow: false,
                      legendPosition: LegendPosition.right,
                      showLegends: false,
                      legendShape: BoxShape.rectangle,
                      legendTextStyle: TextStyle(
                          color: Color(0xff64748B),
                          fontFamily: 'Open Sans',
                          fontWeight: FontWeight.w700,
                          fontSize: 10),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                AppUtil.noDataFound("No Data Found")
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget attendanceWidget(StudentAttendanceController logic) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AppUtil.customText(
          text: "${logic.studentData!.studentName} Attendance",
          style: const TextStyle(
              color: Colors.white,
              fontFamily: 'Open Sans',
              fontWeight: FontWeight.w700,
              fontSize: 16),
        ),
        const SizedBox(
          height: 10,
        ),
        Card(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /*   SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: SizedBox(
                    height: 300.h,
                    width: 1.sw,
                    child: BarChart(
                      BarChartData(
                        gridData: FlGridData(drawVerticalLine: false),
                        borderData: FlBorderData(
                            show: true,
                            border: const Border(
                              left: BorderSide(
                                color: Colors.grey,
                                width: 1,
                              ),
                              bottom: BorderSide(
                                color: Colors.grey,
                                width: 1,
                              ),
                            )),
                        titlesData: FlTitlesData(
                            leftTitles: AxisTitles(
                                drawBehindEverything: false,
                                sideTitles: SideTitles(
                                  reservedSize: 10,
                                  showTitles: true,
                                )),
                            bottomTitles: AxisTitles(
                                sideTitles: SideTitles(
                              reservedSize: 44,
                              showTitles: true,
                            )),
                            rightTitles: AxisTitles(
                                sideTitles: SideTitles(
                              reservedSize: 10,
                              showTitles: false,
                            )),
                            topTitles: AxisTitles(
                                sideTitles: SideTitles(
                              reservedSize: 10,
                              showTitles: false,
                            ))),
                        minY: 0,
                        maxY: 5,
                        alignment: BarChartAlignment.center,
                        groupsSpace: 10.0,
                        barGroups: logic.attendance!
                            .asMap()
                            .map((index, item) {
                              return MapEntry(
                                  index,
                                  BarChartGroupData(
                                    x: index,
                                    barRods: [
                                      BarChartRodData(
                                        width: 20.w,
                                        borderRadius: BorderRadius.zero,
                                        color: Colors.blue,
                                        toY: 3,
                                      ),
                                    ],
                                  ));
                            })
                            .values
                            .toList(),
                      ),
                    ),
                  ),
                ),*/
                PieChart(
                  dataMap: logic.graphData,
                  animationDuration: const Duration(milliseconds: 800),
                  chartLegendSpacing: 50,
                  colorList: logic.colorList,
                  initialAngleInDegree: 0,
                  chartType: ChartType.ring,
                  ringStrokeWidth: 35,
                  legendOptions: const LegendOptions(
                    showLegendsInRow: false,
                    legendPosition: LegendPosition.right,
                    showLegends: true,
                    legendShape: BoxShape.rectangle,
                    legendTextStyle: TextStyle(
                        color: Color(0xff64748B),
                        fontFamily: 'Open Sans',
                        fontWeight: FontWeight.w700,
                        fontSize: 10),
                  ),
                  chartValuesOptions: const ChartValuesOptions(
                    showChartValueBackground: false,
                    showChartValues: false,
                    showChartValuesOutside: false,
                    decimalPlaces: 0,
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                AppUtil.customText(
                  text: "Attendance",
                  style: const TextStyle(
                      color: Colors.grey,
                      fontFamily: 'Open Sans',
                      fontWeight: FontWeight.w600,
                      fontSize: 12),
                ),
                AppUtil.customText(
                  text:
                      "${logic.studentData!.totalAttendedDays} / ${logic.studentData!.totalDays} days",
                  style: const TextStyle(
                      color: Colors.black,
                      fontFamily: 'Open Sans',
                      fontWeight: FontWeight.w600,
                      fontSize: 13),
                ),
                const SizedBox(
                  height: 10,
                ),
                AppUtil.customText(
                  text: "Percentage",
                  style: const TextStyle(
                      color: Colors.grey,
                      fontFamily: 'Open Sans',
                      fontWeight: FontWeight.w600,
                      fontSize: 12),
                ),
                AppUtil.customText(
                  text: logic.studentData!.attendancePer,
                  style: const TextStyle(
                      color: Colors.black,
                      fontFamily: 'Open Sans',
                      fontWeight: FontWeight.w600,
                      fontSize: 13),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
