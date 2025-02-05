class GetStudentTableShowModal {
  GetStudentTableShowModal({
      this.tableData,});

  GetStudentTableShowModal.fromJson(dynamic json) {
    if (json['table_data'] != null) {
      tableData = [];
      json['table_data'].forEach((v) {
        tableData?.add(TableData.fromJson(v));
      });
    }
  }
  List<TableData>? tableData;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (tableData != null) {
      map['table_data'] = tableData?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class TableData {
  TableData({
      this.index,
      this.studentName,
      this.className,
      this.sectionName,
      this.markFullDayAbsent,
      this.date,
      this.day,});


  TableData.fromJson(dynamic json) {
    index = json['index'];
    studentName = json['Student Name'];
    className = json['Class Name'];
    sectionName = json['Section Name'];
    markFullDayAbsent = json['markFullDayAbsent'];
    date = json['Date'];
    day = json['Day'];
  }
  num? index;
  String? studentName;
  String? className;
  String? sectionName;
  String? markFullDayAbsent;
  String? date;
  String? day;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['index'] = index;
    map['Student Name'] = studentName;
    map['Class Name'] = className;
    map['Section Name'] = sectionName;
    map['markFullDayAbsent'] = markFullDayAbsent;
    map['Date'] = date;
    map['Day'] = day;
    return map;
  }

}