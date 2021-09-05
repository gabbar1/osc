import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:upen/commonWidget/loader.dart';
import 'package:firebase_core/firebase_core.dart' as firebase_core;
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'dart:io' as io;

import 'bankDetailModel.dart';
class BankDetailsController extends GetxController{

var filePath = File("").obs;
File get getFilePath => filePath.value;
setFilePath(File val){
  filePath.value =val;
  filePath.refresh();
}

var bankNameController = TextEditingController().obs;
TextEditingController get getBankNameController => bankNameController.value;
var nameController = TextEditingController().obs;
TextEditingController get getNameController => nameController.value;
var accountNumberController = TextEditingController().obs;
TextEditingController get getAccountNumberController => accountNumberController.value;
var ifscController = TextEditingController().obs;
TextEditingController get getIFSCController => ifscController.value;
var docTypeController = TextEditingController().obs;
TextEditingController get getDocTypeController => docTypeController.value;

var documentUrl = "".obs;
String get getDocumentUrl => documentUrl.value;
setBankModel(UserBankDetailModel val){
  bankNameController.value.text = val.bankName;
  nameController.value.text = val.accHolderName;
  accountNumberController.value.text = val.accHolderNumber;
  ifscController.value.text = val.accHolderIfsc;
  docTypeController.value.text = val.accHolderDocType;
  documentUrl.value = val.accHolderDocUrl;
}
Future<void> bankDetails() async{

  FirebaseFirestore.instance.collection("user_details").doc(FirebaseAuth.instance.currentUser.phoneNumber.replaceAll("+91", "")).collection("bank_details").doc("bank_details").get().then((value) {
    print(value.data().cast());
    UserBankDetailModel userBankDetailModel = UserBankDetailModel.fromJson(value.data().cast());
    setBankModel(userBankDetailModel);
  });

}
Future uploadPic(File image) async {

  var firebaseStorage = FirebaseStorage.instance.ref().child(FirebaseAuth.instance.currentUser.phoneNumber.replaceAll("+91", ""));
  var uploadTask = firebaseStorage.child(FirebaseAuth.instance.currentUser.phoneNumber.replaceAll("+91", "")).putFile(image);
  var taskSnapshot = await uploadTask.storage;
  Reference ref = await taskSnapshot.ref().child(FirebaseAuth.instance.currentUser.phoneNumber.replaceAll("+91", "")).child(FirebaseAuth.instance.currentUser.phoneNumber.replaceAll("+91", "")+".jpeg");
  String downloadUrl = await ref.getDownloadURL();
  print("-----------------------------");
  print(downloadUrl);
  if(downloadUrl!=null){

    UserBankDetailModel userBankDetailModel = UserBankDetailModel(
        bankName: getBankNameController.text,
        accHolderName: getNameController.text,
        accHolderNumber: getAccountNumberController.text,
        accHolderIfsc: getIFSCController.text,
        accHolderDocType:getDocTypeController.text,
        accHolderDocUrl: downloadUrl,
        docVerification: false
    );

    FirebaseFirestore.instance.collection("user_details").doc(FirebaseAuth.instance.currentUser.phoneNumber.replaceAll("+91", "")).collection("bank_details").doc("bank_details").update(userBankDetailModel.toJson()).then((value) {
      closeLoader();
      Navigator.of(Get.context).pop();
      Get.snackbar("Done", "Thank you for updating profile",backgroundColor: Colors.amber);
    }).onError((error, stackTrace) {
      closeLoader();
      Get.snackbar("Error", error.toString(), backgroundColor: Colors.amber);
    });;


  }
 /* try{
    showLoader();
    var firebaseStorage = FirebaseStorage.instance.ref().child(FirebaseAuth.instance.currentUser.phoneNumber.replaceAll("+91", ""));
    var uploadTask = firebaseStorage.child(FirebaseAuth.instance.currentUser.phoneNumber.replaceAll("+91", "")).putFile(image);
    var taskSnapshot = await uploadTask.storage;
    Reference ref = await taskSnapshot.ref().child(FirebaseAuth.instance.currentUser.phoneNumber.replaceAll("+91", "")).child(FirebaseAuth.instance.currentUser.phoneNumber.replaceAll("+91", "")+".jpeg");
    String downloadUrl = await ref.getDownloadURL();
    print("-----------------------------");
    print(downloadUrl);
    if(downloadUrl!=null){

      UserBankDetailModel userBankDetailModel = UserBankDetailModel(
        bankName: getBankNameController.text,
        accHolderName: getNameController.text,
        accHolderNumber: getAccountNumberController.text,
        accHolderIfsc: getIFSCController.text,
        accHolderDocType:getDocTypeController.text,
        accHolderDocUrl: downloadUrl,
        docVerification: false
      );

      FirebaseFirestore.instance.collection("user_details").doc(FirebaseAuth.instance.currentUser.phoneNumber.replaceAll("+91", "")).collection("bank_details").doc("bank_details").update(userBankDetailModel.toJson()).then((value) {
        closeLoader();
        Navigator.of(Get.context).pop();
        Get.snackbar("Done", "Thank you for updating profile",backgroundColor: Colors.amber);
      }).onError((error, stackTrace) {
        closeLoader();
        Get.snackbar("Error", error.toString(), backgroundColor: Colors.amber);
      });;


    }
  }  catch( exception){
    closeLoader();
    Get.snackbar("Error",exception.toString(), backgroundColor: Colors.amber);

    throw exception ;
  }*/

}

Future<firebase_storage.UploadTask> uploadFile(File file) async {
  if (file == null) {
    ScaffoldMessenger.of(Get.context).showSnackBar(const SnackBar(
      content: Text('No file was selected'),
    ));
    return null;
  }

  firebase_storage.UploadTask uploadTask;

  // Create a Reference to the file
  firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance
      .ref()
      .child(FirebaseAuth.instance.currentUser.phoneNumber.replaceAll("+91", ""))
      .child('/${FirebaseAuth.instance.currentUser.phoneNumber.replaceAll("+91", "")}.jpg');

  final metadata = firebase_storage.SettableMetadata(
      contentType: 'image/jpeg',
      customMetadata: {'picked-file-path': file.path});


  uploadTask = ref.putFile(io.File(file.path), metadata);
  _downloadLink(uploadTask.snapshot.ref);

  return Future.value(uploadTask);
}

Future<void> _downloadLink(firebase_storage.Reference ref) async {

  try{
    showLoader();
    final link = await ref.getDownloadURL();
    if(link!=null){

      UserBankDetailModel userBankDetailModel = UserBankDetailModel(
          bankName: getBankNameController.text,
          accHolderName: getNameController.text,
          accHolderNumber: getAccountNumberController.text,
          accHolderIfsc: getIFSCController.text,
          accHolderDocType:getDocTypeController.text,
          accHolderDocUrl: link,
          docVerification: false
      );

      FirebaseFirestore.instance.collection("user_details").doc(FirebaseAuth.instance.currentUser.phoneNumber.replaceAll("+91", "")).collection("bank_details").doc("bank_details").set(userBankDetailModel.toJson()).then((value) {
        closeLoader();
        Navigator.of(Get.context).pop();
        Get.snackbar("Done", "Thank you for updating profile",backgroundColor: Colors.amber);
      }).onError((error, stackTrace) {
        closeLoader();
        Get.snackbar("Error", error.toString(), backgroundColor: Colors.amber);
      });;


    }
  }  catch( exception){
    closeLoader();
    Get.snackbar("Error",exception.toString(), backgroundColor: Colors.amber);

    throw exception ;
  }

}
}