
import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

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
}