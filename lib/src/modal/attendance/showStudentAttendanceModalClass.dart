import 'dart:convert';

ShowStudentAttendanceModalClass showStudentAttendanceModalClassFromJson(
        String str) =>
    ShowStudentAttendanceModalClass.fromJson(json.decode(str));

String showStudentAttendanceModalClassToJson(
        ShowStudentAttendanceModalClass data) =>
    json.encode(data.toJson());

class ShowStudentAttendanceModalClass {
  List<ShowStudentAttendanceDatum>? data;
  String? msg;
  String? responseCode;
  String? additionalData;

  ShowStudentAttendanceModalClass({
    this.data,
    this.msg,
    this.responseCode,
    this.additionalData,
  });

  factory ShowStudentAttendanceModalClass.fromJson(Map<String, dynamic> json) =>
      ShowStudentAttendanceModalClass(
        data: json["data"] == null
            ? []
            : List<ShowStudentAttendanceDatum>.from(json["data"]!
                .map((x) => ShowStudentAttendanceDatum.fromJson(x))),
        msg: json["msg"],
        responseCode: json["responseCode"],
        additionalData: json["additionalData"],
      );

  Map<String, dynamic> toJson() => {
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
        "msg": msg,
        "responseCode": responseCode,
        "additionalData": additionalData,
      };
}

class ShowStudentAttendanceDatum {
  int? studentId;
  String? applicationNumber;
  String? uin;
  dynamic date;
  String? name;
  String? datumClass;
  String? section;
  String? gender;
  int? ageInWords;
  String? dob;
  String? pob;
  String? nationality;
  String? religion;
  String? motherTongue;
  String? category;
  String? bloodGroup;
  dynamic medicalHistory;
  dynamic hobbies;
  dynamic sports;
  dynamic otherDetails;
  dynamic profileAvatar;
  DateTime? addedDate;
  DateTime? modifiedDate;
  String? ip;
  dynamic userId;
  bool? isDeleted;
  int? createBy;
  int? currentYear;
  dynamic insertBy;
  dynamic markForIdentity;
  dynamic otherLanguages;
  String? medium;
  String? caste;
  dynamic rte;
  String? adharNo;
  dynamic adharFile;
  String? batchName;
  bool? isApplyforTc;
  bool? isApplyforAdmission;
  int? isApprove;
  bool? isActive;
  dynamic isInsertFromAd;
  dynamic isAdmissionPaid;
  dynamic regNumber;
  int? classId;
  int? categoryId;
  int? batchId;
  String? parentEmail;
  dynamic admissionFeePaid;
  String? lastName;
  dynamic transport;
  dynamic transportOptions;
  dynamic mobile;
  dynamic city;
  dynamic state;
  dynamic pincode;
  int? bloodGroupId;
  bool? isPromoted;
  int? sectionId;
  dynamic rollNo;
  int? scholarNo;
  List<dynamic>? additionalInformations;
  List<dynamic>? guardianDetails;
  List<dynamic>? pastSchoolingReports;
  List<dynamic>? studentRemoteAccesses;
  List<dynamic>? studentTcDetails;
  List<dynamic>? tcFeeDetails;

  ShowStudentAttendanceDatum({
    this.studentId,
    this.applicationNumber,
    this.uin,
    this.date,
    this.name,
    this.datumClass,
    this.section,
    this.gender,
    this.ageInWords,
    this.dob,
    this.pob,
    this.nationality,
    this.religion,
    this.motherTongue,
    this.category,
    this.bloodGroup,
    this.medicalHistory,
    this.hobbies,
    this.sports,
    this.otherDetails,
    this.profileAvatar,
    this.addedDate,
    this.modifiedDate,
    this.ip,
    this.userId,
    this.isDeleted,
    this.createBy,
    this.currentYear,
    this.insertBy,
    this.markForIdentity,
    this.otherLanguages,
    this.medium,
    this.caste,
    this.rte,
    this.adharNo,
    this.adharFile,
    this.batchName,
    this.isApplyforTc,
    this.isApplyforAdmission,
    this.isApprove,
    this.isActive,
    this.isInsertFromAd,
    this.isAdmissionPaid,
    this.regNumber,
    this.classId,
    this.categoryId,
    this.batchId,
    this.parentEmail,
    this.admissionFeePaid,
    this.lastName,
    this.transport,
    this.transportOptions,
    this.mobile,
    this.city,
    this.state,
    this.pincode,
    this.bloodGroupId,
    this.isPromoted,
    this.sectionId,
    this.rollNo,
    this.scholarNo,
    this.additionalInformations,
    this.guardianDetails,
    this.pastSchoolingReports,
    this.studentRemoteAccesses,
    this.studentTcDetails,
    this.tcFeeDetails,
  });

