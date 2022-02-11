import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:excel/excel.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'package:path_provider/path_provider.dart';
import 'package:upen/commonWidget/loader.dart';
import 'package:upen/screen/helper/constant.dart';

import '../model/contact_model.dart';


class MyWorkController extends GetxController{

  TextEditingController salaryController =TextEditingController();
  TextEditingController businessController =TextEditingController();
  TextEditingController c2cController =TextEditingController();
  TextEditingController nameController =TextEditingController();
  TextEditingController emailController =TextEditingController();
  TextEditingController designationController =TextEditingController();
  TextEditingController stateController =TextEditingController();
  TextEditingController zipController =TextEditingController();
  TextEditingController phoneController =TextEditingController();
  TextEditingController cityController =TextEditingController();
  TextEditingController commentController =TextEditingController();
  TextEditingController textEditingController = TextEditingController();
  TextEditingController searchByCityController = TextEditingController();
  TextEditingController searchLimitController = TextEditingController();
  TextEditingController searchByStateController = TextEditingController();
  TextEditingController applicationController = TextEditingController();
  var contactList = <UserContactModel>[].obs;
  var historyLeadList = <UserContactModel>[].obs;
  setHistoryLeadList(UserContactModel val){
    historyLeadList.value.add(val);
    historyLeadList.refresh();
  }

  clearText(){
    salaryController.clear();
    businessController.clear();
    c2cController.clear();
    nameController.clear();
    phoneController.clear();
    zipController.clear();
    designationController.clear();
    cityController.clear();
    stateController.clear();
    commentController.clear();
  }

