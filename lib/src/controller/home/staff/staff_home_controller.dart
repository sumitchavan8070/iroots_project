import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:iroots/common/app_data.dart';
import 'package:iroots/src/modal/attendance/studentAttendanceModalClass.dart';
import 'package:iroots/src/modal/dashboardModalClass.dart';
import 'package:iroots/src/modal/home/staff/staffDetails.dart';
import 'package:iroots/src/ui/auth/login_page.dart';
import 'package:iroots/src/ui/dashboard/admin/admin_coscholastic/admin_coscholastic_screen.dart';
import 'package:iroots/src/ui/dashboard/admin/fill_marks/admin_fill_marks.dart';
import 'package:iroots/src/ui/dashboard/attendance/staff/staff_attendence.dart';
import 'package:iroots/src/ui/dashboard/homework/staff/staff_homework.dart';
import 'package:iroots/src/utility/const.dart';
import 'package:iroots/src/utility/util.dart';
import 'package:table_calendar/table_calendar.dart';

class StaffHomeController extends GetxController {
  final GetStorage box = Get.put(GetStorage());

  String staffId = "";

  Rx<StaffDetail> staffDetail = StaffDetail().obs;

  // Staff? staffClass;
  // StaffDetails? staffDetails;
  // Staff? staffSection;
  DateTime? rangeStart;
  Datum? studentAttendanceData;
  DateTime? rangeEnd;
  RxBool isAttendanceDataFound = false.obs;
  DateTime? selectedDay;
  Rx<DateTime> focusedDay = DateTime.now().obs;
  Rx<RangeSelectionMode> rangeSelectionMode = RangeSelectionMode.toggledOn.obs;
  RxBool showProgress = false.obs;
  String? currentDate;
  String? currentYear;
  String? accessToken;

  Map<String, double> graphData = {};

  @override
  void onInit() {
    accessToken = box.read("accessToken");

    currentYear = DateTime.now().year.toString();
    currentDate = DateFormat('dd MMM yyyy').format(DateTime.now());
    fetchStaffDetails();

    super.onInit();
  }

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

  final colorList = <Color>[
    Colors.green,
    Colors.red,
  ];

  void onItemTapped(int index) {
    switch (index) {
      case 0:
        Get.to(() => const StaffAttendanceScreen());
        break;
      case 1:
        Get.to(() => AdminFillMarksScreen(
              fromAdmin: false,
              staffDetail: staffDetail.value,
            ));

        break;
      case 2:
        Get.to(() => AdminCoScholasticScreen(
              fromAdmin: false,
              staffDetail: staffDetail.value,
            ));
        break;
      case 3:
        Get.to(() => const StaffHomeworkScreen());
        break;

      default:
        break;
    }
  }

  List<dynamic> getEventsForDay(DateTime day) {
    if (day.month == 1 && day.day == 26) {
      return ['Republic Day'];
    } else if (day.month == 8 && day.day == 15) {
      return ['Independence Day'];
    } else {
      return [];
    }
  }

  Future<void> fetchStaffDetails() async {
    _showProgress();

    Map<String, String>? credentials = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $accessToken',
    };

    try {
      final response = await http.get(
          Uri.parse("${baseUrlName}UserCredentials/GetStaffDetails"),
          headers: credentials);

      if (response.statusCode == 200) {
        var loginResponse = staffDetailsModalFromMap(response.body);
        if (loginResponse.responseCode.toString() == "200") {
          if (loginResponse.data!.isNotEmpty) {
            if (loginResponse.data!.isNotEmpty) {
              staffDetail.value = loginResponse.data![0];
            }
          }
          _hideProgress();
        } else if (loginResponse.responseCode == "500") {
          AppUtil.snackBar("Something went wrong");
          _hideProgress();
        } else {
          // AppUtil.snackBar(loginResponse.msg!);
          _hideProgress();
        }
      } else if (response.statusCode == 401) {
        _hideProgress();
        AppUtil.showAlertDialog(onPressed: () {
          Get.back();
          box.remove('accessToken');
          box.remove('isUserLogin');
          box.remove('userRole');
          Get.offAll(() => const LoginPage());
        });
      } else {
        AppUtil.snackBar('Something went wrong');
        _hideProgress();
      }
    } catch (error) {
      AppUtil.snackBar('$error');
      _hideProgress();
    }
  }

  void _showProgress() {
    showProgress.value = true;
  }

  void _hideProgress() {
    showProgress.value = false;
  }
}
