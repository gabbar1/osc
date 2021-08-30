import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:upen/commonWidget/loader.dart';
import 'package:upen/screen/leads/loadModel.dart';

class LeadController extends GetxController{

  var leadList = <LoadModel>[].obs;
  List<LoadModel> get getLeadList => leadList.value;
  setList(LoadModel loadModel){
    leadList.value.add(loadModel);
    leadList.refresh();
  }

  Future<void> getLead() async{
    leadList.clear();
    getLeadList.clear();

    FirebaseFirestore.instance.collection("leads").doc(FirebaseAuth.instance.currentUser.phoneNumber.replaceAll("+91", "")).collection(FirebaseAuth.instance.currentUser.phoneNumber.replaceAll("+91", "")).get().then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((element) {
        LoadModel loadModel = LoadModel(comment: element['backend_comment'],leadDate: element['create_date'],leadType:element['leadType'],status: element['status'] );
        setList(loadModel);
        print("--------latestVersion----------");
        print(element['backend_comment']);
        print(element['status']);
        print(element['create_date']);
      });
    }).onError((error, stackTrace) {

      Get.snackbar("Error", error.toString(), backgroundColor: Colors.amber);
    });
  }
}