import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:iroots/src/modal/dashboardModalClass.dart';
import 'package:iroots/src/utility/const.dart';
import 'package:iroots/src/utility/util.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:iroots/src/controller/home/student/student_home_controller.dart';
import 'package:iroots/src/ui/dashboard/student/components/academics_card.dart';
import 'package:iroots/src/ui/dashboard/student/components/getAttendanceStatus.dart';
import 'package:iroots/src/ui/dashboard/student/components/student_detail_card.dart';

class StudentHomePageScreen extends StatelessWidget {
  const StudentHomePageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: StudentHomeController(),
      builder: (logic) => Scaffold(body: Obx(() {
        if (logic.showProgress.value) {
          return const Center(child: CircularProgressIndicator());
        } else {
          return Scaffold(

            body: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  const SizedBox(height: 30),
                  const StudentDetailCard(),
                  const SizedBox(height: 18),
                  const AcademicsCard(),
                  const AttendanceView(
                    attendanceData: {
                      "present": ["2025-01-01", "2025-01-10", "2025-01-15"],
                      "absent": ["2025-01-08",  "2025-01-18", "2025-01-29"],
                      "holidays": ["2025-01-17"],
                      "leaves" :  ["2025-01-29", ]
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              height: 43,
                              width: 171,
                              decoration: BoxDecoration(
                                  border: Border.all(color: const Color(0xFF0DB166).withOpacity(0.3)),
                                  color: const Color(0xFF0DB166).withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(8)),
                              child: Center(
                                child: Text(
                                  "Regional Holiday",
                                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                      color: const Color(0xFF0DB166), fontWeight: FontWeight.w600),
                                ),
                              ),
                            ),
                            Container(
                              height: 43,
                              width: 171,
                              decoration: BoxDecoration(
                                  border: Border.all(color: const Color(0xFF9F7CCB).withOpacity(0.3)),
                                  color: const Color(0xFF9F7CCB).withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(8)),
                              child: Center(
                                child: Text(
                                  "National Holiday",
                                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                      color: const Color(0xFF9F7CCB), fontWeight: FontWeight.w600),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              height: 43,
                              width: 171,
                              decoration: BoxDecoration(
                                  border: Border.all(color: const Color(0xFFFF0000).withOpacity(0.3)),
                                  color: const Color(0xFFFF0000).withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(8)),
                              child: Center(
                                child: Text(
                                  "Reminders",
                                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                      color: const Color(0xFFFF0000), fontWeight: FontWeight.w600),
                                ),
                              ),
                            ),
                            Container(
                              height: 43,
                              width: 171,
                              decoration: BoxDecoration(
                                  border: Border.all(color: const Color(0xFF1575FF).withOpacity(0.3)),
                                  color: const Color(0xFF1575FF).withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(8)),
                              child: Center(
                                child: Text(
                                  "My Leaves",
                                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                      color: const Color(0xFF1575FF), fontWeight: FontWeight.w600),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );

          return SingleChildScrollView(
            child: Container(
              color: const Color(0xffF1F5F9),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    todayAttendanceWidget(logic),
                    const SizedBox(
                      height: 5,
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          AppUtil.customText(
                            text: "Academics",
                            style: const TextStyle(
                                fontFamily: 'Open Sans',
                                fontWeight: FontWeight.w700,
                                fontSize: 14),
                          ),
                          AppUtil.customText(
                            text: "View All",
                            style: TextStyle(
                                decoration: TextDecoration.underline,
                                color: ConstClass.themeColor,
                                fontFamily: 'Open Sans',
                                fontWeight: FontWeight.w600,
                                fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.symmetric(horizontal: 15, vertical: 0),
                      child: GridView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: logic.studentAcademicList.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                              onTap: () {
                                logic.onItemTapped(index);
                              },
                              child: buildAcademicWidget(
                                  logic.studentAcademicList[index]));
                        },
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                                childAspectRatio: 5 / 5,
                                crossAxisSpacing: 5,
                                mainAxisSpacing: 5),
                      ),
                    ),
                    _buildCalendarMonth(logic),
                    Card(
                      margin:
                          const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AppUtil.customText(
                              text: "Attendance",
                              style: const TextStyle(
                                  color: Color(0xff334155),
                                  fontFamily: 'Open Sans',
                                  fontWeight: FontWeight.w700,
                                  fontSize: 20),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: [
                                AppUtil.customText(
                                  text: "Student Attendance",
                                  style: const TextStyle(
                                      color: Color(0xff64748B),
                                      fontFamily: 'Open Sans',
                                      fontWeight: FontWeight.w700,
                                      fontSize: 12),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 6, vertical: 2),
                                  decoration: ShapeDecoration(
                                    color: const Color(0xFFF1F5F9),
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(4)),
                                  ),
                                  child: AppUtil.customText(
                                    text:
                                        "01 Jan ${logic.currentYear} - ${logic.currentDate}",
                                    style: TextStyle(
                                        decoration: TextDecoration.underline,
                                        color: ConstClass.themeColor,
                                        fontFamily: 'Open Sans',
                                        fontWeight: FontWeight.w700,
                                        fontSize: 10),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Obx(() {
                              if (logic.isAttendanceDataFound.value) {
                                return PieChart(
                                  dataMap: logic.graphData,
                                  animationDuration:
                                      const Duration(milliseconds: 800),
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
                                    //   legendLabels: logic.legendLabels,
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
                                );
                              } else {
                                return AppUtil.noDataFound("No Data Found");
                              }
                            }),
                            const SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                      ),
                    )
                  ]),
            ),
          );
        }
      })),
    );
  }
}

