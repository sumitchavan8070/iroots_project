import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:iroots/src/controller/attendance/staff/staff_attendance_controller.dart';
import 'package:iroots/src/ui/dashboard/attendance/staff/get_class_list_model.dart';
import 'package:iroots/src/ui/dashboard/attendance/staff/get_section_list_model.dart';
import 'package:iroots/src/ui/dashboard/attendance/staff/get_staff_list_model.dart';
import 'package:iroots/src/ui/dashboard/attendance/staff/update_staff_attendence.dart';
import 'package:iroots/src/ui/dashboard/attendance/staff/view_attendence.dart';
import 'package:iroots/src/utility/const.dart';
import 'package:iroots/src/utility/util.dart';

final classController = Get.put(ClassController());
final _staffAttendanceController = Get.put(StaffAttendanceController());

class StaffAttendanceScreen extends StatefulWidget {
  const StaffAttendanceScreen({super.key});

  @override
  State<StaffAttendanceScreen> createState() => _StaffAttendanceScreenState();
}

class _StaffAttendanceScreenState extends State<StaffAttendanceScreen> {
  String? _selectedClass;
  String? _selectedSection;
  String? _selectedStaff;
  String? _selectedStaffID;
  String? _selectedSectionID;
  String? _selectedClassID;
  final prefs = GetStorage();