  List<UserContactModel> get getContacts=> contactList.value;
  List<UserContactModel> get getHistoryLeadList=> historyLeadList.value;
  var key = "".obs;
  String get getKey => key.value;
  setKey( String val){
    key.value = val;
    key.refresh();
  }
  Future<void> getContactList({String status = "dashboard"})async{
    contactList.value.clear();
    try {

      FirebaseFirestore.instance
          .collection("contactData").where("assigned_to",isEqualTo: FirebaseAuth.instance.currentUser.phoneNumber.replaceAll("+91", ""))
          .get()
          .then((QuerySnapshot querySnapshot) {


        querySnapshot.docs.forEach((element) {


          UserContactModel _userContactModel = UserContactModel.fromJson(element.data());
          _userContactModel.key = element.id;
          if(status == "new_number")
          {
            if(_userContactModel.isCalled==null){
              setContactList(_userContactModel);
            }
          }
         else if(status == "dashboard"){
            setContactList(_userContactModel);
          }
        });
      });
    } catch (exception) {
      throw exception;
    }
  }
  Future<void> getHistoryLeadLists({String status = "dashboard"})async{
    historyLeadList.value.clear();
    try {

      FirebaseFirestore.instance
          .collection("contactData").where("assigned_to",isEqualTo: FirebaseAuth.instance.currentUser.phoneNumber.replaceAll("+91", ""))
          .get()
          .then((QuerySnapshot querySnapshot) {


        querySnapshot.docs.forEach((element) {


          UserContactModel _userContactModel = UserContactModel.fromJson(element.data());
          _userContactModel.key = element.id;
           if(status == "rejected_by_day_number"){
            print("---------------rejected---------------");
            print(_userContactModel.leadResult);
            if(_userContactModel.isCalled!=null &&_userContactModel.leadResult == "StatusCharacter.b" && DateTime.parse(DateTime.now().toString().substring(0, 10)).difference(DateTime.parse(_userContactModel.callDate.substring(0, 10))).inHours<24 ){
              setHistoryLeadList(_userContactModel);
            }
          }
          else if(status == "accepted_by_day_number"){
           if(_userContactModel.isCalled!=null &&_userContactModel.leadResult == "StatusCharacter.a" && DateTime.parse(DateTime.now().toString().substring(0, 10)).difference(DateTime.parse(_userContactModel.callDate.substring(0, 10))).inHours<24 ){
             setHistoryLeadList(_userContactModel);
          }
          }
          else if(status == "calling_by_day_number"){
            print(_userContactModel.isCalled==null);
           if(_userContactModel.isCalled!=null &&_userContactModel.isCalled!=null && _userContactModel.isCalled &&  DateTime.parse(DateTime.now().toString().substring(0, 10)).difference(DateTime.parse(_userContactModel.callDate.substring(0, 10))).inHours<24){
             setHistoryLeadList(_userContactModel);
          }
          }
          else if(status == "query_by_day_number"){
            if(_userContactModel.isCalled!=null &&_userContactModel.leadResult == "StatusCharacter.c" && DateTime.now().difference(DateTime.parse(_userContactModel.callDate)).inHours<24 ){
              setHistoryLeadList(_userContactModel);
            }
          }
          else if(status == "login_by_day_number"){
            if(_userContactModel.isCalled!=null &&_userContactModel.leadResult == "StatusCharacter.f" && DateTime.parse(DateTime.now().toString().substring(0, 10)).difference(DateTime.parse(_userContactModel.callDate.substring(0, 10))).inHours<24 ){
              setHistoryLeadList(_userContactModel);
            }
          }
          else if(status == "rejected_by_month_number"){
            print("---------------rejected---------------");
            print(_userContactModel.leadResult);
            if(_userContactModel.isCalled!=null &&_userContactModel.leadResult == "StatusCharacter.b" && DateTime.parse(DateTime.now().toString().substring(0, 10)).difference(DateTime.parse(_userContactModel.callDate.substring(0, 10))).inDays<30 ){
              setHistoryLeadList(_userContactModel);
            }
          }else if(status == "accepted_by_month_number"){
            if(_userContactModel.isCalled!=null &&_userContactModel.leadResult == "StatusCharacter.a" && DateTime.parse(DateTime.now().toString().substring(0, 10)).difference(DateTime.parse(_userContactModel.callDate.substring(0, 10))).inDays<30 ){
              setHistoryLeadList(_userContactModel);
            }
          }
          else if(status == "query_by_month_number"){
            if(_userContactModel.isCalled!=null &&_userContactModel.leadResult == "StatusCharacter.c" && DateTime.now().difference(DateTime.parse(_userContactModel.callDate)).inDays<30 ){
              setHistoryLeadList(_userContactModel);
            }
          }
          else if(status == "login_by_month_number"){
            if(_userContactModel.isCalled!=null &&_userContactModel.leadResult == "StatusCharacter.f" && DateTime.parse(DateTime.now().toString().substring(0, 10)).difference(DateTime.parse(_userContactModel.callDate.substring(0, 10))).inDays<30 ){
              setHistoryLeadList(_userContactModel);
            }
          }
          else if(_userContactModel.isCalled!=null && status == "calling_by_month_number" && DateTime.parse(DateTime.now().toString().substring(0, 10)).difference(DateTime.parse(_userContactModel.callDate.substring(0, 10))).inDays<30){
            if(_userContactModel.isCalled!=null &&_userContactModel.isCalled ){
              setHistoryLeadList(_userContactModel);
            }
          }
          else if(status == "dashboard"){
             setHistoryLeadList(_userContactModel);
          }



        });
      });
    } catch (exception) {
      throw exception;
    }
  }


  setContactList(UserContactModel val){
    contactList.value.add(val);
    contactList.refresh();
  }


  var userList = <UserContactModel>[].obs;
  List<UserContactModel> get getUsersList => userList.value;
  setUser(UserContactModel userContactModel){
    userList.value.add(userContactModel);
    userList.refresh();
  }

