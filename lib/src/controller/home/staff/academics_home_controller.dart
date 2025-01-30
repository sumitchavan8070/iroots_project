import 'package:get/get.dart';
import 'package:iroots/src/modal/dashboardModalClass.dart';
import 'package:iroots/src/ui/dashboard/attendance/staff/staff_attendence.dart';
import 'package:iroots/src/ui/dashboard/homework/staff/staff_homework.dart';
import 'package:iroots/src/ui/dashboard/scholastic/staff/scholastic.dart';
import 'package:iroots/src/ui/dashboard/staff/fill_marks/staff/staff_fill_marks.dart';

class AcademicsController extends GetxController {
  final List<DashBoardModal> staffAcademicList = [
    DashBoardModal(
        title: "Fill Marks",
        image: "assets/icons/staff_icons/staff_fill_marks_icon.svg"),
    DashBoardModal(
        title: "Fill Attendance",
        image: "assets/icons/academicIcons/academics_attendance_icon.svg"),
    DashBoardModal(
        title: "Fill Co-Scholastic",
        image: "assets/icons/academicIcons/academics_fill_co_scholastic.svg"),
    DashBoardModal(
        title: "Homework",
        image: "assets/icons/academicIcons/academics_home_icon.svg"),
    DashBoardModal(
        title: "Payroll",
        image: "assets/icons/staff_icons/staff_payroll_icon.svg"),
    DashBoardModal(
        title: "Time Table",
        image: "assets/icons/academicIcons/academics_time_table_icon.svg"),
    DashBoardModal(
        title: "Messenger",
        image: "assets/icons/staff_icons/staff_message_icon.svg"),
  ];

  void onItemTapped(int index) {
    switch (index) {
      case 0:
        Get.to(() =>  StaffFillMarksScreen());
        break;
      case 1:
        Get.to(() => const StaffAttendanceScreen());
        break;
      case 2:
        Get.to(() => const ScholasticScreen());
        break;
      case 3:
        Get.to(() => const StaffHomeworkScreen());
        break;

      default:
        break;
    }
  }
}
