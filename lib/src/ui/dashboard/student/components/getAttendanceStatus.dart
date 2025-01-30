import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AttendanceView extends StatefulWidget {
  final Map<String, dynamic> attendanceData;

  const AttendanceView({Key? key, required this.attendanceData}) : super(key: key);

  @override
  AttendanceViewState createState() => AttendanceViewState();
}

class AttendanceViewState extends State<AttendanceView> {
  Set<DateTime> presentDates = {};
  Set<DateTime> absentDates = {};
  Set<DateTime> holidays = {};
  Set<DateTime> leaveDates = {};

  @override
  void initState() {
    super.initState();
    _parseAttendanceData();
  }

  void _parseAttendanceData() {
    presentDates = _convertToDateSet(widget.attendanceData['present']);
    absentDates = _convertToDateSet(widget.attendanceData['absent']);
    holidays = _convertToDateSet(widget.attendanceData['holidays']);
    leaveDates = _convertToDateSet(widget.attendanceData['leaves']);
  }

  Set<DateTime> _convertToDateSet(List<dynamic>? dates) {
    if (dates == null) return {};
    return dates.map((date) => DateTime.parse(date)).toSet();
  }

  List<DateTime> getDisplayDates(DateTime currentDate) {
    final firstDateOfMonth = DateTime(currentDate.year, currentDate.month, 1);
    final lastDateOfMonth = DateTime(currentDate.year, currentDate.month + 1, 0);
    DateTime firstDisplayDate = firstDateOfMonth;
    DateTime lastDisplayDate = lastDateOfMonth;

    DateTime indexDate = firstDisplayDate;
    while (indexDate.weekday != DateTime.sunday) {
      indexDate = indexDate.subtract(const Duration(days: 1));
    }
    firstDisplayDate = indexDate;

    indexDate = lastDisplayDate;
    while (indexDate.weekday != DateTime.saturday) {
      indexDate = indexDate.add(const Duration(days: 1));
    }
    lastDisplayDate = indexDate.add(const Duration(days: 1));

    List<DateTime> dates = [];
    indexDate = firstDisplayDate;
    while (indexDate.isBefore(lastDisplayDate)) {
      dates.add(indexDate);
      indexDate = indexDate.add(const Duration(days: 1));
    }
    return dates;
  }

  String _getAttendanceStatus(DateTime day) {
    if (presentDates.contains(day)) {
      return 'P';
    } else if (absentDates.contains(day)) {
      return 'A';
    } else if (holidays.contains(day) || day.weekday == DateTime.sunday) {
      return 'H';
    } else if (leaveDates.contains(day)) {
      return 'L';
    } else {
      return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    final DateTime _currentMonth = DateTime.now();
    final daysInMonth = getDisplayDates(_currentMonth);
    final monthName = DateFormat('MMMM yyyy').format(_currentMonth);
    final weekDays = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];

    return Container(
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: Colors.white),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                monthName,
                style: Theme.of(context)
                    .textTheme
                    .titleSmall
                    ?.copyWith(fontWeight: FontWeight.w700, color: const Color(0xFF0F172A)),
              ),
              const Row(
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.blue,
                    radius: 12,
                    child: Icon(Icons.arrow_back_ios_new, size: 10, color: Colors.white),
                  ),
                  SizedBox(width: 12),
                  CircleAvatar(
                    backgroundColor: Colors.blue,
                    radius: 12,
                    child: Icon(Icons.arrow_forward_ios, size: 10, color: Colors.white),
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
                    style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF1575FF)),
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
              final status = _getAttendanceStatus(day);
              final isOtherMonth = day.month != _currentMonth.month;

              return Opacity(
                opacity: isOtherMonth ? 0.25 : 1.0,
                child: Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: status == 'P'
                            ? Colors.green.withOpacity(0.2)
                            : status == 'A'
                                ? Colors.red.withOpacity(0.2)
                                : status == 'H'
                                    ? Colors.purple.withOpacity(0.2)
                                    : status == 'L'
                                        ? Colors.blue
                                        : Colors.transparent,
                      ),
                      color: status == 'P'
                          ? Colors.green.withOpacity(0.1)
                          : status == 'A'
                              ? Colors.red.withOpacity(0.1)
                              : status == 'H'
                                  ? Colors.purple.withOpacity(0.1)
                                  : status == 'L'
                                      ? Colors.blue
                                      : Colors.transparent),
                  child: Text(
                    '${day.day}',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.w400,
                        fontSize: 12,
                        color: status == 'P'
                            ? Colors.green
                            : status == 'A'
                                ? Colors.red
                                : status == 'H'
                                    ? Colors.purple
                                    : status == 'L'
                                        ? Colors.white
                                        : isOtherMonth
                                            ? Colors.grey
                                            : Colors.black),
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
