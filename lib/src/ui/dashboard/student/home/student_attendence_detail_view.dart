import 'package:flutter/material.dart';

class StudentAttendanceDetail extends StatefulWidget {
  const StudentAttendanceDetail({super.key});

  @override
  State<StudentAttendanceDetail> createState() => _StudentAttendanceDetailState();
}

class _StudentAttendanceDetailState extends State<StudentAttendanceDetail> {
  final List<Map<String, dynamic>> attendanceData = [
    {"month": "January", "present": 26, "leave": 3, "absent": 1},
    {"month": "February", "present": 24, "leave": 4, "absent": 2},
    {"month": "March", "present": 27, "leave": 2, "absent": 2},
    {"month": "April", "present": 25, "leave": 3, "absent": 2},
    {"month": "May", "present": 28, "leave": 1, "absent": 1},
    {"month": "June", "present": 26, "leave": 2, "absent": 2},
    {"month": "July", "present": 27, "leave": 2, "absent": 1},
    {"month": "August", "present": 26, "leave": 3, "absent": 1},
    {"month": "September", "present": 25, "leave": 4, "absent": 1},
    {"month": "October", "present": 27, "leave": 2, "absent": 2},
    {"month": "November", "present": 26, "leave": 3, "absent": 1},
    {"month": "December", "present": 28, "leave": 1, "absent": 1},
  ];

  Color getColor(String status) {
    switch (status) {
      case "present":
        return const Color(0xFF0DB166);
      case "absent":
        return const Color(0xFF9F7CCB);
      case "leave":
        return const Color(0xFFFF0000);
      default:
        return Colors.grey;
    }
  }

  Widget _attendanceWidget({
    required Color color,
    required String attendance,
    required String status,
  }) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(8),
        margin: const EdgeInsets.symmetric(horizontal: 6),
        decoration: BoxDecoration(
          color: color.withOpacity(0.15),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: color.withOpacity(0.6), width: 1),
        ),
        child: Column(
          children: [
            Text(
              attendance,
              style: Theme.of(context)
                  .textTheme
                  .bodySmall
                  ?.copyWith(color: color, fontWeight: FontWeight.w400),
            ),
            Text(
              status,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(color: color, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF1F5F9),
      appBar: AppBar(title: const Text("Student Attendance")),
      body: ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: attendanceData.length,
        itemBuilder: (context, index) {
          final item = attendanceData[index];

          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item["month"],
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _attendanceWidget(
                          color: getColor("present"),
                          attendance: item['present'].toString(),
                          status: "present",
                        ),
                        _attendanceWidget(
                          color: getColor("absent"),
                          attendance: item['absent'].toString(),
                          status: "absent",
                        ),
                        _attendanceWidget(
                          color: getColor("leave"),
                          attendance: item['leave'].toString(),
                          status: "leave",
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
