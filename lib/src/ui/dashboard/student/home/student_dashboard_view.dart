import 'package:flutter/material.dart';
import 'package:iroots/src/ui/dashboard/student/components/academics_card.dart';
import 'package:iroots/src/ui/dashboard/student/components/attendance_view.dart';
import 'package:iroots/src/ui/dashboard/student/components/student_detail_card.dart';

class StudentDashboardView extends StatefulWidget {
  const StudentDashboardView({super.key});

  @override
  State<StudentDashboardView> createState() => _StudentDashboardViewState();
}

class _StudentDashboardViewState extends State<StudentDashboardView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Guy Hawkins"),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            const SizedBox(height: 40),
            const StudentDetailCard(),
            const SizedBox(height: 18),
            const AcademicsCard(),
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
          ],
        ),
      ),
    );
  }
}
