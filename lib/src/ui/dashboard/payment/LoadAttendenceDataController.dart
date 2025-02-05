import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:iroots/src/ui/dashboard/student/home/model/get_attedence_as_per_month_model.dart';



class LoadAttendenceDataController extends GetxController with StateMixin<GetAttedenceAsPerMonthModel> {
  final prefs = GetStorage();

  RxMap<String, dynamic> yearlyAttendanceSummary = <String, dynamic>{}.obs;

  Future<void> loadAttendece({
    required String startDate,
    required String endDate,
    required String fromYear,
    required String toYear,
  }) async {
    final appNumber = prefs.read("applicationNumber");

    final stdId = prefs.read("studentId");
    final classId = prefs.read("class");
    final sectionId = prefs.read("sectionId");
    final parentEmail = prefs.read("email");
    final accessToken = prefs.read("accessToken");

    // String _buildUrl({
    //   required String startDate,
    //   required String endDate,
    //   required String classId,
    //   required String sectionId,
    //   required String fromYear,
    //   required String toYear,
    //   required String studentId,
    // }) {
    //   // Construct the URL dynamically using the provided parameters
    //   final url =
    //       'https://stmarysapi.lumensof.in/api/Dashboard/StudentsDashBoardAttendanceDetails?'
    //       'startDate=$startDate&'
    //       'endDate=$endDate&'
    //       'classId=$classId&'
    //       'sectionId=$sectionId&'
    //       'fromYear=$fromYear&'
    //       'toYear=$toYear&'
    //       'studentId=$studentId';
    //
    //   return url;
    // }


    try {
      // Set state to loading
      change(null, status: RxStatus.loading());

      // Construct the API URL using the parameters passed to the method
      final apiUrl = "https://stmarysapi.lumensof.in/api/Dashboard/StudentsDashBoardAttendanceDetails?startDate=$startDate&endDate=$endDate&classId=$classId&sectionId=$sectionId&fromYear=$fromYear&toYear=$toYear&studentId=$stdId";
      // final apiUrl = "https://stmarysapi.lumensof.in/api/Dashboard/StudentsDashBoardAttendanceDetails?startDate=$startDate&endDate=$endDate&classId=197&sectionId=23&fromYear=$fromYear&toYear=$toYear&studentId=869";

      debugPrint("|| url $apiUrl");

      // Make the POST request
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          "Content-Type": "application/json",
          'Authorization': 'Bearer $accessToken',
        },
        // If the server expects a body, you should provide it here
        body: jsonEncode({
          // Add any required body parameters here
        }),
      );

      debugPrint("here is the attend response ${response.body}");

      if (response.statusCode == 200) {
        // Parse the response body
        final data = jsonDecode(response.body);
        final attendanceData = GetAttedenceAsPerMonthModel.fromJson(data);


        // Update the state with the fetched data
        change(attendanceData, status: RxStatus.success());
      }
      if (response.statusCode != 200)  {
        change(null, status: RxStatus.error("Failed to load attendance data: ${response.statusCode}"));
      }
    } catch (e) {
      change(null, status: RxStatus.error("Error loading attendance data: $e"));
      print("Error loading attendance data: $e");
    }
  }
}