  Future<void> getUserList()async{
    userList.value.clear();
    try {


      FirebaseFirestore.instance
          .collection("user_details").get()
          .then((QuerySnapshot querySnapshot) {

        querySnapshot.docs.forEach((element) {
          print("----------------CheckElement----------------");
         // print(element["advisor_phone_number"]);

          UserContactModel _user = UserContactModel(name:element["advisor_name"] ,mobile: element["advisor_phone_number"],isEnabled: element["isEnabled"]);
          setUser(_user);


        });
      });
    } catch (exception) {
      throw exception;
    }
  }

  var updateLeadList = <UserContactModel>[].obs;
  List<UserContactModel> get getUpdateLeadList => updateLeadList.value;
  setLead(UserContactModel val){
    print("-------------------------");
    updateLeadList.value.add(val);
    updateLeadList.refresh();
  }
  Future<void> updateData({String name,mobile}){

    showLoader();
    int count =0;

    print(jsonEncode(getContactCategoryList));

    getContactCategoryList.forEach((element) {
      print("====================================================");
      print(mobile);
      print(name);
      print(element.key);
      FirebaseFirestore.instance
          .collection("contactData").doc(element.key).update({
        "city":element.city,
        "state":element.state,
        "status":true,
        "zip":element.zip,
        "designation":element.designation,
        "name":element.name,
        "mobile":element.mobile,
        "email":element.email,
        "assigned_to":mobile
      }).then((value) {
        count = count +1;
        print("=======================");
        print(count);
        print(getContactCategoryList.length);
        if(count==getContactCategoryList.length){
          closeLoader();
          Get.snackbar("Success", "Phone Number assigned to ${name}");
        }

      }).onError((error, stackTrace){
        closeLoader();
        Get.snackbar("Error", error.toString());
      });
    });

    //Navigator.pop(Get.context);

  }

  Future<void> UpdateLead(UserContactModel userContactModel,{bool isUpdate=true,String status,int index})async{

    try {
      showLoader();
      if(isUpdate){
        print("======================isUpdate=============l");
        print(userContactModel.toJson());
        FirebaseFirestore.instance
            .collection("contactData").doc(userContactModel.key).update(userContactModel.toJson()).then((value) {
          closeLoader();
          //getContactList(status: status);
          Navigator.pop(Get.context);
          Get.snackbar("Success", "Status Updated",backgroundColor: Constants().mainColor);
          removeIndexValue(index,status);
        }).onError((error, stackTrace) {
          closeLoader();
          print("================eorr------------");
          print(stackTrace.toString());
          Get.snackbar("Error", error.toString(),backgroundColor: Constants().mainColor);

        });
      }
      else{
        FirebaseFirestore.instance.collection("contactData").add(userContactModel.toJson()).then((value) {
          closeLoader();
          getContactList(status: status);
          Navigator.pop(Get.context);
          Get.snackbar("Success", "Status Updated",backgroundColor: Constants().mainColor);
        }).onError((error, stackTrace) {
          closeLoader();
          Get.snackbar("Error", error.toString(),backgroundColor: Constants().mainColor);
        });
      }

    } catch (exception) {
      throw exception;
    }
  }