  factory ShowStudentAttendanceDatum.fromJson(Map<String, dynamic> json) =>
      ShowStudentAttendanceDatum(
        studentId: json["studentId"],
        applicationNumber: json["applicationNumber"],
        uin: json["uin"],
        date: json["date"],
        name: json["name"],
        datumClass: json["class"],
        section: json["section"],
        gender: json["gender"],
        ageInWords: json["ageInWords"],
        dob: json["dob"],
        pob: json["pob"],
        nationality: json["nationality"],
        religion: json["religion"],
        motherTongue: json["motherTongue"],
        category: json["category"],
        bloodGroup: json["bloodGroup"],
        medicalHistory: json["medicalHistory"],
        hobbies: json["hobbies"],
        sports: json["sports"],
        otherDetails: json["otherDetails"],
        profileAvatar: json["profileAvatar"],
        addedDate: json["addedDate"] == null
            ? null
            : DateTime.parse(json["addedDate"]),
        modifiedDate: json["modifiedDate"] == null
            ? null
            : DateTime.parse(json["modifiedDate"]),
        ip: json["ip"],
        userId: json["userId"],
        isDeleted: json["isDeleted"],
        createBy: json["createBy"],
        currentYear: json["currentYear"],
        insertBy: json["insertBy"],
        markForIdentity: json["markForIdentity"],
        otherLanguages: json["otherLanguages"],
        medium: json["medium"],
        caste: json["caste"],
        rte: json["rte"],
        adharNo: json["adharNo"],
        adharFile: json["adharFile"],
        batchName: json["batchName"],
        isApplyforTc: json["isApplyforTc"],
        isApplyforAdmission: json["isApplyforAdmission"],
        isApprove: json["isApprove"],
        isActive: json["isActive"],
        isInsertFromAd: json["isInsertFromAd"],
        isAdmissionPaid: json["isAdmissionPaid"],
        regNumber: json["regNumber"],
        classId: json["classId"],
        categoryId: json["categoryId"],
        batchId: json["batchId"],
        parentEmail: json["parentEmail"],
        admissionFeePaid: json["admissionFeePaid"],
        lastName: json["lastName"],
        transport: json["transport"],
        transportOptions: json["transportOptions"],
        mobile: json["mobile"],
        city: json["city"],
        state: json["state"],
        pincode: json["pincode"],
        bloodGroupId: json["bloodGroupId"],
        isPromoted: json["isPromoted"],
        sectionId: json["sectionId"],
        rollNo: json["rollNo"],
        scholarNo: json["scholarNo"],
        additionalInformations: json["additionalInformations"] == null
            ? []
            : List<dynamic>.from(json["additionalInformations"]!.map((x) => x)),
        guardianDetails: json["guardianDetails"] == null
            ? []
            : List<dynamic>.from(json["guardianDetails"]!.map((x) => x)),
        pastSchoolingReports: json["pastSchoolingReports"] == null
            ? []
            : List<dynamic>.from(json["pastSchoolingReports"]!.map((x) => x)),
        studentRemoteAccesses: json["studentRemoteAccesses"] == null
            ? []
            : List<dynamic>.from(json["studentRemoteAccesses"]!.map((x) => x)),
        studentTcDetails: json["studentTcDetails"] == null
            ? []
            : List<dynamic>.from(json["studentTcDetails"]!.map((x) => x)),
        tcFeeDetails: json["tcFeeDetails"] == null
            ? []
            : List<dynamic>.from(json["tcFeeDetails"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "studentId": studentId,
        "applicationNumber": applicationNumber,
        "uin": uin,
        "date": date,
        "name": name,
        "class": datumClass,
        "section": section,
        "gender": gender,
        "ageInWords": ageInWords,
        "dob": dob,
        "pob": pob,
        "nationality": nationality,
        "religion": religion,
        "motherTongue": motherTongue,
        "category": category,
        "bloodGroup": bloodGroup,
        "medicalHistory": medicalHistory,
        "hobbies": hobbies,
        "sports": sports,
        "otherDetails": otherDetails,
        "profileAvatar": profileAvatar,
        "addedDate": addedDate?.toIso8601String(),
        "modifiedDate": modifiedDate?.toIso8601String(),
        "ip": ip,
        "userId": userId,
        "isDeleted": isDeleted,
        "createBy": createBy,
        "currentYear": currentYear,
        "insertBy": insertBy,
        "markForIdentity": markForIdentity,
        "otherLanguages": otherLanguages,
        "medium": medium,
        "caste": caste,
        "rte": rte,
        "adharNo": adharNo,
        "adharFile": adharFile,
        "batchName": batchName,
        "isApplyforTc": isApplyforTc,
        "isApplyforAdmission": isApplyforAdmission,
        "isApprove": isApprove,
        "isActive": isActive,
        "isInsertFromAd": isInsertFromAd,
        "isAdmissionPaid": isAdmissionPaid,
        "regNumber": regNumber,
        "classId": classId,
        "categoryId": categoryId,
        "batchId": batchId,
        "parentEmail": parentEmail,
        "admissionFeePaid": admissionFeePaid,
        "lastName": lastName,
        "transport": transport,
        "transportOptions": transportOptions,
        "mobile": mobile,
        "city": city,
        "state": state,
        "pincode": pincode,
        "bloodGroupId": bloodGroupId,
        "isPromoted": isPromoted,
        "sectionId": sectionId,
        "rollNo": rollNo,
        "scholarNo": scholarNo,
        "additionalInformations": additionalInformations == null
            ? []
            : List<dynamic>.from(additionalInformations!.map((x) => x)),
        "guardianDetails": guardianDetails == null
            ? []
            : List<dynamic>.from(guardianDetails!.map((x) => x)),
        "pastSchoolingReports": pastSchoolingReports == null
            ? []
            : List<dynamic>.from(pastSchoolingReports!.map((x) => x)),
        "studentRemoteAccesses": studentRemoteAccesses == null
            ? []
            : List<dynamic>.from(studentRemoteAccesses!.map((x) => x)),
        "studentTcDetails": studentTcDetails == null
            ? []
            : List<dynamic>.from(studentTcDetails!.map((x) => x)),
        "tcFeeDetails": tcFeeDetails == null
            ? []
            : List<dynamic>.from(tcFeeDetails!.map((x) => x)),
      };
}