  _loadClassFromApi() async {
    await classController.fetchGetStaffList();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _loadClassFromApi();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    classController.selectedClass.value = "";
    classController.selectedStaffId.value = "";
    classController.selectedSectionID.value = "";
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: StaffAttendanceController(),
      builder: (logic) => Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: ConstClass.dashBoardColor,
          title: AppUtil.customText(
            text: "Student Attendance",
            style: const TextStyle(
              fontFamily: 'Open Sans',
              fontWeight: FontWeight.w700,
              fontSize: 16,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            color: const Color(0xffF1F5F9),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  classController.obx(
                    (state) {
                      return _selectStaffWidget(
                        title: "Select Staff",
                        onChanged: (selectedStaff, staffID) async {
                          setState(() {
                            _selectedStaff = selectedStaff;
                            _selectedStaffID = staffID;
                          });

                          await classController.fetchClassData(staffID);
                          classController.studentNameIdForAPi.value = selectedStaff ;


                          debugPrint(
                              "selectedClass $selectedStaff || selectedClassID $staffID");
                        },
                        getStaffListModel: state?.model3 ?? GetStaffListModel(),
                        context: context,
                      );
                    },
                  ),

                  const SizedBox(height: 10),
                  classController.obx(
                    (state) {
                      return _selectClass(
                        title: "Select Class",
                        onChanged: (selectedClass, selectedClassID) async {
                          setState(() {
                            _selectedSection = selectedClass;
                            _selectedSectionID = selectedClassID;
                          });
                          debugPrint(
                              "selectedClass $selectedClass || selectedClassID $selectedClassID");
                          await classController.fetchSectionData(
                            selectedClassID,
                            _selectedStaffID.toString(),
                          );
                          classController.classIdForAPi.value = selectedClassID ;
                          classController.classNameIdForAPi.value = selectedClass ;

                        },
                        getClassListModel: state?.model1 ?? GetClassListModel(),
                        context: context,
                      );
                    },
                  ),
                  const SizedBox(height: 10),
                  classController.obx(
                    (state) {
                      return _selectSection(
                        title: "Select Section",
                        onChanged: (selectedSection, selectedSectionID) {
                          setState(() {
                            _selectedSection = selectedSection;
                            _selectedSectionID = selectedSectionID;
                          });
                          classController.sectionIdForAPi.value = selectedSectionID ;
                          classController.sectionNameIdForAPi.value = selectedSection ;

                          debugPrint(
                              "selectedClass $_selectedSection || selectedClassID $selectedSectionID");
                        },
                        getSectionListModel:
                            state?.model2 ?? GetSectionListModel(),
                        context: context,
                      );
                    },
                  ),

                  const SizedBox(height: 10),
                  // customDropDown(
                  //     "Select Section",
                  //     // logic.staffHomeWorkController.staffSection
                  //     //         ?.dataListItemName ??
                  //     ""),
                  const SizedBox(height: 10),
                  AppUtil.customText(
                    text: "Select Date",
                    style: const TextStyle(
                        fontFamily: 'Open Sans',
                        fontWeight: FontWeight.w600,
                        fontSize: 14),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  customOutlinedButton(
                      OutlinedButton.styleFrom(
                        side: const BorderSide(
                            width: 1.0, color: Color(0xff94A3B8)),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 0, vertical: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            AppUtil.customText(
                              text: logic.formatDate(),
                              style: const TextStyle(
                                  color: Color(0xff0F172A),
                                  fontFamily: 'Open Sans',
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14),
                            ),
                            SvgPicture.asset(
                              "assets/icons/calendar_icon.svg",
                              height: 20,
                              width: 20,
                            )
                          ],
                        ),
                      ), () {
                    logic.pickDateDialog(context);
                  }),
                  const SizedBox(
                    height: 20,
                  ),
                  Obx(() {
                    if (logic.showProgress.value) {
                      return const Center(child: CircularProgressIndicator());
                    } else {
                      return SizedBox(
                        width: Get.width,
                        child: customOutlinedButton(
                            OutlinedButton.styleFrom(
                              side: const BorderSide(
                                  width: 1.0, color: Color(0xff94A3B8)),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 0, vertical: 10),
                              child: AppUtil.customText(
                                text: "Show",
                                style: const TextStyle(
                                    color: Color(0xff1575FF),
                                    fontFamily: 'Open Sans',
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16),
                              ),
                            ), () {

                          logic.showStudentAttendance();
                        }),
                      );
                    }
                  }),
                  const SizedBox(
                    height: 10,
                  ),
                  Obx(() {
                    if (logic.isFirstTime.value) {
                      return const SizedBox();
                    } else if (logic.isDataFound.value) {
                      return ConstrainedBox(
                        constraints: const BoxConstraints(maxHeight: 255),
                        child: Scrollbar(
                          controller: logic.verticalScrollController,
                          thickness: 8,
                          radius: const Radius.circular(8),
                          interactive: true,
                          thumbVisibility: true,
                          child: SingleChildScrollView(
                            controller: logic.verticalScrollController,
                            scrollDirection: Axis.vertical,
                            child: Scrollbar(
                              controller: logic.horizontalScrollController,
                              thickness: 8,
                              radius: const Radius.circular(8),
                              interactive: true,
                              thumbVisibility: true,
                              child: SingleChildScrollView(
                                controller: logic.horizontalScrollController,
                                scrollDirection: Axis.horizontal,
                                child: Scrollable(
                                  viewportBuilder: (BuildContext context,
                                      ViewportOffset position) {
                                    return DataTable(
                                      border: TableBorder.all(),
                                      columns: List<DataColumn>.generate(
                                        10,
                                        (index) => DataColumn(
                                            label: index == 5
                                                ? IconButton(
                                                    onPressed: () {
                                                      logic
                                                          .markAllFullAttendance();
                                                    },
                                                    icon: logic.fullAttendance !=
                                                                null &&
                                                            logic.fullAttendance!
                                                                    .markFullDayAbsent ==
                                                                "True"
                                                        ? const Icon(
                                                            Icons.check_box)
                                                        : const Icon(Icons
                                                            .check_box_outline_blank),
                                                    color:
                                                        ConstClass.themeColor,
                                                  )
                                                : index == 7
                                                    ? IconButton(
                                                        onPressed: () {
                                                          logic
                                                              .markAllHalfAttendance();
                                                        },
                                                        icon: logic.halfAttendance !=
                                                                    null &&
                                                                logic.halfAttendance!
                                                                        .markHalfDayAbsent ==
                                                                    "True"
                                                            ? const Icon(
                                                                Icons.check_box)
                                                            : const Icon(Icons
                                                                .check_box_outline_blank),
                                                        color: ConstClass
                                                            .themeColor,
                                                      )
                                                    : index == 9
                                                        ? IconButton(
                                                            onPressed: () {
                                                              logic
                                                                  .markAllOthersAttendance();
                                                            },
                                                            icon: logic.othersAttendance !=
                                                                        null &&
                                                                    logic.othersAttendance!
                                                                            .others ==
                                                                        "True"
                                                                ? const Icon(Icons
                                                                    .check_box)
                                                                : const Icon(Icons
                                                                    .check_box_outline_blank),
                                                            color: ConstClass
                                                                .themeColor,
                                                          )
                                                        : AppUtil.customText(
                                                            textAlign: TextAlign
                                                                .center,
                                                            text: getColumnName(
                                                                index),
                                                            style: const TextStyle(
                                                                color: Color(
                                                                    0xff0F172A),
                                                                fontFamily:
                                                                    'Open Sans',
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                fontSize: 12),
                                                          )),
                                      ),
                                      rows: logic.dummyList
                                          .asMap()
                                          .map((index, item) {
                                            return MapEntry(
                                                index,
                                                DataRow(
                                                  cells: [
                                                    datacell("${index + 1}"),
                                                    datacell(item.studentName),
                                                    datacell(item.className),
                                                    datacell(item.sectionName),
                                                    datacell("A"),
                                                    DataCell(IconButton(
                                                      onPressed: () {
                                                        logic
                                                            .markFullAttendance(
                                                                item);
                                                      },
                                                      icon: item.markFullDayAbsent ==
                                                              "True"
                                                          ? const Icon(
                                                              Icons.check_box)
                                                          : const Icon(Icons
                                                              .check_box_outline_blank),
                                                      color:
                                                          ConstClass.themeColor,
                                                    )),
                                                    datacell("H"),
                                                    DataCell(IconButton(
                                                      onPressed: () {
                                                        logic
                                                            .markHalfAttendance(
                                                                item);
                                                      },
                                                      icon: item.markHalfDayAbsent ==
                                                              "True"
                                                          ? const Icon(
                                                              Icons.check_box)
                                                          : const Icon(Icons
                                                              .check_box_outline_blank),
                                                      color:
                                                          ConstClass.themeColor,
                                                    )),
                                                    datacell("O"),
                                                    DataCell(IconButton(
                                                      onPressed: () {
                                                        logic
                                                            .markOtherAttendance(
                                                                item);
                                                      },
                                                      icon: item.others ==
                                                              "True"
                                                          ? const Icon(
                                                              Icons.check_box)
                                                          : const Icon(Icons
                                                              .check_box_outline_blank),
                                                      color:
                                                          ConstClass.themeColor,
                                                    )),
                                                  ],
                                                ));
                                          })
                                          .values
                                          .toList(),
                                    );
                                  },
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    } else if (!logic.showProgress.value) {
                      return Padding(
                        padding: const EdgeInsets.all(50.0),
                        child: AppUtil.noDataFound("No Data Found"),
                      );
                    } else {
                      return const SizedBox();
                    }
                  }),
                  Obx(() {
                    if (logic.isDataFound.value) {
                      return const SizedBox(
                        height: 24,
                      );
                    } else {
                      return const SizedBox();
                    }
                  }),
                  SizedBox(
                    width: Get.width,
                    child: customOutlinedButton(
                        OutlinedButton.styleFrom(
                          backgroundColor: ConstClass.themeColor,
                          side: BorderSide(
                              width: 1.5, color: ConstClass.themeColor),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 0, vertical: 10),
                          child: AppUtil.customText(
                            text: "Update Students Attendence",
                            style: const TextStyle(
                                color: Colors.white,
                                fontFamily: 'Open Sans',
                                fontWeight: FontWeight.w600,
                                fontSize: 14),
                          ),
                        ), () {
                      Get.to(() => const UpdateStaffAttendanceScreen());
                    }),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    width: Get.width,
                    child: customOutlinedButton(
                        OutlinedButton.styleFrom(
                          side: BorderSide(
                              width: 1.5, color: ConstClass.themeColor),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 0, vertical: 10),
                          child: AppUtil.customText(
                            text: "View Students Attendance",
                            style: const TextStyle(
                                color: Color(0xff1575FF),
                                fontFamily: 'Open Sans',
                                fontWeight: FontWeight.w600,
                                fontSize: 14),
                          ),
                        ), () {
                      Get.to(() => const ViewAttendanceScreen());
                    }),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Obx(() {
                    if (!logic.isDataFound.value) {
                      return const SizedBox();
                    } else if (logic.saveAttenShowProgress.value) {
                      return const Center(child: CircularProgressIndicator());
                    } else {
                      return SizedBox(
                        width: Get.width,
                        child: customOutlinedButton(
                            OutlinedButton.styleFrom(
                              side: const BorderSide(
                                  width: 1.5, color: Color(0xff0DB166)),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 0, vertical: 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(
                                    "assets/icons/save_icon.svg",
                                    height: 16,
                                    width: 16,
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  AppUtil.customText(
                                    text: "Save",
                                    style: const TextStyle(
                                        color: Color(0xff0DB166),
                                        fontFamily: 'Open Sans',
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14),
                                  )
                                ],
                              ),
                            ), () {

                          logic.saveAttendance();
                        }),
                      );
                    }
                  }),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  String getColumnName(int index) {
    switch (index) {
      case 0:
        return 'S.no';
      case 1:
        return 'Student Name';
      case 2:
        return 'Class';
      case 3:
        return 'Section';
      case 4:
        return 'Mark Full Day Present';
      case 5:
        return '';
      case 6:
        return 'Mark Half Day Present';
      case 7:
        return '';
      case 8:
        return 'Other';
      case 9:
        return '';
      default:
        return '';
    }
  }

  Widget customOutlinedButton(
      ButtonStyle buttonStyle, Widget widget, Function() onPressed) {
    return OutlinedButton(
      style: buttonStyle,
      onPressed: onPressed,
      child: widget,
    );
  }

  DataCell datacell(String? text) {
    return DataCell(AppUtil.customText(
      textAlign: TextAlign.center,
      text: text,
      style: const TextStyle(
          color: Color(0xff334155),
          fontFamily: 'Open Sans',
          fontWeight: FontWeight.w400,
          fontSize: 12),
    ));
  }
}

//  _selectStaffWidget
Widget _selectStaffWidget({
  required GetStaffListModel? getStaffListModel,
  required String? title,
  required BuildContext context,
  required Function(String, String) onChanged,
}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey, width: 0.5),
          ),
          child: DropdownButton<String>(
            hint: Text(
              title ?? "",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            style: Theme.of(context).textTheme.bodyMedium,
            value: classController.selectedStaffId.value.isNotEmpty
                ? classController.selectedStaffId.value
                : null, // Ensure correct null safety handling
            onChanged: (newValue) {
              if (newValue != null) {
                var selectedItem = getStaffListModel?.data?.firstWhere(
                  (item) => item.name == newValue,
                );

                String selectedId = selectedItem?.stafId?.toString() ?? "";

                onChanged(newValue, selectedId);
                classController.selectedStaffId.value = newValue;

                debugPrint("Selected dropdown value: $newValue");
              }
            },
            isExpanded: true,
            underline: const SizedBox(),
            items: getStaffListModel?.data
                    ?.where((item) => item.name != null) // Avoid null names
                    .map<DropdownMenuItem<String>>((item) {
                  return DropdownMenuItem<String>(
                    value: item.name!,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(item.name!),
                    ),
                  );
                }).toList() ??
                [],
          ),
        ),
      ],
    ),
  );
}

