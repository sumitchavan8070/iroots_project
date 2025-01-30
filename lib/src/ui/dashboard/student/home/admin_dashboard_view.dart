import 'package:flutter/material.dart';
import 'package:iroots/src/ui/dashboard/student/components/admin_card_list_wdget.dart';
import 'package:iroots/src/ui/dashboard/student/components/custom_chart.dart';
import 'package:iroots/src/ui/dashboard/student/components/attendance_view.dart';
import 'package:iroots/src/ui/dashboard/student/components/percentage_chart.dart';

class AdminDashboardView extends StatefulWidget {
  const AdminDashboardView({super.key});

  @override
  State<AdminDashboardView> createState() => _AdminDashboardViewState();
}

class _AdminDashboardViewState extends State<AdminDashboardView> {
  // static const onePNG = "assets/icons/one.png";
  // static const towPNG = "assets/icons/tow.png";
  // static const threePNG = "assets/icons/three.png";
  // static const fourPNG = "assets/icons/four.png";
  //
  // static const adminBgOne = "assets/icons/one.svg";
  // static const adminBgTow = "assets/icons/tow.svg";
  // static const adminBgThree = "assets/icons/three.svg";
  // static const adminBgFour = "assets/icons/four.svg";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF1F5F9),
      appBar: AppBar(
        title: const Text("Welcome "),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            Container(
              height: 74,
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.white, // Adjust color as needed
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1), // Shadow color

                    blurRadius: 12, // Blur effect
                    spreadRadius: 0, // Spread effect
                    offset: const Offset(0, 0),
                    // Shadow position
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Academics year ",
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: const Color(0xFF1575FF), fontSize: 20, fontWeight: FontWeight.w700),
                  ),
                  Text(
                    "2024 <> ",
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: const Color(0xFF1575FF), fontSize: 20, fontWeight: FontWeight.w700),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            const AdminCardListWidget(),
            const SizedBox(height: 20),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 22),
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFF69A6FE), Color(0xFF69A6FE)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12), topRight: Radius.circular(12))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Text(
                        "Student Report",
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Colors.white, fontSize: 14, fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: 16),
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: '1300 ',
                              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                  color: Colors.white, fontWeight: FontWeight.w700, fontSize: 8),
                            ),
                            TextSpan(
                              text: 'Pass Students ',
                              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                  color: Colors.white, fontWeight: FontWeight.w400, fontSize: 8),
                            ),
                          ],
                        ),
                      ),
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: '300 ',
                              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                  color: Colors.white, fontWeight: FontWeight.w700, fontSize: 8),
                            ),
                            TextSpan(
                              text: 'Fail Students ',
                              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                  color: Colors.white, fontWeight: FontWeight.w400, fontSize: 8),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 90,
                    width: 90,
                    child: CircularProgressIndicatorWithText(
                      progress: 0.75, // Example progress (75%)
                      progressColor: Color(0xFF70D976), // Color for the progress
                      textValue: 1500, // Text to show in the center
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            const AttendanceView(
              attendanceData: {
                "present": ["2025-01-01", "2025-01-10", "2025-01-15"],
                "absent": ["2025-01-08", "2025-01-12", "2025-01-18"],
                "holidays": ["2025-01-17"]
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: 43,
                        width: 171,
                        decoration: BoxDecoration(
                            border: Border.all(color: const Color(0xFF0DB166).withOpacity(0.3)),
                            color: const Color(0xFF0DB166).withOpacity(0.1),
                            borderRadius: BorderRadius.circular(8)),
                        child: Center(
                          child: Text(
                            "Regional Holiday",
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                color: const Color(0xFF0DB166), fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                      Container(
                        height: 43,
                        width: 171,
                        decoration: BoxDecoration(
                            border: Border.all(color: const Color(0xFF9F7CCB).withOpacity(0.3)),
                            color: const Color(0xFF9F7CCB).withOpacity(0.1),
                            borderRadius: BorderRadius.circular(8)),
                        child: Center(
                          child: Text(
                            "National Holiday",
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                color: const Color(0xFF9F7CCB), fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: 43,
                        width: 171,
                        decoration: BoxDecoration(
                            border: Border.all(color: const Color(0xFFFF0000).withOpacity(0.3)),
                            color: const Color(0xFFFF0000).withOpacity(0.1),
                            borderRadius: BorderRadius.circular(8)),
                        child: Center(
                          child: Text(
                            "Regional Holiday",
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                color: const Color(0xFFFF0000), fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                      Container(
                        height: 43,
                        width: 171,
                        decoration: BoxDecoration(
                            border: Border.all(color: const Color(0xFF1575FF).withOpacity(0.3)),
                            color: const Color(0xFF1575FF).withOpacity(0.1),
                            borderRadius: BorderRadius.circular(8)),
                        child: Center(
                          child: Text(
                            "My Leaves",
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                color: const Color(0xFF1575FF), fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),
            SizedBox(height: 400, width: double.infinity, child: PercentageLineChart())
          ],
        ),
      ),
    );
  }
}
