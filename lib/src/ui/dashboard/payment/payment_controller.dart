import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:iroots/common/app_data.dart';
import 'dart:convert';
import 'package:iroots/src/controller/home/student/fees_details_model.dart';
import 'package:path/path.dart';

class MakePaymentController extends GetxController {
  final prefs = GetStorage();

  Future<void> makePayment({required String amt, required String heading}) async {
    final appNumber = prefs.read("applicationNumber");
    final stdId = prefs.read("studentId");
    final classId = prefs.read("class");
    final parentEmail = prefs.read("email");

    final postData = {
      "studentId": stdId,
      "class": classId,
      "category": "",
      "tcBal": "0",
      "feeHeadings": heading,
      "feeheadingamt": amt,
      "concessionAmt": 0,
      "concession": 0,
      "dueFee": "0",
      "email": parentEmail,
      "paymentGatewayName": "atom"
    };
    debugPrint("postData $postData || url $url");

    try {
      // Sending the POST request
      const  url = "${baseUrlName}Paymet/PreapareInput";  // Make sure baseUrlName is defined elsewhere

      final response = await http.post(
        Uri.parse(url),
        headers: {
          "Content-Type": "application/json",  // Content-Type should be application/json
        },
        body: jsonEncode(postData),  // The body should be a JSON-encoded string
      );

      // Check the status code and handle the response
      if (response.statusCode == 200) {
        // If the server returns a success response
        print("Payment request successful: ${response.body}");
      } else {
        // If the server returns an error
        print("Payment request failed with status: ${response.statusCode}");
        print("Response: ${response.body}");
      }
    } catch (e) {
      // Handle errors (network issues, etc.)
      print("Error making payment: $e");
    }
  }
}




class LoadAttendenceDataController extends GetxController {
  final prefs = GetStorage();

  RxMap<String, dynamic> yearlyAttendanceSummary = <String, dynamic>{}.obs;

  Future<void> loadAttendece({
    required String startDate,
    required String endDate,
    required int classId,
    required int sectionId,
    required int fromYear,
    required int toYear,
    required int studentId,
  }) async {
    final appNumber = prefs.read("applicationNumber");
    final stdId = prefs.read("studentId");
    final classId = prefs.read("class");
    final parentEmail = prefs.read("email");

    final queryParameters = {
      'startDate': startDate,
      'endDate': endDate,
      'classId': classId.toString(),
      'sectionId': sectionId.toString(),
      'fromYear': fromYear.toString(),
      'toYear': toYear.toString(),
      'studentId': studentId.toString(),
    };

    debugPrint("postData $queryParameters || url $url");

    try {
      // Sending the POST request
      const baseUrl = "${baseUrlName}Dashboard/StudentsDashBoardAttendanceDetails";
      final uri = Uri.parse(baseUrl).replace(queryParameters: queryParameters);

      final response = await http.post(
        uri,
        headers: {
          "Content-Type": "application/json",
        },
        body: {},
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);

        // Extract the "yearlyAttendanceSummary" from the response and update the RxMap
        final yearlySummary = data['data']['yearlyAttendanceSummary'][0];

        yearlyAttendanceSummary.value = {
          'totalPresent': yearlySummary['totalPresent'],
          'totalAbsent': yearlySummary['totalAbsent'],
          'totalLeave': yearlySummary['totalLeave'],
        };
      } else {
        print("Payment request failed with status: ${response.statusCode}");
        print("Response: ${response.body}");
      }
    } catch (e) {
      print("Error making payment: $e");
    }
  }
}
