class FeesDetailsModel {
  FeesDetailsModel({
      this.feeDetails, 
      this.totalAmount,});

  FeesDetailsModel.fromJson(dynamic json) {
    if (json['feeDetails'] != null) {
      feeDetails = [];
      json['feeDetails'].forEach((v) {
        feeDetails?.add(FeeDetails.fromJson(v));
      });
    }
    totalAmount = json['totalAmount'];
  }
  List<FeeDetails>? feeDetails;
  num? totalAmount;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (feeDetails != null) {
      map['feeDetails'] = feeDetails?.map((v) => v.toJson()).toList();
    }
    map['totalAmount'] = totalAmount;
    return map;
  }

}

class FeeDetails {
  FeeDetails({
      this.feeId, 
      this.feeName, 
      this.feeValue, 
      this.paidAmount, 
      this.balance,});

  FeeDetails.fromJson(dynamic json) {
    feeId = json['feeId'];
    feeName = json['feeName'];
    feeValue = json['feeValue'];
    paidAmount = json['paidAmount'];
    balance = json['balance'];
  }
  num? feeId;
  String? feeName;
  num? feeValue;
  num? paidAmount;
  num? balance;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['feeId'] = feeId;
    map['feeName'] = feeName;
    map['feeValue'] = feeValue;
    map['paidAmount'] = paidAmount;
    map['balance'] = balance;
    return map;
  }

}