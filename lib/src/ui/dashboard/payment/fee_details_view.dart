import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:iroots/src/controller/home/student/get_student_fees_details_controller.dart';
import 'package:iroots/src/controller/payment/student/payment_controller.dart';
import 'package:iroots/src/ui/dashboard/payment/student_payment_method.dart';
import 'package:iroots/src/utility/const.dart';
import 'package:iroots/src/utility/util.dart';

final _controller = Get.put(GetFeesDetailsController());

class FeeDetailsView extends StatefulWidget {
  const FeeDetailsView({super.key});

  @override
  State<FeeDetailsView> createState() => _FeeDetailsViewState();
}

class _FeeDetailsViewState extends State<FeeDetailsView> {
  final Map<int, bool> _selectedItems = {}; // To track selected items
  double totalAmount = 0.0; // To store the total amount of selected fees

  @override
  void initState() {
    super.initState();
    _loadApi();
  }

  _loadApi() async {
    final prefs = GetStorage();
    final applicationNumber = prefs.read("applicationNumber");
    debugPrint("application number in student data $applicationNumber");

    await _controller.getFeesDetails(applicationNumber.toString() ?? "");
  }

  // Function to update the total amount based on selected items
  void _updateTotalAmount() {
    totalAmount = 0.0;
    _selectedItems.forEach((index, isSelected) {
      if (isSelected) {
        final item = _controller.state?.feeDetails?[index];
        totalAmount += item?.feeValue ?? 0.0;
      }
    });
    setState(() {}); // Update the UI
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5FCFF),
      appBar: AppBar(
        title: const Text("Fee Details"),
        backgroundColor: const Color(0xFFF5FCFF),
      ),
      body: _controller.obx(
        (state) {
          return SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                ListView.builder(
                  itemCount: state?.feeDetails?.length ?? 0,
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    final item = state?.feeDetails?[index];

                    return Container(
                      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26.withOpacity(0.1),
                            blurRadius: 8,
                            offset: const Offset(0, 0),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Fee name and balance
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(item?.feeName ?? "N/A",
                                  style: Theme.of(context).textTheme.bodySmall),
                              const SizedBox(height: 8),
                              RichText(
                                text: TextSpan(
                                  children: <TextSpan>[
                                    TextSpan(
                                        text: 'Need to Pay : ',
                                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                              color: Colors.red,
                                              fontWeight: FontWeight.bold,
                                            )),
                                    TextSpan(
                                        text: '₹${item?.feeValue}',
                                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                              color: Colors.red,
                                              fontWeight: FontWeight.bold,
                                            )),
                                  ],
                                ),
                              )
                            ],
                          ),
                          // Circular Checkbox for selection
                          Transform.scale(
                            scale: 1.2, // Adjust the size of the checkbox
                            child: Checkbox(
                              value: _selectedItems[index] ?? false,
                              onChanged: (value) {
                                setState(() {
                                  _selectedItems[index] = value ?? false;
                                  _updateTotalAmount(); // Update the total amount
                                });
                              },
                              shape: const CircleBorder(), // Make checkbox circular
                              activeColor: Colors.blueAccent, // Custom color
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
                const SizedBox(height: 70),
              ],
            ),
          );
        },
        onLoading: const Center(child: CircularProgressIndicator()),
        onError: (error) {
          return const Center(
            child: Text("Something went wrong try again later "),
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: totalAmount == 0
          ? const SizedBox.shrink()
          : ElevatedButton(
              onPressed: () {
                Get.to(
                  () => PaymentMethodScreen(
                    amount: totalAmount.toString(),
                    heading: "Customized Amount",
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF066AC9),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              ),
              child: Text(
                "Make Payment  ₹${totalAmount.round()}",
                style:
                    const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
    );

    return GetBuilder(
        init: PaymentController(),
        builder: (logic) => DefaultTabController(
            length: 3,
            child: Scaffold(
              appBar: AppBar(
                elevation: 0,
                backgroundColor: ConstClass.dashBoardColor,
                title: AppUtil.customText(
                    text: "Tuition Fees ",
                    style: const TextStyle(
                        fontFamily: 'Open Sans', fontWeight: FontWeight.w700, fontSize: 16)),
                bottom: PreferredSize(
                  preferredSize: const Size.fromHeight(60),
                  child: Container(
                    color: Colors.white,
                    child: TabBar(
                      labelColor: ConstClass.selectedColor,
                      unselectedLabelColor: Colors.grey,
                      controller: logic.tabController,
                      labelStyle: TextStyle(
                          color: ConstClass.selectedColor,
                          fontFamily: 'Open Sans',
                          fontWeight: FontWeight.bold,
                          fontSize: 12),
                      unselectedLabelStyle: const TextStyle(
                          color: Colors.grey,
                          fontFamily: 'Open Sans',
                          fontWeight: FontWeight.bold,
                          fontSize: 12),
                      tabs: const [
                        Tab(text: 'Term Fees'),
                        Tab(text: 'Transport Fees'),
                      ],
                    ),
                  ),
                ),
              ),
              body: TabBarView(
                physics: const NeverScrollableScrollPhysics(),
                controller: logic.tabController,
                children: [
                  tabWidget(),
                  tabWidget(),
                ],
              ),
              bottomNavigationBar: Container(
                color: const Color(0xffF1F5F9),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  child: SizedBox(
                    width: Get.width,
                    child: customOutlinedButton(
                        OutlinedButton.styleFrom(
                          backgroundColor: ConstClass.themeColor,
                          side: BorderSide(width: 1.5, color: ConstClass.themeColor),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 12),
                            child: AppUtil.customText(
                              text: "Confirm",
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Open Sans',
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14),
                            )), () {
                      // Get.to(() => const PaymentMethodScreen());
                    }),
                  ),
                ),
              ),
            )));
  }

  Widget tabWidget() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppUtil.customText(
            text: "Fees Details",
            style:
                const TextStyle(fontFamily: 'Open Sans', fontWeight: FontWeight.w700, fontSize: 14),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            width: Get.width,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(5), topRight: Radius.circular(5)),
              border: Border.all(
                color: Colors.grey,
                width: 0.9,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                feesTermWidget(),
                const Divider(),
                feesTermWidget(),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: const BoxDecoration(
                    color: Color(0xff034BB1),
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(5), bottomRight: Radius.circular(5)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AppUtil.customText(
                        text: "Total Due Amount",
                        style: const TextStyle(
                            color: Colors.white,
                            fontFamily: 'Open Sans',
                            fontWeight: FontWeight.w600,
                            fontSize: 12),
                      ),
                      AppUtil.customText(
                        text: "₹4000",
                        style: const TextStyle(
                            color: Colors.white,
                            fontFamily: 'Open Sans',
                            fontWeight: FontWeight.w600,
                            fontSize: 12),
                      ),
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget feesTermWidget() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Row(
        children: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.check_box),
            color: ConstClass.themeColor,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppUtil.customText(
                  text: "First Term",
                  style: const TextStyle(
                      fontFamily: 'Open Sans', fontWeight: FontWeight.w600, fontSize: 12),
                ),
                AppUtil.customText(
                  text: "Last Due date :- 30-Apr-2024",
                  style: const TextStyle(
                      color: Color(0xffE11D48),
                      fontFamily: 'Open Sans',
                      fontWeight: FontWeight.w500,
                      fontSize: 10),
                ),
                AppUtil.customText(
                  text: "Due date :- 20-Apr-2024",
                  style: const TextStyle(
                      color: Colors.grey,
                      fontFamily: 'Open Sans',
                      fontWeight: FontWeight.w500,
                      fontSize: 10),
                ),
              ],
            ),
          ),
          AppUtil.customText(
            text: "₹2000",
            style: const TextStyle(
                color: Color(0xff1575FF),
                fontFamily: 'Open Sans',
                fontWeight: FontWeight.w700,
                fontSize: 10),
          ),
        ],
      ),
    );
  }

  Widget customOutlinedButton(ButtonStyle buttonStyle, Widget widget, Function() onPressed) {
    return OutlinedButton(
      style: buttonStyle,
      /* onPressed: () {
        logic.pickDateDialog(context);
      },*/
      onPressed: onPressed,
      child: widget,
    );
  }
}
