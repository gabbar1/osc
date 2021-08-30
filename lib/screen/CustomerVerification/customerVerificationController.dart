
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:upen/commonWidget/loader.dart';
import 'package:upen/screen/CustomerVerification/loadModel.dart';
import 'package:upen/screen/dashBoard/homeNavigator.dart';

class CustomerVerificationController extends GetxController{

  TextEditingController phoneValueController = TextEditingController();
  TextEditingController panController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController pinCodeController = TextEditingController();
  TextEditingController existingLoanController = TextEditingController();
  TextEditingController monthlyEmiController = TextEditingController();
  TextEditingController monthlySalaryController = TextEditingController();
  TextEditingController companyNameController = TextEditingController();
  TextEditingController designationController = TextEditingController();
  TextEditingController officeEmailController = TextEditingController();
  TextEditingController officeAddressController = TextEditingController();
  TextEditingController officePinCodeController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController cityController = TextEditingController();
//  TextEditingController odbController = TextEditingController();
  TextEditingController firmNameController = TextEditingController();
  TextEditingController itrController = TextEditingController();
  TextEditingController officeCityController = TextEditingController();
  TextEditingController officeStateController = TextEditingController();
  TextEditingController expController = TextEditingController();
  var dobController = TextEditingController().obs;





  TextEditingController get getDonController =>  dobController.value;
  setDob(String textEditingController){
    print("--------------checkText---------------");
  //  print(textEditingController);
    this.dobController.value.text = textEditingController;
   // print(dobController.value.text);
    dobController.refresh();
    print(getDonController.text);

  }

  var verification = TextEditingController().obs;


  TextEditingController get getVerification => verification.value;

  setVerification(String val){
    verification.value.text = val.removeAllWhitespace.replaceAll(new RegExp(r'^[+]91+(?=.)'), '').replaceAll(new RegExp(r'^0+(?=.)'), '');
    verification.value.selection = verification.value.selection.copyWith(extentOffset: verification.value.text.length);
  }

  Future<void> askPermissions() async {
    PermissionStatus permissionStatus = await _getContactPermission();
    if (permissionStatus == PermissionStatus.granted) {

        try {
          final Contact contact = await ContactsService.openDeviceContactPicker();
          setVerification(contact.phones.first.value);

        } catch (e) {
          print(e.toString());
        }

    } else {
      _handleInvalidPermissions(permissionStatus);
    }
  }

  Future<PermissionStatus> _getContactPermission() async {
    PermissionStatus permission = await Permission.contacts.status;
    if (permission != PermissionStatus.granted &&
        permission != PermissionStatus.permanentlyDenied) {
      PermissionStatus permissionStatus = await Permission.contacts.request();
      return permissionStatus;
    } else {
      return permission;
    }
  }

  void _handleInvalidPermissions(PermissionStatus permissionStatus) {
    if (permissionStatus == PermissionStatus.denied) {
      final snackBar = SnackBar(content: Text('Access to contact data denied'));
      ScaffoldMessenger.of(Get.context).showSnackBar(snackBar);
    } else if (permissionStatus == PermissionStatus.permanentlyDenied) {
      final snackBar =
      SnackBar(content: Text('Contact data not available on device'));
      ScaffoldMessenger.of(Get.context).showSnackBar(snackBar);
    }
  }

  Future<void> checkEligibility({SubmitLoadModel submitLoadModel}) async{

    showLoader();


    FirebaseFirestore.instance.collection("leads").doc(FirebaseAuth.instance.currentUser.phoneNumber.replaceAll("+91", "")).collection(FirebaseAuth.instance.currentUser.phoneNumber.replaceAll("+91", "")).add(
        {
          "backend_comment":"no comments",
          "create_date":DateTime.now().toString(),
        "salary":submitLoadModel.salary,
          "Company_Name":submitLoadModel.cName,
          "designation":submitLoadModel.designation,"experience":submitLoadModel.exp,"Company_Email":submitLoadModel.cEmail,"Company_Address":submitLoadModel.cAdd,"Company_State":submitLoadModel.cState,"Company_City":submitLoadModel.cCity,"Company_Pincode":submitLoadModel.cPincode,
         "mobile":submitLoadModel.loanModel.mobile,
         "name":submitLoadModel.loanModel.name,
        "email":submitLoadModel.loanModel.email,
        "dob":submitLoadModel.loanModel.dob,
        "address":submitLoadModel.loanModel.address,
        "state":submitLoadModel.loanModel.state,
        "city":submitLoadModel.loanModel.city,
        "pincode":submitLoadModel.loanModel.pincode,
          "bankChoice":"no preference",
          "status":"pending",
          "leadType":submitLoadModel.loanModel.loanType
        }).then((value) {
          closeLoader();
      Get.offAll(HomeNavigator(),duration: Duration(seconds: 1),fullscreenDialog: true);
      Get.snackbar("Done", "Thank you for submitting the application we will review and update you soon",backgroundColor: Colors.amber);
    }).onError((error, stackTrace) {
      closeLoader();
      Get.snackbar("Error", error.toString(), backgroundColor: Colors.amber);
    });
  }
}