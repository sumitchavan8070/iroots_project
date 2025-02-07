import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:iroots/src/controller/attendance/staff/view_attendance_controller.dart';
import 'package:iroots/src/modal/attendance/staffModalClass.dart';
import 'package:iroots/src/modal/attendance/studentAttendanceModalClass.dart';
import 'package:iroots/src/ui/dashboard/attendance/staff/get_class_list_model.dart';
import 'package:iroots/src/ui/dashboard/attendance/staff/get_section_list_model.dart';
import 'package:iroots/src/ui/dashboard/attendance/staff/get_student_table_show_modal.dart';
import 'package:iroots/src/ui/dashboard/attendance/staff/staff_attendence.dart';
import 'package:iroots/src/utility/const.dart';
import 'package:iroots/src/utility/util.dart';

final _classController = Get.put(ClassController());
final _attendanceController = Get.put(AttendanceController());

final _viewAttendanceController = Get.put(ViewAttendanceController());

class ViewAttendanceScreen extends StatefulWidget {
  final String staffId;
  const ViewAttendanceScreen({super.key, required this.staffId});

  @override
  State<ViewAttendanceScreen> createState() => _ViewAttendanceScreenState();
}

class _ViewAttendanceScreenState extends State<ViewAttendanceScreen> {
  String? _selectedClass;
  String? _selectedSection;
  String? _selectedStaff;
  String? _selectedStaffID;
  String? _selectedSectionID;
  String? _selectedClassID;
  final prefs = GetStorage();

