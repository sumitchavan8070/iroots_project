import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:iroots/src/controller/attendance/staff/update_staff_attendance_controller.dart';
import 'package:iroots/src/ui/dashboard/attendance/staff/get_class_list_model.dart';
import 'package:iroots/src/ui/dashboard/attendance/staff/get_section_list_model.dart';
import 'package:iroots/src/ui/dashboard/attendance/staff/get_staff_list_model.dart';
import 'package:iroots/src/ui/dashboard/attendance/staff/get_student_table_show_modal.dart';
import 'package:iroots/src/ui/dashboard/attendance/staff/staff_attendence.dart';
import 'package:iroots/src/utility/const.dart';
import 'package:iroots/src/utility/constant/asset_path.dart';
import 'package:iroots/src/utility/util.dart';
import 'package:http/http.dart' as http;
import 'package:lottie/lottie.dart';

final _classController = Get.put(ClassController());
final _attendanceController = Get.put(AttendanceControllerForUpdate());
final _markAttendanceController = Get.put(MarkAttendanceController());
final _updateStaffAttendanceController =
    Get.put(UpdateStaffAttendanceController());

class UpdateStaffAttendanceScreen extends StatefulWidget {
  const UpdateStaffAttendanceScreen({super.key});

  @override
  State<UpdateStaffAttendanceScreen> createState() =>
      _UpdateStaffAttendanceScreenState();
}

