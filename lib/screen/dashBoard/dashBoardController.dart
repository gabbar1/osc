
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import 'models/bannerModel.dart';

class DashBoardController extends GetxController{

  var banners = <BannerModel>[].obs;
  List<BannerModel> get getBanners => banners.value;
  var isHide = false.obs;
  bool get getIsHide => isHide.value;

  setIsHide(bool val){
    isHide.value = val;
  }

  setBannerList(BannerModel bannerModel){

    this.banners.add(bannerModel);

  }

  Future<void> getBannerList()async{
    banners.clear();
      try {

        FirebaseFirestore.instance
            .collection("banners")
            .get()
            .then((QuerySnapshot querySnapshot) {
          querySnapshot.docs.forEach((element) {

            Map<String, dynamic> bannerList = element.data();
            BannerModel bannerModel = BannerModel.fromJson(bannerList);
            setBannerList(bannerModel);
          });
        });
      } catch (exception) {
        throw exception;
      }
    }
}