  _loadClassFromApi() async {
    final staffId = widget.staffId;
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
      init: ViewAttendanceController(),
      builder: (logic) => Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: ConstClass.dashBoardColor,
          title: AppUtil.customText(
            text: "View Student Attendance",
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
                          final staffId = widget.staffId;

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
                  // customDropDown1(
                  //     "Select Class",
                  //     logic.staffHomeWorkController.staffDetail.value.!
                  //         .dataListItemName,
                  //     ""),
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

                  // customDropDown1("Select Section", ""
                  //
                  //     // logic
                  //     //     .staffHomeWorkController.staffSection!.dataListItemName,
                  //     ),
                  const SizedBox(
                    height: 10,
                  ),
                  // customDropDown(
                  //   logic,
                  //   "Select Student",
                  //   "Please Select Student",
                  //   logic.studentDataList,
                  //   (newValue) {
                  //     logic.selectedStudent = newValue;
                  //   },
                  //   logic.selectedStudent,
                  // ),
                  const SizedBox(height: 10),

                  AppUtil.customText(
                    text: "From Date",
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
                              text: logic.selectedAssignmentDate,
                              style: const TextStyle(
                                color: Color(0xff0F172A),
                                fontFamily: 'Open Sans',
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                              ),
                            ),
                            SvgPicture.asset(
                              "assets/icons/calendar_icon.svg",
                              height: 20,
                              width: 20,
                            )
                          ],
                        ),
                      ), () {
                    logic.pickDateDialog(context, 0);
                  }),
                  const SizedBox(height: 10),
                  AppUtil.customText(
                    text: "To Date",
                    style: const TextStyle(
                      fontFamily: 'Open Sans',
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
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
                              text: logic.selectedSubmissionDate,
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
                    logic.pickDateDialog(context, 1);
                  }),
                  const SizedBox(
                    height: 10,
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
                    height: 15,
                  ),
                  attandanceStatus(),
                  const SizedBox(
                    height: 5,
                  ),
                  RichText(
                    text: TextSpan(
                        text: "Total No Of Students : ",
                        style: const TextStyle(
                            color: Color(0xff0F172A),
                            fontFamily: 'Open Sans',
                            fontWeight: FontWeight.w400,
                            fontSize: 14),
                        children: [
                          TextSpan(
                              text: logic.studentListData.isNotEmpty
                                  ? "${logic.studentListData.length}"
                                  : "0",
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'Open Sans',
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14))
                        ]),
                    textAlign: TextAlign.start,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  RichText(
                    text: TextSpan(
                        text: "No of Present day : ",
                        style: const TextStyle(
                            color: Color(0xff0F172A),
                            fontFamily: 'Open Sans',
                            fontWeight: FontWeight.w400,
                            fontSize: 14),
                        children: [
                          TextSpan(
                              text: logic.studentListData.length == 1
                                  ? logic.isAttandanceDataFound.value
                                      ? logic.studentData!.totalAttendedDays
                                      : ""
                                  : "",
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'Open Sans',
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14))
                        ]),
                    textAlign: TextAlign.start,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Obx(() {
                    if (logic.isFirstTime.value) {
                      return const SizedBox();
                    } else if (logic.isAttandanceDataFound.value) {
                      return logic.studentListData.length == 1
                          ? ConstrainedBox(
                              constraints: const BoxConstraints(maxHeight: 255),
                              child: Scrollbar(
                                thickness: 8,
                                radius: const Radius.circular(8),
                                interactive: true,
                                controller: logic.horizontalScrollController,
                                thumbVisibility: true,
                                child: SingleChildScrollView(
                                  controller: logic.horizontalScrollController,
                                  scrollDirection: Axis.horizontal,
                                  child: Scrollable(
                                    viewportBuilder: (BuildContext context,
                                        ViewportOffset position) {
                                      return DataTable(
                                        border: TableBorder.all(),
                                        columns: [
                                          DataColumn(
                                              label: AppUtil.customText(
                                            textAlign: TextAlign.center,
                                            text: "S. no.",
                                            style: const TextStyle(
                                                color: Color(0xff0F172A),
                                                fontFamily: 'Open Sans',
                                                fontWeight: FontWeight.w600,
                                                fontSize: 12),
                                          )),
                                          DataColumn(
                                              label: AppUtil.customText(
                                            textAlign: TextAlign.center,
                                            text: "Student Name",
                                            style: const TextStyle(
                                                color: Color(0xff0F172A),
                                                fontFamily: 'Open Sans',
                                                fontWeight: FontWeight.w600,
                                                fontSize: 12),
                                          )),
                                          DataColumn(
                                              label: AppUtil.customText(
                                            textAlign: TextAlign.center,
                                            text: "Class",
                                            style: const TextStyle(
                                                color: Color(0xff0F172A),
                                                fontFamily: 'Open Sans',
                                                fontWeight: FontWeight.w600,
                                                fontSize: 12),
                                          )),
                                          DataColumn(
                                              label: AppUtil.customText(
                                            textAlign: TextAlign.center,
                                            text: "Section",
                                            style: const TextStyle(
                                                color: Color(0xff0F172A),
                                                fontFamily: 'Open Sans',
                                                fontWeight: FontWeight.w600,
                                                fontSize: 12),
                                          )),
                                          for (var date
                                              in logic.allBetweenDates)
                                            DataColumn(
                                              label: AppUtil.customText(
                                                textAlign: TextAlign.center,
                                                // text: date,
                                                text: date
                                                    .split("/")
                                                    .first
                                                    .trim(),
                                                style: const TextStyle(
                                                    color: Color(0xff0F172A),
                                                    fontFamily: 'Open Sans',
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 12),
                                              ),
                                            ),
                                          DataColumn(
                                              label: AppUtil.customText(
                                            textAlign: TextAlign.center,
                                            text: "Attendance %",
                                            style: const TextStyle(
                                                color: Color(0xff0F172A),
                                                fontFamily: 'Open Sans',
                                                fontWeight: FontWeight.w600,
                                                fontSize: 12),
                                          )),
                                        ],
                                        rows: [
                                          DataRow(
                                            cells: [
                                              datacell("${1}"),
                                              datacell(logic
                                                  .attendance[0]!.studentName),
                                              datacell(logic
                                                  .attendance[0]!.className),
                                              datacell(logic
                                                  .attendance[0]!.sectionName),
                                              for (var date
                                                  in logic.allBetweenDates)
                                                buildDateComparisonWidget(
                                                    date, logic),
                                              datacell(logic
                                                  .studentData!.attendancePer),
                                            ],
                                          ),
                                        ],
                                      );
                                    },
                                  ),
                                ),
                              ),
                            )
                          : ConstrainedBox(
                              constraints: const BoxConstraints(maxHeight: 255),
                              child: Scrollbar(
                                thickness: 8,
                                radius: const Radius.circular(8),
                                interactive: true,
                                controller: logic.verticalScrollController,
                                thumbVisibility: true,
                                child: SingleChildScrollView(
                                  controller: logic.verticalScrollController,
                                  scrollDirection: Axis.vertical,
                                  child: Scrollbar(
                                    thickness: 8,
                                    radius: const Radius.circular(8),
                                    interactive: true,
                                    controller:
                                        logic.horizontalScrollController,
                                    thumbVisibility: true,
                                    child: SingleChildScrollView(
                                      controller:
                                          logic.horizontalScrollController,
                                      scrollDirection: Axis.horizontal,
                                      child: Scrollable(
                                        viewportBuilder: (BuildContext context,
                                            ViewportOffset position) {
                                          return DataTable(
                                              border: TableBorder.all(),
                                              columns: [
                                                DataColumn(
                                                    label: AppUtil.customText(
                                                  textAlign: TextAlign.center,
                                                  text: "S. no.",
                                                  style: const TextStyle(
                                                      color: Color(0xff0F172A),
                                                      fontFamily: 'Open Sans',
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 12),
                                                )),
                                                DataColumn(
                                                    label: AppUtil.customText(
                                                  textAlign: TextAlign.center,
                                                  text: "Student Name",
                                                  style: const TextStyle(
                                                      color: Color(0xff0F172A),
                                                      fontFamily: 'Open Sans',
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 12),
                                                )),
                                                DataColumn(
                                                    label: AppUtil.customText(
                                                  textAlign: TextAlign.center,
                                                  text: "Class",
                                                  style: const TextStyle(
                                                      color: Color(0xff0F172A),
                                                      fontFamily: 'Open Sans',
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 12),
                                                )),
                                                DataColumn(
                                                    label: AppUtil.customText(
                                                  textAlign: TextAlign.center,
                                                  text: "Section",
                                                  style: const TextStyle(
                                                      color: Color(0xff0F172A),
                                                      fontFamily: 'Open Sans',
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 12),
                                                )),
                                                for (var date
                                                    in logic.allBetweenDates)
                                                  DataColumn(
                                                    label: AppUtil.customText(
                                                      textAlign:
                                                          TextAlign.center,
                                                      // text: date,
                                                      text: date
                                                          .split("/")
                                                          .first
                                                          .trim(),
                                                      style: const TextStyle(
                                                          color:
                                                              Color(0xff0F172A),
                                                          fontFamily:
                                                              'Open Sans',
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          fontSize: 12),
                                                    ),
                                                  ),
                                                DataColumn(
                                                    label: AppUtil.customText(
                                                  textAlign: TextAlign.center,
                                                  text: "Attendance %",
                                                  style: const TextStyle(
                                                      color: Color(0xff0F172A),
                                                      fontFamily: 'Open Sans',
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 12),
                                                )),
                                              ],
                                              rows: [
                                                for (var index = 0;
                                                    index <
                                                        logic.studentListData
                                                            .length;
                                                    index++)
                                                  buildDataRow(index, logic),
                                              ]);
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
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: Container(
          height: logic.isAttandanceDataFound.value ? 110 : 65,
          color: const Color(0xffF1F5F9),
          child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
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
                                horizontal: 0, vertical: 12),
                            child: AppUtil.customText(
                              text: "Mark Attendance",
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Open Sans',
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14),
                            )), () {
                      Get.back();
                    }),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Visibility(
                    visible: false,
                    child: Obx(() {
                      if (logic.isAttandanceDataFound.value) {
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
                                child: AppUtil.customText(
                                  text: "Export to Excel",
                                  style: const TextStyle(
                                      color: Color(0xff0DB166),
                                      fontFamily: 'Open Sans',
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14),
                                ),
                              ), () {
                            logic.exportData();
                          }),
                        );
                      } else {
                        return const SizedBox();
                      }
                    }),
                  )
                ],
              )),
        ),
      ),
    );
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
    ViewAttendanceController logic,
    String? dropDownText,
    String? hintText,
    List<StaffData> staffDataList,
    void Function(StaffData) onChanged,
    StaffData? value,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppUtil.customText(
          text: dropDownText,
          style: const TextStyle(
              fontFamily: 'Open Sans',
              fontWeight: FontWeight.w600,
              fontSize: 14),
        ),
        const SizedBox(
          height: 2,
        ),
        staffDataList.isNotEmpty
            ? DropdownButtonFormField<StaffData>(
                icon: SvgPicture.asset(
                  "assets/icons/arrowdown_icon.svg",
                  height: 20,
                  width: 20,
                ),
                value: value,
                style: const TextStyle(
                    fontFamily: 'Open Sans',
                    fontWeight: FontWeight.w600,
                    fontSize: 14),
                items: staffDataList.map((item) {
                  return DropdownMenuItem<StaffData>(
                      value: item,
                      child: AppUtil.customText(
                        textAlign: TextAlign.center,
                        text: item.staffName,
                        style: const TextStyle(
                            color: Color(0xff0F172A),
                            fontFamily: 'Open Sans',
                            fontWeight: FontWeight.w400,
                            fontSize: 14),
                      ));
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
              )
            : const Center(
                child: CircularProgressIndicator(),
              )
      ],
    );
  }

  Widget customDropDown1(
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

  DataCell buildDateComparisonWidget(
      String date, ViewAttendanceController logic) {
    for (var entry in logic.attendance) {
      if (entry!.createdDate == date) {
        return buildAttendanceIcon(entry.markFullDayAbsent == "True",
            entry.markHalfDayAbsent == " True");
      }
    }
    return const DataCell(SizedBox());
  }

  DataCell allbuildDateComparisonWidget(String date, Datum? logic) {
    for (var entry in logic!.attendance) {
      if (entry!.createdDate == date) {
        return buildAttendanceIcon(entry.markFullDayAbsent == "True",
            entry.markHalfDayAbsent == " True");
      }
    }
    return const DataCell(SizedBox());
  }

  DataCell buildAttendanceIcon(bool markFullDayAbsent, bool markHalfDayAbsent) {
    if (markFullDayAbsent) {
      return DataCell(AppUtil.customText(
        text: "✔",
        style: const TextStyle(
            color: Colors.green,
            fontFamily: 'Open Sans',
            fontWeight: FontWeight.w600,
            fontSize: 16),
      ));
    } else if (markHalfDayAbsent) {
      return DataCell(AppUtil.customText(
        textAlign: TextAlign.center,
        text: "½",
        style: const TextStyle(
            color: Color(0xff0F172A),
            fontFamily: 'Open Sans',
            fontWeight: FontWeight.w400,
            fontSize: 14),
      ));
    } else if (!markFullDayAbsent && !markHalfDayAbsent) {
      return DataCell(AppUtil.customText(
        text: "✖",
        style: const TextStyle(
            color: Colors.red,
            fontFamily: 'Open Sans',
            fontWeight: FontWeight.w600,
            fontSize: 16),
      ));
    } else {
      return const DataCell(SizedBox());
    }
  }

  Widget attandanceStatus() {
    return Column(
      children: [
        Row(
          children: [
            RichText(
              text: const TextSpan(
                  text: "Full Day Present :",
                  style: TextStyle(
                      color: Color(0xff0F172A),
                      fontFamily: 'Open Sans',
                      fontWeight: FontWeight.w400,
                      fontSize: 14),
                  children: [
                    TextSpan(
                        text: ' ✔',
                        style: TextStyle(
                            color: Colors.green,
                            fontFamily: 'Open Sans',
                            fontWeight: FontWeight.w400,
                            fontSize: 14))
                  ]),
              textAlign: TextAlign.start,
            ),
            const SizedBox(
              width: 50,
            ),
            RichText(
              text: const TextSpan(
                  text: "Half Day Present :",
                  style: TextStyle(
                      color: Color(0xff0F172A),
                      fontFamily: 'Open Sans',
                      fontWeight: FontWeight.w400,
                      fontSize: 14),
                  children: [
                    TextSpan(
                        text: ' ½',
                        style: TextStyle(
                            color: Color(0xff0F172A),
                            fontFamily: 'Open Sans',
                            fontWeight: FontWeight.w600,
                            fontSize: 14))
                  ]),
              textAlign: TextAlign.start,
            )
          ],
        ),
        const SizedBox(
          height: 5,
        ),
        Row(
          children: [
            RichText(
              text: const TextSpan(
                  text: "Absent :",
                  style: TextStyle(
                      color: Color(0xff0F172A),
                      fontFamily: 'Open Sans',
                      fontWeight: FontWeight.w400,
                      fontSize: 14),
                  children: [
                    TextSpan(
                        text: ' ✖',
                        style: TextStyle(
                            color: Colors.red,
                            fontFamily: 'Open Sans',
                            fontWeight: FontWeight.w400,
                            fontSize: 14))
                  ]),
              textAlign: TextAlign.start,
            ),
            const SizedBox(
              width: 110,
            ),
            RichText(
              text: const TextSpan(
                  text: "Other :",
                  style: TextStyle(
                      color: Color(0xff0F172A),
                      fontFamily: 'Open Sans',
                      fontWeight: FontWeight.w400,
                      fontSize: 14),
                  children: [
                    TextSpan(
                        text: ' 0',
                        style: TextStyle(
                            color: Color(0xff0F172A),
                            fontFamily: 'Open Sans',
                            fontWeight: FontWeight.w600,
                            fontSize: 14))
                  ]),
              textAlign: TextAlign.start,
            ),
          ],
        )
      ],
    );
  }

  DataRow buildDataRow(int index, ViewAttendanceController logic) {
    var student = logic.studentListData[index];
    List<DataCell> cells = [
      datacell("${index + 1}"),
      datacell(student!.attendance[0]!.className!),
      datacell(student.attendance[0]!.studentName),
      datacell(student.attendance[0]!.sectionName),
      for (var date in logic.allBetweenDates)
        allbuildDateComparisonWidget(date, student),
      datacell(student.attendancePer),
    ];

    return DataRow(cells: cells);
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