// _selectClass
Widget _selectClass({
  required GetClassListModel? getClassListModel,
  required String? title,
  required BuildContext context,
  required Function(String, String) onChanged,
}) {
  // Filter the list to include only items where isClassTeacher == true
  final filteredList = getClassListModel?.data
          ?.where((item) => item.isClassTeacher == true)
          .toList() ??
      [];

  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey, width: 0.5),
          ),
          child: DropdownButton<String>(
            hint: Text(
              title ?? "",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            style: Theme.of(context).textTheme.bodyMedium,
            value: filteredList.any((item) =>
                    item.dataListItemName ==
                    classController.selectedClass.value)
                ? classController.selectedClass.value
                : null, // Ensures proper selection handling
            onChanged: (newValue) {
              if (newValue != null) {
                var selectedItem = filteredList.firstWhere(
                  (item) => item.dataListItemName == newValue,
                );

                String selectedId =
                    selectedItem?.dataListItemId?.toString() ?? "";

                onChanged(newValue, selectedId);
                classController.selectedClass.value = newValue;

                debugPrint("Selected dropdown value: $newValue");
              }
            },
            isExpanded: true,
            underline: const SizedBox(),
            items: filteredList.map<DropdownMenuItem<String>>((item) {
              return DropdownMenuItem<String>(
                value: item.dataListItemName!,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(item.dataListItemName!),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    ),
  );
}

// Widget _selectClass({
//   required GetClassListModel? getClassListModel,
//   required String? title,
//   required BuildContext context,
//   required Function(String, String) onChanged,
// }) {
//   return Padding(
//     padding: const EdgeInsets.symmetric(vertical: 4),
//     child: Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Container(
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(12),
//             border: Border.all(color: Colors.grey, width: 0.5),
//           ),
//           child: DropdownButton<String>(
//             hint: Text(
//               title ?? "",
//               style: Theme.of(context).textTheme.bodyMedium,
//             ),
//             style: Theme.of(context).textTheme.bodyMedium,
//             value: classController.selectedClass.value.isNotEmpty
//                 ? classController.selectedClass.value
//                 : null, // Ensures proper null handling
//             onChanged: (newValue) {
//               if (newValue != null) {
//                 var selectedItem = getClassListModel?.data?.firstWhere(
//                       (item) => item.dataListItemName == newValue,
//                 );
//
//                 String selectedId = selectedItem?.dataListItemId?.toString() ?? "";
//
//                 onChanged(newValue, selectedId);
//                 classController.selectedClass.value = newValue;
//
//                 debugPrint("Selected dropdown value: $newValue");
//               }
//             },
//             isExpanded: true,
//             underline: const SizedBox(),
//             items: getClassListModel?.data
//                 ?.where((item) => item.dataListItemName != null) // Avoid null names
//                 .map<DropdownMenuItem<String>>((item) {
//               return DropdownMenuItem<String>(
//                 value: item.dataListItemName!,
//                 child: Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Text(item.dataListItemName!),
//                 ),
//               );
//             }).toList() ??
//                 [],
//           ),
//         ),
//       ],
//     ),
//   );
// }

//_selectSection
Widget _selectSection({
  required GetSectionListModel? getSectionListModel,
  required String? title,
  required Function(String, String) onChanged,
  required BuildContext context,
}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey, width: 0.5),
          ),
          child: DropdownButton<String>(
            hint: Text(
              title ?? "",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            style: Theme.of(context).textTheme.bodyMedium,
            value: classController.selectedSection.value.isNotEmpty
                ? classController.selectedSection.value
                : null, // Ensures proper null handling
            onChanged: (newValue) {
              if (newValue != null) {
                var selectedItem = getSectionListModel?.data?.firstWhere(
                  (item) => item.dataListItemName == newValue,
                );

                String selectedId =
                    selectedItem?.dataListItemId?.toString() ?? "";

                onChanged(newValue, selectedId);
                classController.selectedSection.value = newValue;

                debugPrint("Selected section: $newValue");
              }
            },
            isExpanded: true,
            underline: const SizedBox(),
            items: getSectionListModel?.data
                    ?.where((item) =>
                        item.dataListItemName != null) // Avoid null names
                    .map<DropdownMenuItem<String>>((item) {
                  return DropdownMenuItem<String>(
                    value: item.dataListItemName!,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(item.dataListItemName!),
                    ),
                  );
                }).toList() ??
                [],
          ),
        ),
      ],
    ),
  );
}

