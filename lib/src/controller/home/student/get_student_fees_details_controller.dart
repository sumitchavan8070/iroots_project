import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:iroots/common/app_data.dart';
import 'dart:convert';

import 'package:iroots/src/controller/home/student/fees_details_model.dart';

class GetFeesDetailsController extends GetxController with StateMixin<FeesDetailsModel> {
  Future<void> getFeesDetails(applicationNumber) async {
final url =     "${baseUrlName}Paymet/get-student-fees?applicationNumber=$applicationNumber";
    try {
      change(null, status: RxStatus.loading()); // Set state to loading

      final response = await http.get(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final payment = FeesDetailsModel.fromJson(data);
        change(payment, status: RxStatus.success()); // Set state to success
      } else {
        change(null, status: RxStatus.error('Payment failed')); // Set state to error
      }
    } catch (e) {
      change(null, status: RxStatus.error(e.toString())); // Handle error
    }
  }
}
