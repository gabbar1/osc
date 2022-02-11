
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:upen/screen/dashBoard/models/productModel.dart';
import 'package:upen/screen/myWork/model/contact_model.dart';

import '../models/bannerModel.dart';

class DashBoardController extends GetxController{

  var banners = <BannerModel>[].obs;
  List<BannerModel> get getBanners => banners.value;
  var isHide = false.obs;
  bool get getIsHide => isHide.value;

 var productList = <ProductModel>[].obs;
  List<ProductModel> get getProducts=> productList.value;

  setIsHide(bool val){
    isHide.value = val;
  }

  setBannerList(BannerModel bannerModel){

    this.banners.add(bannerModel);

  }



  Future<void> getBannerList()async{
    banners.value.clear();
    getBanners.clear();
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

  Future<void> getProductList()async{
    productList.value.clear();
    try {

      FirebaseFirestore.instance
          .collection("products")
          .get()
          .then((QuerySnapshot querySnapshot) {

        querySnapshot.docs.forEach((element) {
          print("----------------CheckElement----------------");

          ProductModel _productModel = ProductModel(id:element.id,steps: element["steps"] );
          print(_productModel.id);
          print(_productModel.steps);
          setProductList(_productModel);
        });
      });
    } catch (exception) {
      throw exception;
    }
  }

  var isRecall = true.obs;
  bool  get getIsRecall => isRecall.value;
  setIsRecall(bool val){
    isRecall.value = val;
    isRecall.refresh();
  }

  /*Future<void> removeZero()async{
    try {

      FirebaseFirestore.instance
          .collection("contactData").where("version",isEqualTo: "policy_guj").where("mobile",isGreaterThanOrEqualTo: ".0")
          .get()
          .then((QuerySnapshot querySnapshot) {


        querySnapshot.docs.forEach((element) {
          UserContactModel userContactModel = UserContactModel.fromJson(element.data());
          print("===================querySnapshot00000000000000000000000========================");
        //  print(jsonEncode(userContactModel));
          userContactModel.key = element.id;
          print(userContactModel.key);
          if(userContactModel.mobile.contains(".0")){
            print(userContactModel.mobile);
            userContactModel.mobile.replaceAll(".0", "");
            print(userContactModel.mobile.replaceAll(".0", ""));
            FirebaseFirestore.instance.collection("contactData").doc(userContactModel.key).update({
              "mobile":userContactModel.mobile.replaceAll(".0", ""),
              "name":userContactModel.name,
              "email":userContactModel.email,
              "city":userContactModel.city,
              "state":userContactModel.state,
              "status":false,
              "version":"policy_guj"
             });
          }else{
            Get.snackbar("Not", "found");
          }
        });
      });
    } catch (exception) {
      throw exception;
    }
  }*/

  setProductList(ProductModel val){
    productList.value.add(val);
    productList.refresh();
  }
}