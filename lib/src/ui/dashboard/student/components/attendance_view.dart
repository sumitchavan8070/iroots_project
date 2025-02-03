import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AttendanceView extends StatefulWidget {
  final dynamic attendanceData;

  const AttendanceView({Key? key, required this.attendanceData})
      : super(key: key);

  @override
  AttendanceViewState createState() => AttendanceViewState();
}

class AttendanceViewState extends State<AttendanceView> {
  Set<DateTime> presentDates = {};
  Set<DateTime> absentDates = {};
  DateTime _currentMonth = DateTime.now();
  DateTime _currentDate = DateTime.now(); // Track the current date

  @override
  void initState() {
    super.initState();
    _parseAttendanceData();
  }

  void _parseAttendanceData() {
    for (var attendance in widget.attendanceData) {
      final date = DateFormat('dd/MM/yyyy').parse(attendance['createdDate']);
      if (attendance['markFullDayAbsent'] == "False") {
        absentDates.add(date); // Add to absentDates if markFullDayAbsent is "False"
      } else {
        presentDates.add(date); // Add to presentDates if markFullDayAbsent is "True"
      }
    }
  }

  List<DateTime> getDisplayDates(DateTime currentDate) {
    final firstDateOfMonth = DateTime(currentDate.year, currentDate.month, 1);
    final lastDateOfMonth = DateTime(currentDate.year, currentDate.month + 1, 0);
    DateTime firstDisplayDate = firstDateOfMonth;
    DateTime lastDisplayDate = lastDateOfMonth;

    while (firstDisplayDate.weekday != DateTime.sunday) {
      firstDisplayDate = firstDisplayDate.subtract(const Duration(days: 1));
    }

    while (lastDisplayDate.weekday != DateTime.saturday) {
      lastDisplayDate = lastDisplayDate.add(const Duration(days: 1));
    }

    List<DateTime> dates = [];
    DateTime indexDate = firstDisplayDate;
    while (indexDate.isBefore(lastDisplayDate.add(const Duration(days: 1)))) {
      dates.add(indexDate);
      indexDate = indexDate.add(const Duration(days: 1));
    }
    return dates;
  }

  Color _getAttendanceColor(DateTime day) {
    // Highlight the current date with blue color
    if (day.year == _currentDate.year &&
        day.month == _currentDate.month &&
        day.day == _currentDate.day) {
      return const Color(0xFF1575FF).withOpacity(0.2);
    }
    if (presentDates.contains(day)) {
      return const Color(0xFF0DB166).withOpacity(0.2); // Green for present
    }
    if (absentDates.contains(day)) {
      return const Color(0xFFFF0000).withOpacity(0.2); // Red for absent
    }
    if (day.weekday == DateTime.sunday) {
      return const Color(0xFF9F7CCB).withOpacity(0.2); // Purple for Sundays
    }
    return Colors.transparent;
  }

  Color _getTextColor(DateTime day) {
    // Highlight the current date with white text
    if (day.year == _currentDate.year &&
        day.month == _currentDate.month &&
        day.day == _currentDate.day) {
      return Colors.white;
    }
    if (presentDates.contains(day)) {
      return const Color(0xFF0DB166).withOpacity(0.6); // Green text for present
    }
    if (absentDates.contains(day)) {
      return const Color(0xFFFF0000).withOpacity(0.6); // Red text for absent
    }
    if (day.weekday == DateTime.sunday) {
      return const Color(0xFF9F7CCB).withOpacity(0.6); // Purple text for Sundays
    }
    return day.month == _currentMonth.month
        ? const Color(0xFF1575FF)
        : Colors.grey;
  }

  void _changeMonth(int offset) {
    setState(() {
      _currentMonth = DateTime(_currentMonth.year, _currentMonth.month + offset, 1);
    });
  }

  @override
  Widget build(BuildContext context) {
    final daysInMonth = getDisplayDates(_currentMonth);
    final monthName = DateFormat('MMMM yyyy').format(_currentMonth);
    final weekDays = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];

    return Container(
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8), color: Colors.white),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                monthName,
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF0F172A)),
              ),
              Row(
                children: [
                  GestureDetector(
                    onTap: () => _changeMonth(-1),
                    child: const CircleAvatar(
                      backgroundColor: Colors.blue,
                      radius: 12,
                      child: Icon(Icons.arrow_back_ios_new,
                          size: 10, color: Colors.white),
                    ),
                  ),
                  const SizedBox(width: 12),
                  GestureDetector(
                    onTap: () => _changeMonth(1),
                    child: const CircleAvatar(
                      backgroundColor: Colors.blue,
                      radius: 12,
                      child: Icon(Icons.arrow_forward_ios,
                          size: 10, color: Colors.white),
                    ),
                  ),
                ],
              )
            ],
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: weekDays
                .map(
                  (day) => Text(
                day,
                style: const TextStyle(
                    fontWeight: FontWeight.bold, color: Color(0xFF1575FF)),
              ),
            )
                .toList(),
          ),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.all(4),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 7,
              mainAxisExtent: 50,
            ),
            itemCount: daysInMonth.length,
            itemBuilder: (context, index) {
              final day = daysInMonth[index];
              final color = _getAttendanceColor(day);
              final textColor = _getTextColor(day);
              final isOtherMonth = day.month != _currentMonth.month;

              return Opacity(
                opacity: isOtherMonth ? 0.25 : 1.0,
                child: Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: color == Colors.transparent
                          ? const Color(0xFF1575FF).withOpacity(0.1)
                          : color,
                    ),
                    color: color,
                  ),
                  child: Text(
                    '${day.day}',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      fontWeight: FontWeight.w400,
                      fontSize: 12,
                      color: textColor,
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}