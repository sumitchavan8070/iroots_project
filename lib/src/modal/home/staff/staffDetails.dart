// To parse this JSON data, do
//
//     final staffDetailsModal = staffDetailsModalFromMap(jsonString);

import 'dart:convert';

StaffDetailsModal staffDetailsModalFromMap(String str) =>
    StaffDetailsModal.fromMap(json.decode(str));

String staffDetailsModalToMap(StaffDetailsModal data) =>
    json.encode(data.toMap());

class StaffDetailsModal {
  List<StaffDetail>? data;
  String? msg;
  String? responseCode;

  StaffDetailsModal({
    this.data,
    this.msg,
    this.responseCode,
  });

  factory StaffDetailsModal.fromMap(Map<String, dynamic> json) =>
      StaffDetailsModal(
        data: json["data"] != null
            ? List<StaffDetail>.from(
                json["data"].map((x) => StaffDetail.fromMap(x)))
            : [],
        msg: (json['msg'] ?? "").toString(),
        responseCode: (json['responseCode'] ?? "").toString(),
      );

  Map<String, dynamic> toMap() => {
        "data": List<dynamic>.from(data!.map((x) => x.toMap())),
        "msg": msg,
        "responseCode": responseCode,
      };
}

class StaffDetail {
  String? staffid;
  String? userId;
  String? email;
  String? address;
  String? name;
  String? avatar;

  StaffDetail({
    this.staffid,
    this.userId,
    this.email,
    this.address,
    this.name,
    this.avatar,
  });

  factory StaffDetail.fromMap(Map<String, dynamic> json) => StaffDetail(
        staffid: (json["staffid"] ?? "").toString(),
        userId: (json["userId"] ?? "").toString(),
        email: (json["email"] ?? "").toString(),
        address: (json["address"] ?? "").toString(),
        name: (json["name"] ?? "").toString(),
        avatar: (json["avatar"] ?? "").toString(),
      );

  Map<String, dynamic> toMap() => {
        "staffid": staffid,
        "userId": userId,
        "email": email,
        "address": address,
        "name": name,
        "avatar": avatar,
      };
}
