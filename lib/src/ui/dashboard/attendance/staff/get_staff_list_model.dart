class GetStaffListModel {
  GetStaffListModel({
      this.data, 
      this.msg, 
      this.responseCode, 
      this.additionalData,});

  GetStaffListModel.fromJson(dynamic json) {
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
      this.stafId, 
      this.uin, 
      this.date, 
      this.name, 
      this.gender, 
      this.ageInWords, 
      this.dob, 
      this.pob, 
      this.nationality, 
      this.religion, 
      this.qualification, 
      this.workExperience, 
      this.motherTongue, 
      this.category, 
      this.bloodGroup, 
      this.medicalHistory, 
      this.address, 
      this.contact, 
      this.email, 
      this.besicSallery, 
      this.perksSallery, 
      this.grossSallery, 
      this.lastOrganizationofEmployment, 
      this.noofYearsattheLastAssignment, 
      this.relievingLetter, 
      this.performanceLetter, 
      this.file, 
      this.otherDetails, 
      this.empId, 
      this.otherLanguages, 
      this.empDate, 
      this.formalitiesCheck, 
      this.addedDate, 
      this.modifiedDate, 
      this.currentYear, 
      this.ip, 
      this.userId, 
      this.isDeleted, 
      this.createBy, 
      this.insertBy, 
      this.designation, 
      this.fatherOrHusbandName, 
      this.mothersName, 
      this.mariedStatus, 
      this.children, 
      this.besicSallery1, 
      this.perksSallery1, 
      this.grossSallery1, 
      this.caste, 
      this.dateofReliving, 
      this.adharNo, 
      this.adharFile, 
      this.panNo, 
      this.panFile, 
      this.staffSignatureFile, 
      this.bankAcno, 
      this.batchName, 
      this.employeeCode, 
      this.bankName, 
      this.accountNo, 
      this.ifscCode, 
      this.employeeDesignation, 
      this.employeeAccountId, 
      this.employeeAccountName, 
      this.categoryId, 
      this.staffCategoryName, 
      this.uan,});

  Data.fromJson(dynamic json) {
    stafId = json['stafId'];
    uin = json['uin'];
    date = json['date'];
    name = json['name'];
    gender = json['gender'];
    ageInWords = json['ageInWords'];
    dob = json['dob'];
    pob = json['pob'];
    nationality = json['nationality'];
    religion = json['religion'];
    qualification = json['qualification'];
    workExperience = json['workExperience'];
    motherTongue = json['motherTongue'];
    category = json['category'];
    bloodGroup = json['bloodGroup'];
    medicalHistory = json['medicalHistory'];
    address = json['address'];
    contact = json['contact'];
    email = json['email'];
    besicSallery = json['besicSallery'];
    perksSallery = json['perksSallery'];
    grossSallery = json['grossSallery'];
    lastOrganizationofEmployment = json['lastOrganizationofEmployment'];
    noofYearsattheLastAssignment = json['noofYearsattheLastAssignment'];
    relievingLetter = json['relievingLetter'];
    performanceLetter = json['performanceLetter'];
    file = json['file'];
    otherDetails = json['otherDetails'];
    empId = json['empId'];
    otherLanguages = json['otherLanguages'];
    empDate = json['empDate'];
    formalitiesCheck = json['formalitiesCheck'];
    addedDate = json['addedDate'];
    modifiedDate = json['modifiedDate'];
    currentYear = json['currentYear'];
    ip = json['ip'];
    userId = json['userId'];
    isDeleted = json['isDeleted'];
    createBy = json['createBy'];
    insertBy = json['insertBy'];
    designation = json['designation'];
    fatherOrHusbandName = json['fatherOrHusbandName'];
    mothersName = json['mothersName'];
    mariedStatus = json['mariedStatus'];
    children = json['children'];
    besicSallery1 = json['besicSallery1'];
    perksSallery1 = json['perksSallery1'];
    grossSallery1 = json['grossSallery1'];
    caste = json['caste'];
    dateofReliving = json['dateofReliving'];
    adharNo = json['adharNo'];
    adharFile = json['adharFile'];
    panNo = json['panNo'];
    panFile = json['panFile'];
    staffSignatureFile = json['staffSignatureFile'];
    bankAcno = json['bankAcno'];
    batchName = json['batchName'];
    employeeCode = json['employeeCode'];
    bankName = json['bankName'];
    accountNo = json['accountNo'];
    ifscCode = json['ifscCode'];
    employeeDesignation = json['employeeDesignation'];
    employeeAccountId = json['employeeAccountId'];
    employeeAccountName = json['employeeAccountName'];
    categoryId = json['categoryId'];
    staffCategoryName = json['staffCategoryName'];
    uan = json['uan'];
  }
  num? stafId;
  String? uin;
  dynamic date;
  String? name;
  String? gender;
  num? ageInWords;
  String? dob;
  dynamic pob;
  dynamic nationality;
  dynamic religion;
  String? qualification;
  String? workExperience;
  dynamic motherTongue;
  dynamic category;
  dynamic bloodGroup;
  dynamic medicalHistory;
  dynamic address;
  String? contact;
  String? email;
  dynamic besicSallery;
  dynamic perksSallery;
  dynamic grossSallery;
  String? lastOrganizationofEmployment;
  String? noofYearsattheLastAssignment;
  dynamic relievingLetter;
  dynamic performanceLetter;
  dynamic file;
  dynamic otherDetails;
  String? empId;
  dynamic otherLanguages;
  dynamic empDate;
  String? formalitiesCheck;
  String? addedDate;
  String? modifiedDate;
  num? currentYear;
  String? ip;
  String? userId;
  bool? isDeleted;
  num? createBy;
  dynamic insertBy;
  dynamic designation;
  String? fatherOrHusbandName;
  dynamic mothersName;
  String? mariedStatus;
  String? children;
  dynamic besicSallery1;
  dynamic perksSallery1;
  dynamic grossSallery1;
  dynamic caste;
  dynamic dateofReliving;
  String? adharNo;
  dynamic adharFile;
  String? panNo;
  dynamic panFile;
  dynamic staffSignatureFile;
  dynamic bankAcno;
  dynamic batchName;
  dynamic employeeCode;
  dynamic bankName;
  dynamic accountNo;
  dynamic ifscCode;
  String? employeeDesignation;
  num? employeeAccountId;
  dynamic employeeAccountName;
  num? categoryId;
  dynamic staffCategoryName;
  dynamic uan;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['stafId'] = stafId;
    map['uin'] = uin;
    map['date'] = date;
    map['name'] = name;
    map['gender'] = gender;
    map['ageInWords'] = ageInWords;
    map['dob'] = dob;
    map['pob'] = pob;
    map['nationality'] = nationality;
    map['religion'] = religion;
    map['qualification'] = qualification;
    map['workExperience'] = workExperience;
    map['motherTongue'] = motherTongue;
    map['category'] = category;
    map['bloodGroup'] = bloodGroup;
    map['medicalHistory'] = medicalHistory;
    map['address'] = address;
    map['contact'] = contact;
    map['email'] = email;
    map['besicSallery'] = besicSallery;
    map['perksSallery'] = perksSallery;
    map['grossSallery'] = grossSallery;
    map['lastOrganizationofEmployment'] = lastOrganizationofEmployment;
    map['noofYearsattheLastAssignment'] = noofYearsattheLastAssignment;
    map['relievingLetter'] = relievingLetter;
    map['performanceLetter'] = performanceLetter;
    map['file'] = file;
    map['otherDetails'] = otherDetails;
    map['empId'] = empId;
    map['otherLanguages'] = otherLanguages;
    map['empDate'] = empDate;
    map['formalitiesCheck'] = formalitiesCheck;
    map['addedDate'] = addedDate;
    map['modifiedDate'] = modifiedDate;
    map['currentYear'] = currentYear;
    map['ip'] = ip;
    map['userId'] = userId;
    map['isDeleted'] = isDeleted;
    map['createBy'] = createBy;
    map['insertBy'] = insertBy;
    map['designation'] = designation;
    map['fatherOrHusbandName'] = fatherOrHusbandName;
    map['mothersName'] = mothersName;
    map['mariedStatus'] = mariedStatus;
    map['children'] = children;
    map['besicSallery1'] = besicSallery1;
    map['perksSallery1'] = perksSallery1;
    map['grossSallery1'] = grossSallery1;
    map['caste'] = caste;
    map['dateofReliving'] = dateofReliving;
    map['adharNo'] = adharNo;
    map['adharFile'] = adharFile;
    map['panNo'] = panNo;
    map['panFile'] = panFile;
    map['staffSignatureFile'] = staffSignatureFile;
    map['bankAcno'] = bankAcno;
    map['batchName'] = batchName;
    map['employeeCode'] = employeeCode;
    map['bankName'] = bankName;
    map['accountNo'] = accountNo;
    map['ifscCode'] = ifscCode;
    map['employeeDesignation'] = employeeDesignation;
    map['employeeAccountId'] = employeeAccountId;
    map['employeeAccountName'] = employeeAccountName;
    map['categoryId'] = categoryId;
    map['staffCategoryName'] = staffCategoryName;
    map['uan'] = uan;
    return map;
  }

}