class _UpdateStaffAttendanceScreenState
    extends State<UpdateStaffAttendanceScreen> {
  String? _selectedClass;
  String? _selectedSection;
  String? _selectedStaff;
  String? _selectedStaffID;
  String? _selectedSectionID;
  String? _selectedClassID;

  _loadClassFromApi() async {
    final staffId = _updateStaffAttendanceController
        .staffHomeWorkController.staffDetail.value.staffid;
    await _classController.fetchClassData(staffId);
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
    _classController.selectedClass.value = "";
    _classController.selectedStaffId.value = "";
    _classController.selectedSectionID.value = "";
    _classController.selectedSection.value = "";

    //  for show btn
    _classController.classIdForAPi.value = "";
    _classController.sectionIdForAPi.value = "";
    _classController.createdDateIdForAPi.value = "";
    _attendanceController.change(GetStudentTableShowModal(tableData: []),
        status: RxStatus.success());
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: UpdateStaffAttendanceController(),
      builder: (logic) => Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: ConstClass.dashBoardColor,
          title: AppUtil.customText(
            text: "Update Student Attendance",
            style: const TextStyle(
                fontFamily: 'Open Sans',
                fontWeight: FontWeight.w700,
                fontSize: 16),
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
                  customDropDown(
                    "Select Staff",
                    logic.staffHomeWorkController.staffDetail.value.name,
                  ),
                  // _classController.obx(
                  //   (state) {
                  //     return _selectStaffWidget(
                  //       title: "Select Staff",
                  //       onChanged: (selectedStaff, staffID) async {
                  //         setState(() {
                  //           _selectedStaff = selectedStaff;
                  //           _selectedStaffID = staffID;
                  //         });
                  //
                  //         await _classController.fetchClassData(staffID);
                  //         _classController.studentNameIdForAPi.value =
                  //             selectedStaff;
                  //
                  //         debugPrint(
                  //             "selectedClass $selectedStaff || selectedClassID $staffID");
                  //       },
                  //       getStaffListModel: state?.model3 ?? GetStaffListModel(),
                  //       context: context,
                  //     );
                  //   },
                  // ),

                  const SizedBox(height: 10),
                  _classController.obx(
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
                          final staffId = _updateStaffAttendanceController
                              .staffHomeWorkController
                              .staffDetail
                              .value
                              .staffid;

                          await _classController.fetchSectionData(
                            selectedClassID,
                            staffId.toString(),
                          );
                          _classController.classIdForAPi.value =
                              selectedClassID;
                          _classController.classNameIdForAPi.value =
                              selectedClass;
                        },
                        getClassListModel: state?.model1 ?? GetClassListModel(),
                        context: context,
                      );
                    },
                  ),
                  const SizedBox(height: 10),
                  _classController.obx(
                    (state) {
                      return _selectSection(
                        title: "Select Section",
                        onChanged: (selectedSection, selectedSectionID) {
                          setState(() {
                            _selectedSection = selectedSection;
                            _selectedSectionID = selectedSectionID;
                          });
                          _classController.sectionIdForAPi.value =
                              selectedSectionID;
                          _classController.sectionNameIdForAPi.value =
                              selectedSection;

                          debugPrint(
                              "selectedClass $_selectedSection || selectedClassID $selectedSectionID");
                        },
                        getSectionListModel:
                            state?.model2 ?? GetSectionListModel(),
                        context: context,
                      );
                    },
                  ),

                  // const SizedBox(
                  //   height: 10,
                  // ),
                  // customDropDown("Select Class", ""
                  //
                  //     // logic.staffHomeWorkController.staffClass!.dataListItemName,
                  //     ),
                  // const SizedBox(
                  //   height: 10,
                  // ),
                  // customDropDown("Select Section", ""
                  //     // logic.staffHomeWorkController.staffSection!
                  //     //     .dataListItemName,
                  //     ),
                  const SizedBox(height: 10),
                  AppUtil.customText(
                    text: "Select Date",
                    style: const TextStyle(
                        fontFamily: 'Open Sans',
                        fontWeight: FontWeight.w600,
                        fontSize: 14),
                  ),
                  const SizedBox(
                    height: 5,
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
                  const SizedBox(height: 10),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Obx(
                        () {
                          return ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: ConstClass.themeColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(34),
                              ),
                              padding: const EdgeInsets.symmetric(
                                  vertical: 6, horizontal: 80),
                              // fixedSize: ,
                            ),
                            onPressed: () async {
                              // Get.to(() =>  PaymentPage());
                              // return;
                              _attendanceController.postAttendanceData();
                            },
                            child: _attendanceController.isLoading.value
                                ? const CircularProgressIndicator()
                                : Text(
                                    "Show",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall
                                        ?.copyWith(
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white,
                                          fontSize: 10,
                                        ),
                                  ),
                          );
                        },
                      )
                    ],
                  ),

                  _attendanceController.obx(
                    (state) {
                      return Column(
                        children: [
                          if (state != null) ...[
                            const SizedBox(height: 20),
                            const Center(
                              child: Text("No Attendance Data found "),
                            )
                          ],
                          const SizedBox(height: 40),
                          if (state?.tableData?.isEmpty == false)
                            StudentTable(
                              studentsListData:
                                  state ?? GetStudentTableShowModal(),
                              onTap: () {
                                debugPrint(
                                    "here is the tapped list data $selectedData");
                                setState(() {});
                              },
                            ),
                          const SizedBox(height: 40),
                        ],
                      );
                    },
                    onLoading: Text(""),
                    onError: (error) {
                      return Lottie.asset(AssetPath.noDataFound);
                    },
                  ),
                  const SizedBox(height: 10),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (selectedData.isNotEmpty == true) ...[
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: ConstClass.themeColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(34),
                  ),
                  padding:
                      const EdgeInsets.symmetric(vertical: 6, horizontal: 80),
                  // fixedSize: ,
                ),
                onPressed: () async {

                  _markAttendanceController.sendPostRequest();
                },
                child: _attendanceController.isLoading.value
                    ? const CircularProgressIndicator()
                    : Text(
                        "Mark Attendance",
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                              fontSize: 10,
                            ),
                      ),
              )
            ],
          ],
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

  String getCellData(int rowIndex, int colIndex) {
    switch (colIndex) {
      case 0:
        return (rowIndex + 1).toString();
      case 1:
        return 'Student ${rowIndex + 1}';
      case 2:
        return 'A';
      case 4:
        return 'H';
      case 6:
        return 'Other';
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

  Widget customDropDown(
    String? title,
    String? buttonValue,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppUtil.customText(
          text: title,
          style: const TextStyle(
              fontFamily: 'Open Sans',
              fontWeight: FontWeight.w600,
              fontSize: 14),
        ),
        const SizedBox(
          height: 2,
        ),
        SizedBox(
          width: Get.width,
          child: customOutlinedButton(
              OutlinedButton.styleFrom(
                side: const BorderSide(width: 1, color: Color(0xff94A3B8)),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AppUtil.customText(
                      text: buttonValue,
                      style: const TextStyle(
                          color: Color(0xff0F172A),
                          fontFamily: 'Open Sans',
                          fontWeight: FontWeight.w400,
                          fontSize: 14),
                    ),
                    SvgPicture.asset(
                      "assets/icons/arrowdown_icon.svg",
                      height: 20,
                      width: 20,
                    ),
                  ],
                ),
              ),
              () {}),
        )
      ],
    );
  }

