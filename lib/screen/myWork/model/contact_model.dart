import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:upen/screen/profile/personalDetails/personalDetailController.dart';

class UserContactModel {
  String mobile;
  String email;
  String city;
  String state;
  String name;
  String secondNumber;
  String assignedTo;
  bool status;
  String key;
  String zip;
  String designation;
  String leadResult;
  String leadType;
  String existingBank;
  String cardLimit;
  String appliedBank;
  String comment;
  String itr;
  String salary;
  bool isCalled;
  String callDate;
  Timestamp testCallDate;
  List<UserContactModel1> userData;
  bool isEnabled;
  String application;






  UserContactModel(
      {this.mobile,
        this.email,
        this.city,
        this.state,
        this.name,
        this.secondNumber,
        this.assignedTo,
        this.status,
        this.zip,
        this.designation,
        this.comment,
        this.leadType,
        this.salary,
        this.application,
        this.itr,
        this.cardLimit,
        this.appliedBank,
        this.existingBank,
        this.leadResult,
      this.key,
      this.isCalled,
      this.callDate,
      this.testCallDate,
        this.userData,
        this.isEnabled,

       });

  UserContactModel.fromJson(Map<String, dynamic> json) {
    mobile = json['mobile'].toString();
    email = json['email'];
    city = json['city'];
    state = json['state'];
    name = json['name'];
    secondNumber = json['second_number'];
    assignedTo = json['assigned_to'];
    status = json['status'];
    key = json['key'];
    zip = json['zip'].toString();
    designation = json['designation'];
    leadType =json['leadType'];
    salary =json['salary'];
    itr =json['itr'];
    cardLimit =json['cardLimit'];
    appliedBank =json['appliedBank'];
    existingBank =json['existingBank'];
    leadResult =json['leadResult'];
    comment =json['comment'];
    isCalled = json['isCalled'];
    callDate = json['callDate'];
    isEnabled = json['isEnabled'];
    testCallDate = json['testCallDate'];
    application = json['application'];
    if (json['UserContactModel1'] != null) {
      userData = new List<UserContactModel1>();
      json['UserContactModel1'].forEach((v) {
        userData.add( UserContactModel1.fromJson(v));
      });
    }


  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['mobile'] = this.mobile;
    data['email'] = this.email;
    data['city'] = this.city;
    data['state'] = this.state;
    data['name'] = this.name;
    data['second_number'] = this.secondNumber;
    data['assigned_to'] = this.assignedTo;
    data['status'] = this.status;
    data['key'] = this.key;
    data['zip'] = this.zip;
    data['comment'] = this.comment;
    data['leadResult'] = this.leadResult;
    data['existingBank'] = this.existingBank;
    data['appliedBank'] = this.appliedBank;
    data['cardLimit'] = this.cardLimit;
    data['itr'] = this.itr;
    data['salary'] = this.salary;
    data['leadType'] = this.leadType;
    data['isCalled'] = this.isCalled;
    data['callDate'] = this.callDate;
    data['testCallDate'] = this.testCallDate;
    data['isEnabled'] = this.isEnabled;
    data['application'] = this.application;
    return data;
  }


}

class UserContactModel1 {
  String mobile;
  String email;
  String city;
  String state;
  String name;
  String secondNumber;
  String assignedTo;
  bool status;
  String key;
  String zip;
  String designation;
  String leadResult;
  String leadType;
  String existingBank;
  String cardLimit;
  String appliedBank;
  String comment;
  String itr;
  String salary;
  bool isCalled;
  String callDate;
  Timestamp testCallDate;
  bool isEnabled;
  String application;





  UserContactModel1(
      {this.mobile,
        this.email,
        this.city,
        this.state,
        this.name,
        this.secondNumber,
        this.assignedTo,
        this.status,
        this.zip,
        this.designation,
        this.comment,
        this.leadType,
        this.salary,
        this.itr,
        this.cardLimit,
        this.appliedBank,
        this.existingBank,
        this.leadResult,
        this.key,
        this.isCalled,
        this.callDate,
        this.testCallDate,
        this.isEnabled,
        this.application
      });

  UserContactModel1.fromJson(Map<String, dynamic> json) {
    mobile = json['mobile'].toString();
    email = json['email'];
    city = json['city'];
    state = json['state'];
    name = json['name'];
    secondNumber = json['second_number'];
    assignedTo = json['assigned_to'];
    status = json['status'];
    key = json['key'];
    zip = json['zip'].toString();
    designation = json['designation'];
    leadType =json['leadType'];
    salary =json['salary'];
    itr =json['itr'];
    cardLimit =json['cardLimit'];
    appliedBank =json['appliedBank'];
    existingBank =json['existingBank'];
    leadResult =json['leadResult'];
    comment =json['comment'];
    isCalled = json['isCalled'];
    callDate = json['callDate'];
    testCallDate = json['testCallDate'];
    isEnabled = json['isEnabled'];
    application = json['application'];


  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['mobile'] = this.mobile;
    data['email'] = this.email;
    data['city'] = this.city;
    data['state'] = this.state;
    data['name'] = this.name;
    data['second_number'] = this.secondNumber;
    data['assigned_to'] = this.assignedTo;
    data['status'] = this.status;
    data['key'] = this.key;
    data['zip'] = this.zip;
    data['comment'] = this.comment;
    data['leadResult'] = this.leadResult;
    data['existingBank'] = this.existingBank;
    data['appliedBank'] = this.appliedBank;
    data['cardLimit'] = this.cardLimit;
    data['itr'] = this.itr;
    data['salary'] = this.salary;
    data['leadType'] = this.leadType;
    data['isCalled'] = this.isCalled;
    data['callDate'] = this.callDate;
    data['testCallDate'] = this.testCallDate;
    data['isEnabled'] = this.isEnabled;
    data['application'] = this.application;
    return data;
  }


}





