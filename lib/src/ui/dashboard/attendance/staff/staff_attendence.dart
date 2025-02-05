import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:iroots/src/controller/attendance/staff/staff_attendance_controller.dart';
import 'package:iroots/src/ui/dashboard/attendance/staff/get_class_list_model.dart';
import 'package:iroots/src/ui/dashboard/attendance/staff/get_section_list_model.dart';
import 'package:iroots/src/ui/dashboard/attendance/staff/get_staff_list_model.dart';
import 'package:iroots/src/ui/dashboard/attendance/staff/get_student_table_show_modal.dart';
import 'package:iroots/src/ui/dashboard/attendance/staff/update_staff_attendence.dart';
import 'package:iroots/src/ui/dashboard/attendance/staff/view_attendence.dart';
import 'package:iroots/src/utility/const.dart';
import 'package:iroots/src/utility/constant/asset_path.dart';
import 'package:iroots/src/utility/util.dart';
import 'package:lottie/lottie.dart';

final _classController = Get.put(ClassController());
final _attendanceController = Get.put(AttendanceController());

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
    await _classController.fetchGetStaffList();
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
    classController.createdDateIdForAPi.value = "";
    _attendanceController.change(GetStudentTableShowModal(tableData: []),
        status: RxStatus.success());
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: StaffAttendanceController(),
      builder: (logic) => Scaffold(
        backgroundColor: const Color(0xffF1F5F9),
        appBar: AppBar(
          backgroundColor: const Color(0xffF1F5F9),
          elevation: 0,
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
                  _classController.obx(
                    (state) {
                      return _selectStaffWidget(
                        title: "Select Staff",
                        onChanged: (selectedStaff, staffID) async {
                          setState(() {
                            _selectedStaff = selectedStaff;
                            _selectedStaffID = staffID;
                          });

                          await _classController.fetchClassData(staffID);
                          _classController.studentNameIdForAPi.value = selectedStaff;

                          debugPrint("selectedClass $selectedStaff || selectedClassID $staffID");
                        },
                        getStaffListModel: state?.model3 ?? GetStaffListModel(),
                        context: context,
                      );
                    },
                  ),

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
                          await _classController.fetchSectionData(
                            selectedClassID,
                            _selectedStaffID.toString(),
                          );
                          _classController.classIdForAPi.value = selectedClassID;
                          _classController.classNameIdForAPi.value = selectedClass;
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
                          _classController.sectionIdForAPi.value = selectedSectionID;
                          _classController.sectionNameIdForAPi.value = selectedSection;

                          debugPrint(
                              "selectedClass $_selectedSection || selectedClassID $selectedSectionID");
                        },
                        getSectionListModel: state?.model2 ?? GetSectionListModel(),
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
                        fontFamily: 'Open Sans', fontWeight: FontWeight.w600, fontSize: 14),
                  ),
                  const SizedBox(height: 10),
                  customOutlinedButton(
                      OutlinedButton.styleFrom(
                        side: const BorderSide(width: 1.0, color: Color(0xff94A3B8)),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
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

                  _attendanceController.obx(
                    (state) {
                      return Column(
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: ConstClass.themeColor,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(34),
                                  ),
                                  padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
                                  fixedSize:
                                      const Size(150, 50), // Set the desired width and height here
                                ),
                                onPressed: () async {
                                  _attendanceController.postAttendanceData();
                                  setState(() {});
                                },
                                child: _attendanceController.isLoading.value ==
                                        true // Assuming `isLoading` is tracked in the controller
                                    ? const CircularProgressIndicator(
                                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                      )
                                    : Text(
                                        "Show",
                                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                              fontWeight: FontWeight.w600,
                                              color: Colors.white,
                                              fontSize: 10,
                                            ),
                                      ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 40),
                          if (state?.tableData?.isEmpty == false)
                            StudentTable(studentsListData: state ?? GetStudentTableShowModal()),
                          const SizedBox(height: 40),
                        ],
                      );
                    },
                    onLoading: const CircularProgressIndicator(),
                    onError: (error) {
                      return Lottie.asset(AssetPath.noDataFound);
                    },
                  ),

                  const SizedBox(height: 10),
                ],
              ),
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: ConstClass.themeColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(34),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
                ),
                onPressed: () {
                  Get.to(() => const UpdateStaffAttendanceScreen());
                },
                child: Text(
                  "Update Students Attendance",
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall
                      ?.copyWith(fontWeight: FontWeight.w600, color: Colors.white, fontSize: 10),
                ),
              ),
              OutlinedButton(
                style: OutlinedButton.styleFrom(
                  side: BorderSide(
                    width: 1.5,
                    color: ConstClass.themeColor,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(34),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
                ),
                onPressed: () {
                  Get.to(() => const ViewAttendanceScreen());
                },
                child: Text(
                  "View Students Attendance",
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      fontWeight: FontWeight.w600, color: const Color(0xff1575FF), fontSize: 10),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Map<String, dynamic>> _getSortData(dynamic data) {
    final List<Map<String, dynamic>> tmp = [];
    int index = 1;

    final List<Map<String, dynamic>> toSortData = data ??
        [
          {
            "studentId": 668,
            "studentName": "AADITYA SHASTRI",
            "attendance": [
              {
                "attendanceId": 673332,
                "classId": 203,
                "sectionId": 24,
                "className": "Class-VII",
                "sectionName": "GREEN",
                "markFullDayAbsent": "True",
                "markHalfDayAbsent": "False",
                "studentRegisterId": 668,
                "studentName": "AADITYA SHASTRI",
                "createdDate": "18/11/2024",
                "day": "Monday",
                "createdBy": "9",
                "others": "False"
              }
            ],
            "attendancePer": "100.00%",
            "totalDays": "1",
            "totalAttendedDays": "1"
          },
          {
            "studentId": 801,
            "studentName": "AARJAV SHARMA",
            "attendance": [
              {
                "attendanceId": 673333,
                "classId": 203,
                "sectionId": 24,
                "className": "Class-VII",
                "sectionName": "GREEN",
                "markFullDayAbsent": "True",
                "markHalfDayAbsent": "False",
                "studentRegisterId": 801,
                "studentName": "AARJAV SHARMA",
                "createdDate": "18/11/2024",
                "day": "Monday",
                "createdBy": "9",
                "others": "False"
              }
            ],
            "attendancePer": "100.00%",
            "totalDays": "1",
            "totalAttendedDays": "1"
          },
          {
            "studentId": 712,
            "studentName": "AEKANSH RAUL",
            "attendance": [
              {
                "attendanceId": 673334,
                "classId": 203,
                "sectionId": 24,
                "className": "Class-VII",
                "sectionName": "GREEN",
                "markFullDayAbsent": "False",
                "markHalfDayAbsent": "False",
                "studentRegisterId": 712,
                "studentName": "AEKANSH RAUL",
                "createdDate": "18/11/2024",
                "day": "Monday",
                "createdBy": "9",
                "others": "False"
              }
            ],
            "attendancePer": "0.00%",
            "totalDays": "1",
            "totalAttendedDays": "0"
          }
        ];

    // Loop through each student record
    for (var student in toSortData) {
      for (var attendance in student["attendance"]) {
        tmp.add({
          "index": index, // Add index
          "Student Name": student["studentName"],
          "Class Name": attendance["className"],
          "Section Name": attendance["sectionName"],
          "markFullDayAbsent": attendance["markFullDayAbsent"],
          "Date": attendance["createdDate"],
          "Day": attendance["day"],
        });

        index++; // Increment index for next record
      }
    }

    print("_getSortData sortedData : $tmp"); // Output sorted data
    return tmp;
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

  Widget customOutlinedButton(ButtonStyle buttonStyle, Widget widget, Function() onPressed) {
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
  final filteredList =
      getClassListModel?.data?.where((item) => item.isClassTeacher == true).toList() ?? [];

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
            value: filteredList
                    .any((item) => item.dataListItemName == _classController.selectedClass.value)
                ? _classController.selectedClass.value
                : null,
            // Ensures proper selection handling
            onChanged: (newValue) {
              if (newValue != null) {
                var selectedItem = filteredList.firstWhere(
                  (item) => item.dataListItemName == newValue,
                );

                String selectedId = selectedItem?.dataListItemId?.toString() ?? "";

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

                String selectedId = selectedItem?.dataListItemId?.toString() ?? "";

                onChanged(newValue, selectedId);
                _classController.selectedSection.value = newValue;

                debugPrint("Selected section: $newValue");
              }
            },
            isExpanded: true,
            underline: const SizedBox(),
            items: getSectionListModel?.data
                    ?.where((item) => item.dataListItemName != null) // Avoid null names
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

//  Controller
class ClassController extends GetxController with StateMixin<CheckTowModelData> {
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

  Future<void> fetchGetStaffList() async {
    dynamic response;
    final accessToken = await prefs.read("accessToken");

    final url = Uri.parse("https://stmarysapi.lumensof.in/api/Exam/GetStaffList");
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

        final checkTowModel =
            CheckTowModelData(model1: state?.model1, model2: state?.model2, model3: model3);
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

    final url = "https://stmarysapi.lumensof.in/api/Exam/GetClassList?staff_Id=$staffId";
    try {
      change(state, status: RxStatus.loading());

      response = await http.post(
        Uri.parse(url),
        headers: {'Authorization': 'Bearer $accessToken', 'Content-Type': 'application/json'},
        body: json.encode({}),
      );
      debugPrint("hitting url $url ");
      debugPrint("Access Token $accessToken");
      debugPrint("response  ${response.body}");

      if (response.statusCode == 200) {
        var res = json.decode(response.body);
        final model1 = GetClassListModel.fromJson(res);

        final checkTowModel =
            CheckTowModelData(model1: model1, model2: state?.model2, model3: state?.model3);

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
      debugPrint("Fetching Section Data: classId = $classId, staffId = $staffId");

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

class AttendanceController extends GetxController with StateMixin<GetStudentTableShowModal> {
  dynamic response = [];
  var isLoading = false.obs;

  final prefs = GetStorage();

  // Corrected function to return sorted data as a list of TableData objects
  List<TableData> getSortData(dynamic data) {
    final List<TableData> sortedRecords = [];
    int index = 1;

    final List<Map<String, dynamic>> toSortData = List<Map<String, dynamic>>.from(data);

    // Loop through each student record
    for (var student in toSortData) {
      for (var attendance in student["attendance"]) {
        sortedRecords.add(TableData(
          index: index,
          // Add index
          studentName: student["studentName"],
          className: attendance["className"],
          sectionName: attendance["sectionName"],
          markFullDayAbsent: attendance["markFullDayAbsent"],
          date: attendance["createdDate"],
          day: attendance["day"],
        ));

        index++; // Increment index for next record
      }
    }

    debugPrint("_getSortData sortedData : $sortedRecords"); // Output sorted data
    return sortedRecords;
  }

  postAttendanceData() async {
    final classId = _classController.classIdForAPi.value;
    final sectionId = _classController.sectionIdForAPi.value;
    final date = classController.createdDateIdForAPi.value;

    DateTime dateTime = DateFormat('dd-MMM-yyyy').parse(date);

    String _day = DateFormat('dd').format(dateTime).toString();
    String _month = DateFormat('MM').format(dateTime).toString();
    String _year = DateFormat('yyyy').format(dateTime).toString();
    final checkDate = "$_day/$_month/$_year";

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

    try {
      isLoading.value = true;

      final res = await http.post(
        Uri.parse('https://stmarysapi.lumensof.in/api/Attendance/ViewStudentAttendance'),
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

        debugPrint('Failed to post attendance data with status code: ${res.statusCode}');
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