  var contacCategoryList = <UserContactModel>[].obs;
  List<UserContactModel> get getContactCategoryList => contacCategoryList.value;
  setContactCategoryListList(UserContactModel val) {
    contacCategoryList.value.add(val);
    // keyList.value.toSet();
    // print(keyList.value);
    contacCategoryList.refresh();

  }
  var unAssignList = <UserContactModel>[].obs;
  List<UserContactModel> get getUnAssignListList => unAssignList.value;
  setUnAssignListList(UserContactModel val) {
    unAssignList.value.add(val);
    unAssignList.refresh();

  }
  getSearchList({String searchType, searchKey,int limit}){
    contacCategoryList.clear();
    print(searchType);
    print(searchKey);
 try{
   showLoader();
   if(getSelectedVersion.isEmpty ||getSelectedVersion == "1_no_filter"){
     FirebaseFirestore.instance.collection('contactData').where("status",isEqualTo: false).where(searchType,isGreaterThanOrEqualTo: searchKey.toString().capitalize).where(searchType,isLessThanOrEqualTo: searchKey.toString().capitalize).limit(limit).get().then((value) {
       print("-------------------------empty----------------");
       value.docs.forEach((element) {
         print(element.data());
         UserContactModel contactModel = UserContactModel.fromJson(element.data());
         print(jsonEncode(contactModel));
         contactModel.key = element.id;
         setContactCategoryListList(contactModel);
       });
      // print(jsonEncode(getContactCategoryList));

     }).then((value) {
       closeLoader();
     });
   }
   else {
     print(getSelectedVersion);
     FirebaseFirestore.instance.collection('contactData').where("status",isEqualTo: false).where("version",isEqualTo:getSelectedVersion ).where(searchType,isGreaterThanOrEqualTo: searchKey.toString().capitalize).where(searchType,isLessThanOrEqualTo: searchKey.toString().capitalize).limit(limit).get().then((value) {
       print("-------------------------List----------------");

       value.docs.forEach((element) {
         print(element.data());
         UserContactModel contactModel = UserContactModel.fromJson(element.data());
         contactModel.key = element.id;
         setContactCategoryListList(contactModel);
       });

     }).then((value) {
       closeLoader();
     });
   }
 }catch(e){
   closeLoader();
   Get.snackbar("Error", e.toString());
   throw e;
 }


  }

  getUnAssignList({String mobile, searchKey}){

    unAssignList.clear();

    FirebaseFirestore.instance.collection('contactData').where("assigned_to",isEqualTo: mobile).get().then((value) {
      value.docs.forEach((element) {
        UserContactModel contactModel = UserContactModel.fromJson(element.data());
        contactModel.key = element.id;
        contactModel.status =false;
        contactModel.assignedTo =null;
        if(contactModel.isCalled==null){
          setUnAssignListList(contactModel);
        }
      });
    });

  }

  UnAssignContactList(){
    showLoader();
    getUnAssignListList.forEach((element) {
      FirebaseFirestore.instance.collection('contactData').doc(element.key).update(element.toJson());
    });
    closeLoader();


  }

  var jsonMap = [].obs;
  List<dynamic> get getJsonMap => jsonMap.value;

  setJsonMap(var data){
    jsonMap.value.add(data);
    jsonMap.refresh();
  }
  Future<List<dynamic>> excelToJson() async {

   try{
      FilePickerResult result =await FilePicker.platform.pickFiles(type:FileType.custom,allowedExtensions: ['xls','xlsx','csv']);
      if (result != null) {
        File excelFile = File(result.files.single.path);
      }

      var bytes = File(result.files.single.path).readAsBytesSync();
      var excel = Excel.decodeBytes(bytes);
      int i = 0;
      int count =0;


      var keys = [];

      for (var table in excel.tables.keys) {

        for (var row in excel.tables[table].rows) {



          if (i == 0) {
            row.forEach((element) {
              keys.add(element.value);
            });
            //keys = row;
            print(keys);

            i++;
          }
          else {
            count = count+1;
            var temp = {};
            var temp1 ={} ;
            int j = 0;
            String tk = '';
            for (var key in keys) {
              tk = '${key.toString()}';
              temp[tk] = (row[j].runtimeType == String) ?  '\"${row[j].value.toString()}\"' : row[j] == null ? "NA ":row[j].value=="false"? false:row[j].value;


              // print(temp1);

              j++;
            }

            temp1['\"${count.toString()}\"'] =temp;
            setJsonMap(temp);

          }

        }

      }
      return getJsonMap;
    }catch(exception){
      closeLoader();
      Get.snackbar("Error", exception.toString());
      throw exception;
   }

  }