//   smt componants
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
            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey, width: 1),
            ),
            child: DropdownButton<String>(
              hint: Text(
                title ?? "",
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              style: Theme.of(context).textTheme.bodyMedium,
              value: _classController.selectedStaffId.value.isNotEmpty
                  ? _classController.selectedStaffId.value
                  : null,
              // Ensure correct null safety handling
              onChanged: (newValue) {
                if (newValue != null) {
                  var selectedItem = getStaffListModel?.data?.firstWhere(
                    (item) => item.name == newValue,
                  );

                  String selectedId = selectedItem?.stafId?.toString() ?? "";

                  onChanged(newValue, selectedId);
                  _classController.selectedStaffId.value = newValue;

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
            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey, width: 1),
            ),
            child: DropdownButton<String>(
              hint: Text(
                title ?? "",
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              style: Theme.of(context).textTheme.bodyMedium,
              value: filteredList.any((item) =>
                      item.dataListItemName ==
                      _classController.selectedClass.value)
                  ? _classController.selectedClass.value
                  : null,
              // Ensures proper selection handling
              onChanged: (newValue) {
                if (newValue != null) {
                  var selectedItem = filteredList.firstWhere(
                    (item) => item.dataListItemName == newValue,
                  );

                  String selectedId =
                      selectedItem?.dataListItemId?.toString() ?? "";

                  onChanged(newValue, selectedId);
                  _classController.selectedClass.value = newValue;

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
            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey, width: 1),
            ),
            child: DropdownButton<String>(
              hint: Text(
                title ?? "",
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              style: Theme.of(context).textTheme.bodyMedium,
              value: _classController.selectedSection.value.isNotEmpty
                  ? _classController.selectedSection.value
                  : null,
              // Ensures proper null handling
              onChanged: (newValue) {
                if (newValue != null) {
                  var selectedItem = getSectionListModel?.data?.firstWhere(
                    (item) => item.dataListItemName == newValue,
                  );

                  String selectedId =
                      selectedItem?.dataListItemId?.toString() ?? "";

                  onChanged(newValue, selectedId);
                  _classController.selectedSection.value = newValue;

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
}

List<Map<String, dynamic>> selectedData = [];

class StudentTable extends StatefulWidget {
  final GetStudentTableShowModal studentsListData;
  final Function() onTap;

  const StudentTable(
      {super.key, required this.studentsListData, required this.onTap});

  @override
  _StudentTableState createState() => _StudentTableState();
}

class _StudentTableState extends State<StudentTable> {
  Map<int, bool> _fullDayPresent = {};
  Map<int, bool> _halfDayPresent = {};

  void _toggleFullDay(int index, bool? value) {
    setState(() {
      _fullDayPresent[index] = value ?? false;
      if (value == true) {
        _halfDayPresent[index] = false;
      }
      _updateSelectedData(index);
      widget.onTap();
    });
  }

  void _toggleHalfDay(int index, bool? value) {
    setState(() {
      _halfDayPresent[index] = value ?? false;
      if (value == true) {
        _fullDayPresent[index] = false;
      }
      _updateSelectedData(index);
      widget.onTap();
    });
  }

  // void _updateSelectedData(int index) {
  //   final item = widget.studentsListData.tableData?[index];
  //   if (item != null) {
  //     debugPrint(" _fullDayPresent[index ${_fullDayPresent[index]} ||  _halfDayPresent[index] ${_halfDayPresent[index]}");
  //     return;
  //     // if (_fullDayPresent[index] == true || _halfDayPresent[index] == true){
  //     //   // selectedData.removeWhere((element) => element['studentRegisterId'] == item.studentRegisterId);
  //     //
  //     // }
  //     if (_fullDayPresent[index] == true || _halfDayPresent[index] == true) {
  //       selectedData.add({
  //         "attendanceId": item.attendanceId,
  //         "classId": item.classId,
  //         "sectionId": item.sectionId,
  //         "className": item.className,
  //         "sectionName": item.sectionName,
  //         "markFullDayAbsent": _fullDayPresent[index] == true ? "false" : "true",
  //         "markHalfDayAbsent": _halfDayPresent[index] == true ? "false" : "true",
  //         "studentRegisterId": item.studentRegisterId,
  //         "studentName": item.studentName,
  //         "createdDate": item.createdDate,
  //         "day": item.day,
  //         "createdBy": item.createdBy,
  //         "others": item.others,
  //       });
  //     }
  //     print("Selected Data: $selectedData");
  //   }
  // }
  void _updateSelectedData(int index) {
    final item = widget.studentsListData.tableData?[index];
    if (item != null) {
      debugPrint(
          "_fullDayPresent[index ${_fullDayPresent[index]} || _halfDayPresent[index] ${_halfDayPresent[index]}");

      // Remove the item from selectedData if both are false
      if (_fullDayPresent[index] == false && _halfDayPresent[index] == false) {
        // Remove the entry based on the index
        selectedData.removeWhere((element) =>
            element['studentRegisterId'] == item.studentRegisterId &&
            element['index'] == index);
      }

      // If either value is true, update or add to selectedData
      if (_fullDayPresent[index] == true || _halfDayPresent[index] == true) {
        // Check if the entry already exists at this index and update it
        final existingItemIndex = selectedData.indexWhere((element) =>
            element['studentRegisterId'] == item.studentRegisterId &&
            element['index'] == index);

        if (existingItemIndex >= 0) {
          // If the item exists, update it at the same index
          selectedData[existingItemIndex] = {
            "attendanceId": item.attendanceId,
            "classId": item.classId,
            "sectionId": item.sectionId,
            "className": item.className,
            "sectionName": item.sectionName,
            "markFullDayAbsent":
                _fullDayPresent[index] == true ? "false" : "true",
            "markHalfDayAbsent":
                _halfDayPresent[index] == true ? "false" : "true",
            "studentRegisterId": item.studentRegisterId,
            "studentName": item.studentName,
            "createdDate": item.createdDate,
            "day": item.day,
            "createdBy": item.createdBy,
            "others": item.others,
            "index": index, // Adding index to the map
          };
        } else {
          // If the item doesn't exist at this index, add a new entry
          selectedData.add({
            "attendanceId": item.attendanceId,
            "classId": item.classId,
            "sectionId": item.sectionId,
            "className": item.className,
            "sectionName": item.sectionName,
            "markFullDayAbsent":
                _fullDayPresent[index] == true ? "false" : "true",
            "markHalfDayAbsent":
                _halfDayPresent[index] == true ? "false" : "true",
            "studentRegisterId": item.studentRegisterId,
            "studentName": item.studentName,
            "createdDate": item.createdDate,
            "day": item.day,
            "createdBy": item.createdBy,
            "others": item.others,
            "index": index, // Adding index to the map
          });
        }
      }

      print("Selected Data: $selectedData");
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        dataTextStyle: Theme.of(context).textTheme.bodySmall,
        dataRowMaxHeight: 70,
        columnSpacing: 20,
        headingRowHeight: 45,
        border: TableBorder.all(color: const Color(0xFFE2E8F0)),
        headingRowColor: WidgetStateProperty.all(const Color(0xFFD0E3FF)),
        showBottomBorder: false,
        headingTextStyle: Theme.of(context)
            .textTheme
            .bodyMedium
            ?.copyWith(fontWeight: FontWeight.w600),
        columns: List.generate(
            9, (index) => DataColumn(label: Text(getColumnName(index)))),
        rows: List.generate(widget.studentsListData.tableData?.length ?? 0,
            (index) {
          final item = widget.studentsListData.tableData?[index];

          return DataRow(
            cells: [
              DataCell(Text((index + 1).toString())),
              DataCell(Text(item?.studentName ?? '')),
              DataCell(Text(item?.className ?? '')),
              DataCell(Text(item?.sectionName ?? '')),
              DataCell(Text(item?.day.toString() ?? 'Day')),
              DataCell(Text("P")),
              DataCell(
                Checkbox(
                  value: _fullDayPresent[index] ?? false,
                  onChanged: (value) => _toggleFullDay(index, value),
                  shape: const CircleBorder(),
                  activeColor: Colors.blue,
                ),
              ),
              DataCell(Text("A")),
              DataCell(
                Checkbox(
                  value: _halfDayPresent[index] ?? false,
                  onChanged: (value) => _toggleHalfDay(index, value),
                  shape: const CircleBorder(),
                  activeColor: Colors.blue,
                ),
              ),
            ],
          );
        }),
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
        return 'Day';
      case 5:
        return 'Mark Full Day Present';
      case 6:
        return '';
      case 7:
        return 'Mark Half Day Present';
      case 8:
        return '';
      default:
        return '';
    }
  }
}

class AttendanceControllerForUpdate extends GetxController
    with StateMixin<GetStudentTableShowModal> {
  dynamic response = [];
  var isLoading = false.obs;

  final prefs = GetStorage();

  // Corrected function to return sorted data as a list of TableData objects
  List<TableData> getSortData(dynamic data) {
    final List<TableData> sortedRecords = [];
    int index = 1;

    final List<Map<String, dynamic>> toSortData =
        List<Map<String, dynamic>>.from(data);

    // Loop through each student record
    for (var student in toSortData) {
      for (var attendance in student["attendance"]) {
        sortedRecords.add(
          TableData(
            // index: index,
            studentName: student["studentName"],
            className: attendance["className"],
            sectionName: attendance["sectionName"],
            markFullDayAbsent: attendance["markFullDayAbsent"],
            createdDate: attendance["createdDate"],
            day: attendance["day"],
            sectionId: attendance["sectionId"],
            studentRegisterId: attendance["studentId"],
            attendanceId: attendance["attendanceId"],
            classId: attendance["classId"],
            createdBy: attendance["createdBy"],
            others: attendance["others"],
          ),
        );

        index++; // Increment index for next record
      }
    }

    debugPrint(
        "_getSortData sortedData : $sortedRecords"); // Output sorted data
    return sortedRecords;
  }

  postAttendanceData() async {
    final classId = _classController.classIdForAPi.value;
    final sectionId = _classController.sectionIdForAPi.value;
    final date = _classController.createdDateIdForAPi.value;
    debugPrint("date $date");
    // Parse the date string to DateTime object
    DateTime dateTime = DateFormat('dd-MMM-yyyy').parse(date);

    // Extract the day, month, and year
    String _day = DateFormat('dd').format(dateTime).toString();
    String _month = DateFormat('MM').format(dateTime).toString();
    String _year = DateFormat('yyyy').format(dateTime).toString();

    // Create a new formatted date string
    final checkDate = "$_day/$_month/$_year";

    // print(checkDate);  // Output will be 06/02/2025

    // return ;

    if (classId == "") return;
    if (sectionId == "") return;
    if (checkDate == "") return;

    final accessToken = await prefs.read("accessToken");

    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $accessToken', // Added Authorization header
    };

    final body = jsonEncode({
      "classId": classId,
      "sectionId": sectionId,
      "fromDate": "$_day/$_month/$_year",
      "toDate": "$_day/$_month/$_year",
      "studentId": 0
    });

    // final body = jsonEncode({
    //   "classId": 203,
    //   "sectionId": 24,
    //   "fromDate": "18/11/2024",
    //   "toDate": "18/11/2024",
    //   "studentId": 0
    // });

    try {
      isLoading.value = true;

      final res = await http.post(
        Uri.parse(
            'https://stmarysapi.lumensof.in/api/Attendance/ViewStudentAttendance'),
        headers: headers,
        body: body,
      );

      debugPrint("Request URL: ${res.request?.url}");
      debugPrint("Request Body: $body");
      debugPrint("response : ${res.body}");

      if (res.statusCode == 200) {
        final Map<String, dynamic> resBody = jsonDecode(res.body);

        // Access the 'data' part of the response
        final sortedData = getSortData(resBody['data']);

        // Optionally, store or use sortedData here, or update the response
        response = sortedData;
        debugPrint("Sorted Data: $sortedData");

        // Update state with the sorted data
        final modal = GetStudentTableShowModal(tableData: sortedData);
        change(modal, status: RxStatus.success());
      } else {
        isLoading.value = false;

        debugPrint(
            'Failed to post attendance data with status code: ${res.statusCode}');
      }
    } catch (e) {
      isLoading.value = false;

      debugPrint('An error occurred: $e');
      change(null, status: RxStatus.error('An error occurred'));
    }
    isLoading.value = false;

    // You can also return the response or sorted data if needed
    debugPrint('Response: $response');
  }
}



class MarkAttendanceController extends GetxController {
  // Observables to track loading state and response data
  var isLoading = false.obs;
  var responseMessage = ''.obs;

  // Function to send the POST request
  Future<void> sendPostRequest() async {
    final String url = 'https://stmarysapi.lumensof.in/api/Attendance/EditStudentAttendance';

    // final Map<String, dynamic> requestBody = {
    //   "attendanceId": 0,
    //   "classId": 0,
    //   "sectionId": 0,
    //   "className": "string",
    //   "sectionName": "string",
    //   "markFullDayAbsent": "string",
    //   "markHalfDayAbsent": "string",
    //   "studentRegisterId": 0,
    //   "studentName": "string",
    //   "createdDate": "string",
    //   "day": "string",
    //   "createdBy": "string",
    //   "others": "string"
    // };

    try {
      // Set loading to true
      isLoading.value = true;

      final response = await http.post(
        Uri.parse(url),
        headers: {
          'accept': 'text/plain',
          'Content-Type': 'application/json',
        },
        body: jsonEncode(selectedData),
      );

      // Set loading to false
      isLoading.value = false;

      if (response.statusCode == 200) {
        responseMessage.value = "Request was successful: ${response.body}";
      } else {
        responseMessage.value = "Request failed with status: ${response.statusCode}";
      }
    } catch (e) {
      isLoading.value = false;
      responseMessage.value = "Error occurred: $e";
    }
  }
}
