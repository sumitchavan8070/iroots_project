class GetStudentTableShowModal {
  GetStudentTableShowModal({
    this.tableData,
  });

  GetStudentTableShowModal.fromJson(dynamic json) {
    if (json['tabledata'] != null) {
      tableData = [];
      json['tabledata'].forEach((v) {
        tableData?.add(TableData.fromJson(v));
      });
    }
  }

  List<TableData>? tableData;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (tableData != null) {
      map['tabledata'] = tableData?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class TableData {
  TableData({
    this.attendanceId,
    this.classId,
    this.sectionId,
    this.className,
    this.sectionName,
    this.markFullDayAbsent,
    this.markHalfDayAbsent,
    this.studentRegisterId,
    this.studentName,
    this.createdDate,
    this.day,
    this.createdBy,
    this.others,
  });

  TableData.fromJson(dynamic json) {
    attendanceId = json['attendanceId'];
    classId = json['classId'];
    sectionId = json['sectionId'];
    className = json['className'];
    sectionName = json['sectionName'];
    markFullDayAbsent = json['markFullDayAbsent'];
    markHalfDayAbsent = json['markHalfDayAbsent'];
    studentRegisterId = json['studentRegisterId'];
    studentName = json['studentName'];
    createdDate = json['createdDate'];
    day = json['day'];
    createdBy = json['createdBy'];
    others = json['others'];
  }

  int? attendanceId;
  int? classId;
  int? sectionId;
  String? className;
  String? sectionName;
  String? markFullDayAbsent;
  String? markHalfDayAbsent;
  int? studentRegisterId;
  String? studentName;
  String? createdDate;
  String? day;
  String? createdBy;
  String? others;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['attendanceId'] = attendanceId;
    map['classId'] = classId;
    map['sectionId'] = sectionId;
    map['className'] = className;
    map['sectionName'] = sectionName;
    map['markFullDayAbsent'] = markFullDayAbsent;
    map['markHalfDayAbsent'] = markHalfDayAbsent;
    map['studentRegisterId'] = studentRegisterId;
    map['studentName'] = studentName;
    map['createdDate'] = createdDate;
    map['day'] = day;
    map['createdBy'] = createdBy;
    map['others'] = others;
    return map;
  }
}
