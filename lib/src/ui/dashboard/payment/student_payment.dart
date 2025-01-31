import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iroots/src/controller/home/student/get_student_fees_details_controller.dart';
import 'package:iroots/src/controller/payment/student/payment_controller.dart';
import 'package:iroots/src/ui/dashboard/payment/student_payment_method.dart';
import 'package:iroots/src/utility/const.dart';
import 'package:iroots/src/utility/util.dart';


final _controller = Get.put(GetFeesDetailsController());

class PaymentScreen extends StatefulWidget {
  PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadApi();


  }

  _loadApi ()async{
     const  tempNumber = "20242207104403";
     await  _controller.getFeesDetails(tempNumber);
  }

  final List<Map<String, dynamic>> feeDetails = [
    {
      "feeName": "Re-Admission",
      "feeValue": 4000,
      "paidAmount": 0,
      "balance": 4000
    },
    {
      "feeName": "January Month School Fee",
      "feeValue": 900,
      "paidAmount": 0,
      "balance": 900
    },
    {
      "feeName": "February Month School Fee",
      "feeValue": 900,
      "paidAmount": 0,
      "balance": 900
    },
    {
      "feeName": "March Month School Fee",
      "feeValue": 900,
      "paidAmount": 0,
      "balance": 900
    },
    {
      "feeName": "April Month School Fee",
      "feeValue": 900,
      "paidAmount": 0,
      "balance": 900
    },
    {
      "feeName": "May Month School Fee",
      "feeValue": 900,
      "paidAmount": 0,
      "balance": 900
    },
    {
      "feeName": "June Month School Fee",
      "feeValue": 900,
      "paidAmount": 0,
      "balance": 900
    },
    {
      "feeName": "July Month School Fee",
      "feeValue": 900,
      "paidAmount": 0,
      "balance": 900
    },
    {
      "feeName": "August Month School Fee",
      "feeValue": 900,
      "paidAmount": 0,
      "balance": 900
    },
    {
      "feeName": "September Month School Fee",
      "feeValue": 900,
      "paidAmount": 0,
      "balance": 900
    },
    {
      "feeName": "October Month School Fee",
      "feeValue": 900,
      "paidAmount": 0,
      "balance": 900
    },
    {
      "feeName": "November Month School Fee",
      "feeValue": 900,
      "paidAmount": 0,
      "balance": 900
    },
    {
      "feeName": "December Month School Fee",
      "feeValue": 900,
      "paidAmount": 0,
      "balance": 900
    },
  ];

  @override
  Widget build(BuildContext context) {


    return
      Scaffold(
        appBar: AppBar(
          title: const Text("Fee Details"),
          backgroundColor: Colors.blueAccent,
          elevation: 0,
        ),
        body: _controller.obx((state) {
          return
            SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  ListView.builder(
                    itemCount: feeDetails.length,
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      final fee = feeDetails[index];
                      return Container(
                        margin:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
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
                                Text(fee["feeName"],
                                    style: Theme.of(context).textTheme.bodySmall),
                                const SizedBox(height: 8),
                                Text("Balance: ₹${fee["balance"]}"),
                              ],
                            ),
                            // Pay Now button
                            ElevatedButton.icon(
                              onPressed: () {
                                // Handle the "Pay Now" button action
                                print("Pay Now for ${fee["feeName"]}");
                              },
                              label: const Row(
                                children: [
                                  Text("Pay Now"),
                                ],
                              ),
                              style: ElevatedButton.styleFrom(
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                  // Total Amount and Floating Action Button
                ],
              ),
            );


        },
          onLoading: const Center(child: CircularProgressIndicator()),
          onError: (error) {
            return const Center(child: Text("Something went wrong try again later "),);

          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        // floatingActionButton: ElevatedButton(
        //   onPressed: () {},
        //   style: ElevatedButton.styleFrom(
        //     backgroundColor: Colors.blueAccent, // Blue button
        //     shape: RoundedRectangleBorder(
        //       borderRadius: BorderRadius.circular(50), // Border radius 50
        //     ),
        //     padding: const EdgeInsets.symmetric(
        //         horizontal: 20, vertical: 12), // Adjust padding
        //   ),
        //   child: Text(
        //     "Make Full Payment  ₹${totalAmount.toStringAsFixed(2)}",
        //     style: const TextStyle(
        //         color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
        //   ),
        // ),
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
                        fontFamily: 'Open Sans',
                        fontWeight: FontWeight.w700,
                        fontSize: 16)),
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
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  child: SizedBox(
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
                              text: "Confirm",
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Open Sans',
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14),
                            )), () {
                      Get.to(() => const PaymentMethodScreen());
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
            style: const TextStyle(
                fontFamily: 'Open Sans',
                fontWeight: FontWeight.w700,
                fontSize: 14),
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
                        bottomLeft: Radius.circular(5),
                        bottomRight: Radius.circular(5)),
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
                      fontFamily: 'Open Sans',
                      fontWeight: FontWeight.w600,
                      fontSize: 12),
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

  Widget customOutlinedButton(
      ButtonStyle buttonStyle, Widget widget, Function() onPressed) {
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