  Future<void> uploadData()async{
    try{
     jsonMap.value.clear();
      var jsonData =await excelToJson();

      print("json-------------------------------------------------------");
      print(jsonData);

     int cnd =0;

     showLoader(isLoading: true);
      jsonData.forEach((element) {

      //  print(jsonData.length);
        print("------------------json---------");
       // print(jsonEncode(element));
        Map<String, dynamic> map = json.decode(jsonEncode(element));
        print(map);

        FirebaseFirestore.instance.collection("contactData").add(map).then((value) {
          cnd = cnd+1;
          if(jsonData.length ==cnd){
            closeLoader();
            Get.snackbar("Success", "Data Uploaded........",backgroundColor: Constants().mainColor);
          }



        }).onError((error, stackTrace) {
          closeLoader();
          Get.snackbar("Error", error.toString());
        });

      });

    }catch(exception){
      closeLoader();
      Get.snackbar("Error", exception.toString());
      throw exception;
    }


  }
  
  var versionData = <String>[].obs;
  List<String> get getVersionData => versionData.value;
  setVersionData(String val){
    versionData.value.add(val);
    versionData.refresh();
  }

  var selectedVersion = "".obs;
  String get getSelectedVersion => selectedVersion.value;
  setSelectedVersion(String val){
    selectedVersion.value = val;
    selectedVersion.refresh();
  }
  
  getVersion(){
    versionData.value.clear();
    FirebaseFirestore.instance.collection("contactCategory").get().then((value) {
      print("==============verasin==============");
      value.docs.forEach((element) {
        print(element.data().values.single);
        setVersionData(element.data().values.single);

      });
    });
  }

  updateList(){
    FirebaseFirestore.instance.collection("contactData").where("version",isEqualTo: "madhuri_new").get().then((value) {
      value.docs.forEach((element) {
        print(element.id);
        print(element.data());
        ResponseModel responseModel = ResponseModel.fromJson(element.data());
        if(responseModel.mobile.contains(".0")){
          print("==================================");
          FirebaseFirestore.instance.collection("contactData").doc(element.id).update({
            "mobile":responseModel.mobile.replaceAll(".0", "")
          }).then((value) {
            print("--------------------Updated------------------");
          }).onError((error, stackTrace) {
            print(error.toString());
          });
        }


      });
    });
  }

  void removeIndexValue(int index,String val) {
    print("================index==================");
    print(index);
    if(val == "new_number"){
      contactList.value.removeAt(index);
      contactList.refresh();
    }
  }

  var isPreventNewCalling = false.obs;
  bool get getIsPreventNewCalling => isPreventNewCalling.value;
  setIsPreventNewCalling(bool val){
    isPreventNewCalling.value = val;
    isPreventNewCalling.refresh();
  }

}




class ResponseModel {
  String profession;
  String zip;
  String lastName;
  String gender;
  String decision;
  String name;
  String mobile;
  String city;
  String state;
  String version;
  String email;
  String status;

  ResponseModel(
      {this.profession,
        this.zip,
        this.lastName,
        this.gender,
        this.decision,
        this.name,
        this.mobile,
        this.city,
        this.state,
        this.version,
        this.email,
        this.status});

  ResponseModel.fromJson(Map<String, dynamic> json) {
    profession = json['profession'].toString();
    zip = json['zip'].toString();
    lastName = json['last name'].toString();
    gender = json['gender'].toString();
    decision = json['decision'].toString();
    name = json['name'].toString();
    mobile = json['mobile'].toString();
    city = json['City'].toString();
    state = json['state'].toString();
    version = json['version'].toString();
    email = json['email'].toString();
    status = json['status'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['profession'] = this.profession;
    data['zip'] = this.zip;
    data['last name'] = this.lastName;
    data['gender'] = this.gender;
    data['decision'] = this.decision;
    data['name'] = this.name;
    data['mobile'] = this.mobile;
    data['City'] = this.city;
    data['state'] = this.state;
    data['version'] = this.version;
    data['email'] = this.email;
    data['status'] = this.status;
    return data;
  }
}

