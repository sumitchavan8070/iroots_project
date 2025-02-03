class GetAttedenceAsPerMonthModel {
  GetAttedenceAsPerMonthModel({
      this.data, 
      this.msg, 
      this.responseCode, 
      this.additionalData,});

  GetAttedenceAsPerMonthModel.fromJson(dynamic json) {
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    msg = json['msg'];
    responseCode = json['responseCode'];
    additionalData = json['additionalData'];
  }
  Data? data;
  String? msg;
  String? responseCode;
  String? additionalData;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (data != null) {
      map['data'] = data?.toJson();
    }
    map['msg'] = msg;
    map['responseCode'] = responseCode;
    map['additionalData'] = additionalData;
    return map;
  }

}

class Data {
  Data({
      this.dateRangeAttendance, 
      this.yearlyAttendanceSummary,});

  Data.fromJson(dynamic json) {
    if (json['dateRangeAttendance'] != null) {
      dateRangeAttendance = [];
      json['dateRangeAttendance'].forEach((v) {
        dateRangeAttendance?.add(DateRangeAttendance.fromJson(v));
      });
    }
    if (json['yearlyAttendanceSummary'] != null) {
      yearlyAttendanceSummary = [];
      json['yearlyAttendanceSummary'].forEach((v) {
        yearlyAttendanceSummary?.add(YearlyAttendanceSummary.fromJson(v));
      });
    }
  }
  List<DateRangeAttendance>? dateRangeAttendance;
  List<YearlyAttendanceSummary>? yearlyAttendanceSummary;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (dateRangeAttendance != null) {
      map['dateRangeAttendance'] = dateRangeAttendance?.map((v) => v.toJson()).toList();
    }
    if (yearlyAttendanceSummary != null) {
      map['yearlyAttendanceSummary'] = yearlyAttendanceSummary?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class YearlyAttendanceSummary {
  YearlyAttendanceSummary({
      this.year, 
      this.month, 
      this.totalPresent, 
      this.totalAbsent, 
      this.totalLeave,});

  YearlyAttendanceSummary.fromJson(dynamic json) {
    year = json['year'];
    month = json['month'];
    totalPresent = json['totalPresent'];
    totalAbsent = json['totalAbsent'];
    totalLeave = json['totalLeave'];
  }
  num? year;
  num? month;
  num? totalPresent;
  num? totalAbsent;
  num? totalLeave;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['year'] = year;
    map['month'] = month;
    map['totalPresent'] = totalPresent;
    map['totalAbsent'] = totalAbsent;
    map['totalLeave'] = totalLeave;
    return map;
  }

}

class DateRangeAttendance {
  DateRangeAttendance({
      this.attendanceId, 
      this.className, 
      this.sectionName, 
      this.studentRegisterId, 
      this.studentName, 
      this.createdDate, 
      this.markFullDayAbsent, 
      this.markHalfDayAbsent, 
      this.others,});

  DateRangeAttendance.fromJson(dynamic json) {
    attendanceId = json['attendanceId'];
    className = json['className'];
    sectionName = json['sectionName'];
    studentRegisterId = json['studentRegisterId'];
    studentName = json['studentName'];
    createdDate = json['createdDate'];
    markFullDayAbsent = json['markFullDayAbsent'];
    markHalfDayAbsent = json['markHalfDayAbsent'];
    others = json['others'];
  }
  num? attendanceId;
  String? className;
  String? sectionName;
  num? studentRegisterId;
  String? studentName;
  String? createdDate;
  String? markFullDayAbsent;
  String? markHalfDayAbsent;
  String? others;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['attendanceId'] = attendanceId;
    map['className'] = className;
    map['sectionName'] = sectionName;
    map['studentRegisterId'] = studentRegisterId;
    map['studentName'] = studentName;
    map['createdDate'] = createdDate;
    map['markFullDayAbsent'] = markFullDayAbsent;
    map['markHalfDayAbsent'] = markHalfDayAbsent;
    map['others'] = others;
    return map;
  }

}