Widget _buildCalendarMonth(StudentHomeController logic) {
  return Card(
    margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
    elevation: 2,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8.0),
    ),
    child: Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Obx(
            () => TableCalendar(
              calendarBuilders: CalendarBuilders(
                holidayBuilder: (context, date, events) {
                  if (date.month == 1 && date.day == 26) {
                    return Container(
                      margin: const EdgeInsets.all(4.0),
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.red, // Highlight color
                      ),
                      child: Center(
                        child: Text(
                          '${date.day}',
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    );
                  } else {
                    return null;
                  }
                },
              ),
              eventLoader: (date) => logic.getEventsForDay(date),
              locale: 'en_US',
              firstDay: DateTime(DateTime.now().year - 5),
              lastDay: DateTime(DateTime.now().year + 5),
              calendarFormat: CalendarFormat.month,
              rangeSelectionMode: logic.rangeSelectionMode.value,
              startingDayOfWeek: StartingDayOfWeek.sunday,
              headerVisible: true,
              headerStyle: const HeaderStyle(
                titleTextStyle: TextStyle(
                    color: Color(0xff0F172A),
                    fontFamily: 'Open Sans',
                    fontWeight: FontWeight.w700,
                    fontSize: 14),
                formatButtonVisible: false,
                titleCentered: true,
              ),
              calendarStyle: CalendarStyle(
                outsideDaysVisible: false,
                isTodayHighlighted: true,
                todayTextStyle: const TextStyle(
                    color: Color(0xff64748B),
                    fontFamily: 'Open Sans',
                    fontWeight: FontWeight.w400,
                    fontSize: 12),
                todayDecoration: BoxDecoration(
                  color: const Color(0XFFD0E3FF),
                  borderRadius: BorderRadius.circular(
                    28,
                  ),
                  border: Border.all(
                    color: const Color(0XFF1575FF),
                    width: 0.9,
                  ),
                ),
              ),
              daysOfWeekStyle: const DaysOfWeekStyle(
                weekdayStyle: TextStyle(
                    color: Color(0xff64748B),
                    fontFamily: 'Open Sans',
                    fontWeight: FontWeight.w400,
                    fontSize: 12),
              ),
              rowHeight: 28,
              focusedDay: logic.focusedDay.value,
              rangeStartDay: logic.rangeStart,
              rangeEndDay: logic.rangeEnd,
              onDaySelected: (selectedDay, focusedDay) {
                if (!isSameDay(logic.selectedDay, selectedDay)) {
                  logic.focusedDay.value = focusedDay;
                  logic.selectedDay = selectedDay;
                  logic.rangeSelectionMode.value = RangeSelectionMode.toggledOn;
                }
              },
              onRangeSelected: (start, end, focusedDay) {
                logic.focusedDay.value = focusedDay;
                logic.rangeEnd = end;
                logic.rangeStart = start;
                logic.rangeSelectionMode.value = RangeSelectionMode.toggledOn;
              },
              onPageChanged: (focusedDay) {
                logic.focusedDay.value = focusedDay;
              },
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Container(
            color: const Color(0xffE2E8F0),
            height: 1.0,
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
            width: Get.width,
          ),
          const SizedBox(
            height: 5,
          ),
          calenderBottomItemsWidget(),
        ],
      ),
    ),
  );
}