//

//  Controller
class ClassController extends GetxController
    with StateMixin<CheckTowModelData> {
  final prefs = GetStorage();
  RxString selectedSection = "".obs;
  RxString selectedClass = "".obs;
  RxString selectedStaffId = "".obs;

  RxString selectedSectionID = "".obs;
  RxString selectedClassID = "".obs;

  // save to next api variables
  RxString classIdForAPi = "".obs;
  RxString sectionIdForAPi = "".obs;
  RxString classNameIdForAPi = "".obs;
  RxString sectionNameIdForAPi = "".obs;
  RxString studentNameIdForAPi = "".obs;
  RxString createdDateIdForAPi = "".obs;
  RxString dayIdForAPi = "".obs;

  // {
  // "attendanceId": 0,
  // "classId": classIdForAPi ?? 207,
  // "sectionId":sectionIdForAPi ??  24,
  // "className": classNameIdForAPi ?? "Class-Nursery",
  // "sectionName": sectionNameIdForAPi ??  "GREEN",
  // "markFullDayAbsent": "true",
  // "markHalfDayAbsent": "false",
  // "studentRegisterId": 2426,
  // "studentName": studentNameIdForAPi ??  "VINAYAK MANDOR",
  // "createdDate": createdDateIdForAPi ??  "03/02/2025",
  // "day":dayIdForAPi ??  "Monday",
  // "createdBy": "admin",
  // "others": "False"
  // }

  Future<void> fetchGetStaffList() async {
    dynamic response;
    final accessToken = await prefs.read("accessToken");

    final url =
        Uri.parse("https://stmarysapi.lumensof.in/api/Exam/GetStaffList");
    try {
      change(state, status: RxStatus.loading());

      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $accessToken',
          'Content-Type': 'application/json',
        },
      );
      debugPrint("hitting url $url ");
      debugPrint("Access Token $accessToken");
      debugPrint("response  ${response.body}");

      if (response.statusCode == 200) {
        var res = json.decode(response.body);
        final model3 = GetStaffListModel.fromJson(res);

        final checkTowModel = CheckTowModelData(
            model1: state?.model1, model2: state?.model2, model3: model3);
        change(checkTowModel, status: RxStatus.success());
      } else {
        change(null, status: RxStatus.error());
        debugPrint('Failed to load data. Status Code: ${response.statusCode}');
      }
    } catch (error) {
      change(null, status: RxStatus.error());
      debugPrint('ClassController Error: Failed to load data : $error');
    }
  }

  Future<void> fetchClassData(staffId) async {
    dynamic response;
    final accessToken = await prefs.read("accessToken");

    final url =
        "https://stmarysapi.lumensof.in/api/Exam/GetClassList?staff_Id=$staffId";
    try {
      change(state, status: RxStatus.loading());

      response = await http.post(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer $accessToken',
          'Content-Type': 'application/json'
        },
        body: json.encode({}),
      );
      debugPrint("hitting url $url ");
      debugPrint("Access Token $accessToken");
      debugPrint("response  ${response.body}");

      if (response.statusCode == 200) {
        var res = json.decode(response.body);
        final model1 = GetClassListModel.fromJson(res);

        final checkTowModel = CheckTowModelData(
            model1: model1, model2: state?.model2, model3: state?.model3);

        change(checkTowModel, status: RxStatus.success());
      } else {
        change(null, status: RxStatus.error());
        debugPrint('Failed to load data. Status Code: ${response.statusCode}');
      }
    } catch (error) {
      change(null, status: RxStatus.error());
      debugPrint('ClassController Error: Failed to load data : $error');
    }
  }

  Future<void> fetchSectionData(String classId, String staffId) async {
    try {
      final accessToken = await prefs.read("accessToken");

      if (accessToken == null || accessToken.isEmpty) {
        debugPrint("Error: Access token is null or empty");
        change(null, status: RxStatus.error());
        return;
      }

      // Debugging logs
      debugPrint(
          "Fetching Section Data: classId = $classId, staffId = $staffId");

      change(state, status: RxStatus.loading());

      final uri = Uri.parse(
        "https://stmarysapi.lumensof.in/api/Exam/GetSectionList?staffId=$staffId&classId=$classId",
      );

      final response = await http.get(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessToken', // Added Authorization header
        },
      );

      debugPrint("Request URL: ${response.request?.url}");
      debugPrint("Response Status: ${response.statusCode}");
      debugPrint("Response Body: ${response.body}");

      if (response.statusCode == 200) {
        final Map<String, dynamic> res = json.decode(response.body);

        if (res.isEmpty || res["data"] == null) {
          debugPrint("Warning: API returned an empty response");
          change(null, status: RxStatus.empty());
          return;
        }

        final model2 = GetSectionListModel.fromJson(res);

        final checkTowModel = CheckTowModelData(
          model1: state?.model1,
          model2: model2,
          model3: state?.model3,
        );

        change(checkTowModel, status: RxStatus.success());
      } else {
        debugPrint('Failed to load data. Status Code: ${response.statusCode}');
        debugPrint('Response Body: ${response.body}');
        change(null, status: RxStatus.error());
      }
    } catch (error) {
      debugPrint('ClassController Error: Failed to load data: $error');
      change(null, status: RxStatus.error());
    }
  }
}

class CheckTowModelData {
  final GetClassListModel? model1;
  final GetSectionListModel? model2;
  final GetStaffListModel? model3;

  CheckTowModelData({
    this.model1,
    this.model2,
    this.model3,
  });
}
