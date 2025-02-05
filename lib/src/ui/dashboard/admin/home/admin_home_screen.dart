import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:iroots/src/controller/home/admin/admin_home_controller.dart';
import 'package:iroots/src/modal/dashboardModalClass.dart';
import 'package:iroots/src/ui/dashboard/admin/admin_coscholastic/admin_coscholastic_screen.dart';
import 'package:iroots/src/ui/dashboard/admin/admin_report_card/admin_report_card_screen.dart';
import 'package:iroots/src/ui/dashboard/admin/fill_marks/admin_fill_marks.dart';
import 'package:iroots/src/ui/dashboard/attendance/admin/admin_attendence.dart';
import 'package:iroots/src/ui/dashboard/homework/admin/admin_homework.dart';
import 'package:iroots/src/ui/dashboard/payment/LoadAttendenceDataController.dart';
import 'package:iroots/src/ui/dashboard/reports/staff_report_card.dart';
import 'package:iroots/src/ui/dashboard/staff/home/staff_home_screen.dart';
import 'package:iroots/src/ui/dashboard/student/components/AdminCard.dart';
import 'package:iroots/src/ui/dashboard/student/components/attendance_view.dart';
import 'package:iroots/src/ui/dashboard/student/components/percentage_chart.dart';
import 'package:iroots/src/ui/dashboard/student/components/student_report_widget.dart';
import 'package:iroots/src/ui/dashboard/student/components/stuff_activity_card.dart';
import 'package:iroots/src/utility/const.dart';
import 'package:iroots/src/utility/constant/asset_path.dart';
import 'package:iroots/src/utility/util.dart';
import 'package:lottie/lottie.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../student/components/admin_card_list_wdget.dart';

final _loadAttendeanceController = Get.put(LoadAttendenceDataController());

class AdminHomePageScreen extends StatefulWidget {
  const AdminHomePageScreen({super.key});

  @override
  State<AdminHomePageScreen> createState() => _AdminHomePageScreenState();
}

class _AdminHomePageScreenState extends State<AdminHomePageScreen> {
  final ScrollController _scrollController = ScrollController();
  final RxInt _currentIndex = 0.obs;
  final List<Widget> textItems = [
    const AdminCard(
      heading: "Total Students ",
      headingCount: "1500",
      title: "New Admissions",
      titleCount: "1480",
      subTitle: "Absent",
      subTitleCount: "20",
      bgImage: AssetPath.adminBgOne,
      cardImage: AssetPath.onePNG,
    ),
    const AdminCard(
      heading: "Total Staff",
      headingCount: "80",
      title: "New Join",
      titleCount: "40",
      subTitle: "Absent",
      subTitleCount: "05",
      bgImage: AssetPath.adminBgTwo,
      cardImage: AssetPath.twoPNG,
    ),
    const AdminCard(
      heading: "Free Collection",
      headingCount: "\$ 500",
      title: "New Total",
      titleCount: "\$ 1200",
      subTitle: "",
      subTitleCount: "",
      bgImage: AssetPath.adminBgThree,
      cardImage: AssetPath.threePNG,
    ),
    const AdminCard(
      heading: "Applied TC",
      headingCount: "05",
      title: "",
      titleCount: "",
      subTitle: "",
      subTitleCount: "",
      bgImage: AssetPath.adminBgFour,
      cardImage: AssetPath.fourPNG,
    ),
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _scrollController.addListener(() {
      final screenWidth = MediaQuery.of(context).size.width;
      final itemWidth = screenWidth * 0.85 + 24;
      final value = (_scrollController.offset / itemWidth).round();
      final index = value.clamp(0, textItems.length - 1);

      if (_currentIndex.value != index) {
        _currentIndex.value = index;
      }
    });

    _loadApi();
  }