Widget calenderBottomItemsWidget() {
  return Column(
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 8,
                width: 8,
                decoration: BoxDecoration(
                  color: const Color(0XFFFB7185),
                  borderRadius: BorderRadius.circular(
                    8,
                  ),
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              AppUtil.customText(
                text: "Regional Holiday",
                style: const TextStyle(
                    color: Color(0xff0F172A),
                    fontFamily: 'Open Sans',
                    fontWeight: FontWeight.w400,
                    fontSize: 12),
              ),
            ],
          ),
          const SizedBox(
            width: 15,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 8,
                width: 8,
                decoration: BoxDecoration(
                  color: const Color(0XFF48E17C),
                  borderRadius: BorderRadius.circular(
                    8,
                  ),
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              AppUtil.customText(
                text: "National Holiday",
                style: const TextStyle(
                    color: Color(0xff0F172A),
                    fontFamily: 'Open Sans',
                    fontWeight: FontWeight.w400,
                    fontSize: 12),
              ),
            ],
          ),
        ],
      ),
      const SizedBox(
        height: 10,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 8,
                width: 8,
                decoration: BoxDecoration(
                  color: const Color(0xff42B5C4),
                  borderRadius: BorderRadius.circular(
                    8,
                  ),
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              AppUtil.customText(
                text: "My Leaves",
                style: const TextStyle(
                    color: Color(0xff0F172A),
                    fontFamily: 'Open Sans',
                    fontWeight: FontWeight.w400,
                    fontSize: 12),
              ),
            ],
          ),
          const SizedBox(
            width: 15,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                "assets/icons/reminder_icon.png",
                height: 10,
                width: 10,
                fit: BoxFit.cover,
              ),
              const SizedBox(
                width: 5,
              ),
              AppUtil.customText(
                text: "Reminders",
                style: const TextStyle(
                    color: Color(0xff0F172A),
                    fontFamily: 'Open Sans',
                    fontWeight: FontWeight.w400,
                    fontSize: 12),
              ),
            ],
          ),
        ],
      ),
      const SizedBox(
        height: 10,
      ),
    ],
  );
}

Widget buildAcademicWidget(DashBoardModal academicList) {
  return Card(
    elevation: 2,
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            academicList.image!,
            width: 22,
            height: 22,
          ),
          const SizedBox(
            height: 5,
          ),
          AppUtil.customText(
            text: academicList.title!,
            style: const TextStyle(
                color: Color(0xff334155),
                fontFamily: 'Open Sans',
                fontWeight: FontWeight.w600,
                fontSize: 12),
          )
        ],
      ),
    ),
  );
}

Widget todayAttendanceWidget(StudentHomeController logic) {
  return Card(
    margin: const EdgeInsets.all(20),
    elevation: 2,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8.0),
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          AppUtil.customText(
                            text: logic.studentData != null
                                ? logic.studentData!.name
                                : "",
                            style: const TextStyle(
                                fontFamily: 'Open Sans',
                                fontWeight: FontWeight.w700,
                                fontSize: 16),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.edit,
                                size: 22,
                                color: ConstClass.themeColor,
                              ))
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      AppUtil.customText(
                        text:
                            "Class: ${logic.studentData != null ? logic.studentData!.className : ""} | Roll No: ${logic.studentData != null ? logic.studentData!.rollNo : ""}",
                        style: const TextStyle(
                            fontFamily: 'Open Sans',
                            fontWeight: FontWeight.w600,
                            fontSize: 12),
                      ),
                    ],
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(50.0),
                    child: Image.asset(
                      "assets/images/profile.png",
                      height: 50,
                      width: 50,
                      fit: BoxFit.cover,
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AppUtil.customText(
                    text: "Overall Performance",
                    style: const TextStyle(
                        fontFamily: 'Open Sans',
                        fontWeight: FontWeight.w600,
                        fontSize: 10),
                  ),
                  AppUtil.customText(
                    text: "75%",
                    style: const TextStyle(
                        fontFamily: 'Open Sans',
                        fontWeight: FontWeight.w600,
                        fontSize: 12),
                  ),
                ],
              ),
              const SizedBox(
                height: 3,
              ),
              Container(
                height: 5,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    2,
                  ),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(
                    2,
                  ),
                  child: LinearProgressIndicator(
                    value: 0.85,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      ConstClass.themeColor,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          color: Colors.grey,
          height: 1.0,
          width: Get.width,
        ),
        const SizedBox(
          height: 5,
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SvgPicture.asset(
                    "assets/icons/today_attend_icon.svg",
                    width: 36,
                    height: 36,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppUtil.customText(
                        text: "Today Attendance",
                        style: const TextStyle(
                            fontFamily: 'Open Sans',
                            fontWeight: FontWeight.w400,
                            fontSize: 14),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color(0xff0DB166),
                            ),
                            width: 10,
                            height: 10,
                          ),
                          const SizedBox(
                            width: 3,
                          ),
                          AppUtil.customText(
                            text: "Present",
                            style: const TextStyle(
                                fontFamily: 'Open Sans',
                                fontWeight: FontWeight.w400,
                                fontSize: 10),
                          ),
                        ],
                      )
                    ],
                  )
                ],
              ),
              AppUtil.customText(
                text: logic.currentDate,
                style: const TextStyle(
                    fontFamily: 'Open Sans',
                    fontWeight: FontWeight.w400,
                    fontSize: 10),
              ),
            ],
          ),
        )
      ],
    ),
  );
}
