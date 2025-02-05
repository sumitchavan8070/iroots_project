class GetSectionListModel {
  GetSectionListModel({
      this.data, 
      this.msg, 
      this.responseCode, 
      this.additionalData,});

  GetSectionListModel.fromJson(dynamic json) {
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(Data.fromJson(v));
      });
    }
    msg = json['msg'];
    responseCode = json['responseCode'];
    additionalData = json['additionalData'];
  }
  List<Data>? data;
  String? msg;
  String? responseCode;
  String? additionalData;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (data != null) {
      map['data'] = data?.map((v) => v.toJson()).toList();
    }
    map['msg'] = msg;
    map['responseCode'] = responseCode;
    map['additionalData'] = additionalData;
    return map;
  }

}

class Data {
  Data({
      this.dataListItemId, 
      this.dataListItemName, 
      this.dataListId, 
      this.dataListName, 
      this.status,});

  Data.fromJson(dynamic json) {
    dataListItemId = json['dataListItemId'];
    dataListItemName = json['dataListItemName'];
    dataListId = json['dataListId'];
    dataListName = json['dataListName'];
    status = json['status'];
  }
  num? dataListItemId;
  String? dataListItemName;
  String? dataListId;
  String? dataListName;
  String? status;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['dataListItemId'] = dataListItemId;
    map['dataListItemName'] = dataListItemName;
    map['dataListId'] = dataListId;
    map['dataListName'] = dataListName;
    map['status'] = status;
    return map;
  }

}