  _loadApi() async {
    await _loadAttendeanceController.loadAttendece(
      startDate: "2024-01-01",
      endDate: "2024-12-30",
      fromYear: "2024",
      toYear: "2025",
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: AdminHomeController(),
      builder: (logic) => Scaffold(
        body: SingleChildScrollView(
          child: Container(
            color: const Color(0xffF1F5F9),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),

                const AdminCardListWidget(),

                // topBarWidget(),
                const SizedBox(height: 10),
                // academicYearWidget(logic),

                // const SizedBox(height: 10),
                // studentAndTeacherWidget(),
                // const SizedBox(height: 10),
                // studentReportWidget(),
                const SizedBox(height: 10),
                // _Grid(),
                const StudentActivityWidget(),
                _loadAttendeanceController.obx(
                  (state) {
                    final attendanceData = state?.data?.dateRangeAttendance;
                    if(state?.responseCode == "500"){
                      Lottie.asset(AssetPath.noDataFound);
                    }

                    return AttendanceView(
                      attendanceData: attendanceData  ,
                    );
                  },
                  onEmpty: Lottie.asset(AssetPath.noDataFound),
                  onError: (error) {
                    return Lottie.asset(AssetPath.noDataFound);
                  },
                  onLoading: const CircularProgressIndicator(),
                ),
                const SizedBox(height: 10),

                // lineChartWidget(logic),
                SizedBox(height: 270, child: PercentageLineChart()),

                const SizedBox(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget customRowWidget(String text, String textValue, Color color) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(15),
              ),
              padding: const EdgeInsets.symmetric(
                vertical: 2,
                horizontal: 10,
              ),
              child: AppUtil.customText(
                text: text,
                style: const TextStyle(
                  color: Colors.white,
                  fontFamily: 'Open Sans',
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                ),
              ),
            ),
            const SizedBox(height: 5),
            AppUtil.customText(
              text: textValue,
              style: const TextStyle(
                color: Color(0xff334155),
                fontFamily: 'Open Sans',
                fontWeight: FontWeight.w700,
                fontSize: 16,
              ),
            )
          ],
        ),
        const SizedBox(width: 5),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 2),
          child: AppUtil.customText(
            text: "Students: ",
            style: const TextStyle(
              color: Color(0xff334155),
              fontFamily: 'Open Sans',
              fontWeight: FontWeight.w600,
              fontSize: 12,
            ),
          ),
        ),
      ],
    );
  }

  customDropDown(AdminHomeController? logic, String? hintText,
      List<String> yearList, void Function(String) onChanged, String? value) {
    return DropdownButtonFormField<String>(
      icon: SvgPicture.asset(
        "assets/icons/arrowdown_icon.svg",
        height: 20,
        width: 20,
      ),
      value: value,
      items: yearList.map((item) {
        return DropdownMenuItem<String>(
          value: item,
          child: AppUtil.customText(
            text: item,
            style: const TextStyle(
              color: Color(0xff0F172A),
              fontFamily: 'Open Sans',
              fontWeight: FontWeight.w400,
              fontSize: 14,
            ),
          ),
        );
      }).toList(),
      onChanged: (newValue) {
        onChanged(newValue!);
      },
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(10),
        hintText: hintText,
        hintStyle: const TextStyle(
            color: Color(0xff0F172A),
            fontFamily: 'Open Sans',
            fontWeight: FontWeight.w400,
            fontSize: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(
            color: Color(0xff94A3B8),
            width: 1,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(
            color: Color(0xff94A3B8),
            width: 1,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(
            color: Color(0xff94A3B8),
            width: 1,
          ),
        ),
      ),
    );
  }

  customDropDown1(AdminHomeController? logic, List<String> yearList,
      void Function(String) onChanged, String? value) {
    return DropdownButtonFormField<String>(
      icon: SvgPicture.asset(
        "assets/icons/arrowdown_icon.svg",
        height: 14,
        width: 14,
      ),
      value: value,
      style: TextStyle(
        color: ConstClass.themeColor,
        fontFamily: 'Open Sans',
        fontWeight: FontWeight.w700,
        fontSize: 10,
      ),
      items: yearList.map((item) {
        return DropdownMenuItem<String>(
          value: item,
          child: AppUtil.customText(
            text: "Last $item Years",
            style: const TextStyle(
              color: Color(0xff0F172A),
              fontFamily: 'Open Sans',
              fontWeight: FontWeight.w400,
              fontSize: 10,
            ),
          ),
        );
      }).toList(),
      onChanged: (newValue) {
        onChanged(newValue!);
      },
      decoration: const InputDecoration(
        contentPadding: EdgeInsets.symmetric(vertical: 0),
      ),
    );
  }

  Widget studentReportWidget() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 0),
      child: Card(
        elevation: 1,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AppUtil.customText(
                text: "Student Report",
                style: const TextStyle(
                  color: Color(0xff334155),
                  fontFamily: 'Open Sans',
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  customRowWidget("Pass", "1500", const Color(0XFF70D976)),
                  customRowWidget("Fail", "300", const Color(0XFFFF7474)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget academicYearWidget(AdminHomeController logic) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          AppUtil.customText(
            textAlign: TextAlign.center,
            text: "Academics year",
            style: const TextStyle(
              color: Color(0xff0F172A),
              fontFamily: 'Open Sans',
              fontWeight: FontWeight.w700,
              fontSize: 14,
            ),
          ),
          SizedBox(
            width: 0.4,
            child: customDropDown(logic, "Select Year", logic.yearList,
                (newValue) {
              logic.selectedYear = newValue;
            }, logic.selectedYear),
          ),
        ],
      ),
    );
  }

  Widget studentAndTeacherWidget() {
    return SizedBox(
      height: 100,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 0),
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: [
            studentAndTeacherCardWidget(),
            // studentAndTeacherCardWidget(),
          ],
        ),
      ),
    );
  }

  Widget topBarWidget() {
    return Container(
      padding: const EdgeInsets.only(top: 10, bottom: 10, left: 0, right: 0),
      color: ConstClass.themeColor,
      width: Get.width,
      height: 35,
      child: AppUtil.customText(
        textAlign: TextAlign.center,
        text: "Welcome ",
        style: const TextStyle(
          color: Colors.white,
          fontFamily: 'Open Sans',
          fontWeight: FontWeight.w700,
          fontSize: 16,
        ),
      ),
    );
  }

  Widget studentAndTeacherCardWidget() {
    return Card(
      elevation: 1,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IntrinsicHeight(
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xFF6EDD74),
                    ),
                    child: Image.asset(
                      "assets/icons/graduation.png",
                      width: 22,
                      height: 22,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppUtil.customText(
                        text: "Total Students",
                        style: const TextStyle(
                          color: Color(0xff334155),
                          fontFamily: 'Open Sans',
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                        ),
                      ),
                      AppUtil.customText(
                        text: "1500",
                        style: const TextStyle(
                          color: Color(0xff334155),
                          fontFamily: 'Open Sans',
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                        ),
                      )
                    ],
                  ),
                  const SizedBox(width: 5),
                ],
              ),
            ),
            const SizedBox(height: 8),
            IntrinsicHeight(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  RichText(
                    text: const TextSpan(
                      text: "New Admission : ",
                      style: TextStyle(
                        color: Color(0xff64748B),
                        fontFamily: 'Open Sans',
                        fontWeight: FontWeight.w400,
                        fontSize: 12,
                      ),
                      children: [
                        TextSpan(
                          text: "1480",
                          style: TextStyle(
                            color: Color(0xff334155),
                            fontFamily: 'Open Sans',
                            fontWeight: FontWeight.w600,
                            fontSize: 12,
                          ),
                        )
                      ],
                    ),
                    textAlign: TextAlign.start,
                  ),
                  const SizedBox(width: 10),
                  const VerticalDivider(
                    endIndent: 2,
                    indent: 2,
                    color: Color(0xff94A3B8),
                    thickness: 1,
                  ),
                  const SizedBox(width: 10),
                  RichText(
                    text: const TextSpan(
                      text: "Absent : ",
                      style: TextStyle(
                        color: Color(0xff64748B),
                        fontFamily: 'Open Sans',
                        fontWeight: FontWeight.w400,
                        fontSize: 12,
                      ),
                      children: [
                        TextSpan(
                          text: "20",
                          style: TextStyle(
                            color: Color(0xff334155),
                            fontFamily: 'Open Sans',
                            fontWeight: FontWeight.w600,
                            fontSize: 12,
                          ),
                        )
                      ],
                    ),
                    textAlign: TextAlign.start,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildCalendarMonth(AdminHomeController logic) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
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
                    fontSize: 14,
                  ),
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
                    fontSize: 12,
                  ),
                ),
                rowHeight: 28,
                focusedDay: logic.focusedDay.value,
                rangeStartDay: logic.rangeStart,
                rangeEndDay: logic.rangeEnd,
                onDaySelected: (selectedDay, focusedDay) {
                  if (!isSameDay(logic.selectedDay, selectedDay)) {
                    logic.focusedDay.value = focusedDay;
                    logic.selectedDay = selectedDay;
                    logic.rangeSelectionMode.value =
                        RangeSelectionMode.toggledOn;
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
            const SizedBox(height: 5),
            Container(
              color: const Color(0xffE2E8F0),
              height: 1.0,
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
              width: Get.width,
            ),
            const SizedBox(height: 5),
            calenderBottomItemsWidget(),
          ],
        ),
      ),
    );
  }

  Widget lineChartWidget(AdminHomeController logic) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 0),
      child: Card(
        elevation: 1,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  AppUtil.customText(
                    textAlign: TextAlign.center,
                    text: "Student Performance",
                    style: const TextStyle(
                      color: Color(0xff0F172A),
                      fontFamily: 'Open Sans',
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
                    ),
                  ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
                    decoration: ShapeDecoration(
                      color: const Color(0xFFF1F5F9),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4)),
                    ),
                    child: SizedBox(
                      width: 0.2,
                      height: 40,
                      child: customDropDown1(logic, logic.lineChartList,
                          (newValue) {
                        logic.selectedLastYear = newValue;


                        logic.selectYear();
                      }, logic.selectedLastYear),
                    ),
                  ),
                ],
              ),
              SizedBox(
                width: Get.width,
                height: 200,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: LineChart(
                    logic.sampleData1,
                    swapAnimationCurve: Curves.easeInOutQuart,
                    swapAnimationDuration: const Duration(milliseconds: 250),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Grid Class

class _Grid extends StatelessWidget {
  _Grid({super.key});

  final List<DashBoardModal> staffAcademicList = [
    DashBoardModal(
      title: "Fill Attendance",
      image: "assets/icons/academicIcons/academics_attendance_icon.svg",
    ),
    DashBoardModal(
      title: "Fill Marks",
      image: "assets/icons/staff_icons/staff_fill_marks_icon.svg",
    ),
    DashBoardModal(
      title: "Fill Co-Scholastic",
      image: "assets/icons/academicIcons/academics_fill_co_scholastic.svg",
    ),
    DashBoardModal(
      title: "Homework",
      image: "assets/icons/academicIcons/academics_home_icon.svg",
    ),
    DashBoardModal(
      title: "Time Table",
      image: "assets/icons/academicIcons/academics_time_table_icon.svg",
    ),
    DashBoardModal(
      title: "Payroll",
      image: "assets/icons/staff_icons/staff_payroll_icon.svg",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppUtil.customText(
                text: "Academics",
                style: const TextStyle(
                  fontFamily: 'Open Sans',
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                ),
              ),
              GestureDetector(
                onTap: () {
                  // Get.to(() => const AcademicsFullScreen());
                },
                child: AppUtil.customText(
                  text: "View All",
                  style: TextStyle(
                    decoration: TextDecoration.underline,
                    color: ConstClass.themeColor,
                    fontFamily: 'Open Sans',
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 5),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 0),
          child: GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: staffAcademicList.length,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  switch (index) {
                    case 0:
                      Get.to(() => const AdminAttendanceScreen());
                      break;
                    case 1:
                      Get.to(() => const AdminFillMarksScreen(
                            fromAdmin: true,
                          ));

                      break;
                    case 2:
                      Get.to(() => const AdminCoScholasticScreen(
                            fromAdmin: true,
                          ));
                      break;
                    case 3:
                      Get.to(() => const AdminHomeworkScreen());
                      break;

                    case 4:
                      Get.to(() => AdminReportCardScreen());
                      break;

                    default:
                      break;
                  }
                },
                child: buildAcademicWidget(
                  staffAcademicList[index],
                ),
              );
            },
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: 5 / 5,
              crossAxisSpacing: 5,
              mainAxisSpacing: 5,
            ),
          ),
        ),
      ],
    );
  }
}
