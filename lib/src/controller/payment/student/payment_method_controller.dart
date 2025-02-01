import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PaymentMethodController extends GetxController
    with GetSingleTickerProviderStateMixin {
  TabController? tabController;
  // TextEditingController controllerCarHolderName = TextEditingController();
  TextEditingController controllerCardHolderName = TextEditingController();
  TextEditingController controllerCardNumber = TextEditingController();
  TextEditingController controllerExpiryDate = TextEditingController();
  TextEditingController controllerCVV = TextEditingController();
  @override
  void onInit() {
    super.onInit();
    tabController = TabController(vsync: this, length: 3);
  }

  @override
  void onClose() {
    tabController!.dispose();
    super.onClose();
  }
}
