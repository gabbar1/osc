import 'dart:convert';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:excel/excel.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:upen/commonWidget/loader.dart';
import 'package:upen/screen/partner/model/category_model.dart';
import 'package:upen/screen/partner/model/referModel.dart';
import 'package:upen/screen/profile/personalDetails/personalDetailModel.dart';
import 'package:url_launcher/url_launcher.dart';


import '../model/leadModel.dart';

class PartnerController extends GetxController{

  var referList = <ReferModel>[].obs;
  List<ReferModel> get getReferList => referList.value;
  setReferList(ReferModel referModel){
    referList.value.add(referModel);
    referList.refresh();
  }

  var leadList = <LeadModel>[].obs;
  List<LeadModel> get getLeadList => leadList.value;
  setLeadList(LeadModel leadModel){
    leadList.value.add(leadModel);
    leadList.value.sort((a,b)=> b.time.compareTo(a.time));
    leadList.refresh();
  }

  var aboutList = <About>[].obs;
  List<About> get getAboutList => aboutList.value;
  setAboutList(About val){
    aboutList.value.add(val);
    aboutList.sort((a,b)=>a.index.compareTo(b.index));
    aboutList.refresh();
  }
  var faqList = <Faq>[].obs;
  List<Faq> get getFaqList => faqList.value;
  setFaqList(Faq val){
    faqList.value.add(val);
    faqList.sort((a,b)=>a.index.compareTo(b.index));
    faqList.refresh();
  }
  var howToEarnList = <HowToEarn>[].obs;
  List<HowToEarn> get getHowToEarnListList => howToEarnList.value;
  setHowToEarnListList(HowToEarn val){
    howToEarnList.value.add(val);
    howToEarnList.sort((a,b)=>a.index.compareTo(b.index));
    howToEarnList.refresh();
  }
  var knowMoreList = <KnowMore>[].obs;
  List<KnowMore> get getKnowMoreList => knowMoreList.value;
  setKnowMoreList(KnowMore val){
    knowMoreList.value.add(val);
    knowMoreList.sort((a,b)=>a.index.compareTo(b.index));
    knowMoreList.refresh();
  }

  var categoryIndex = 0.obs;
  int get getCategoryIndex => categoryIndex.value;
  setCategoryIndex(int val){
    categoryIndex.value = val;
    categoryIndex.refresh();
  }
  Future<void> referralPartners(bool isAdmin,String category) async{
    if(!isAdmin){
      referList.value.clear();
      FirebaseFirestore.instance.collection("direct-selling-referral").where("type",isEqualTo: category).where("isEnabled",isEqualTo: true).get().then((value) {

        value.docs.forEach((element) {

          ReferModel referModel = ReferModel.fromJson(element.data());
          referModel.key = element.id;
          print(jsonEncode(element.data()));
          print("===================================");
          setReferList(referModel);

        });
      });
    }else{
      referList.value.clear();
      FirebaseFirestore.instance.collection("direct-selling-referral").get().then((value) {
        value.docs.forEach((element) {
          print(jsonEncode(element.data()));
          ReferModel referModel = ReferModel.fromJson(element.data());
          referModel.key = element.id;
          setReferList(referModel);

        });
      });
    }
  }
  Future<void> referralInfo(String category) async{

    aboutList.clear();
    faqList.clear();
    howToEarnList.clear();
    knowMoreList.clear();
    FirebaseFirestore.instance.collection("direct-selling-referral").doc(category).collection("about").get().then((eValue) {
      eValue.docs.forEach((element) {
        print("==============about=====================");
        print(jsonEncode(element.data()));
        About _about = About.fromJson(element.data());
        setAboutList(_about);
        print("==============about=====================");
      });
    });
    FirebaseFirestore.instance.collection("direct-selling-referral").doc(category).collection("faq").get().then((eValue) {
      eValue.docs.forEach((element) {
        print("==============faq=====================");
        print(jsonEncode(element.data()));
        Faq _faq = Faq.fromJson(element.data());
        setFaqList(_faq);
        print("==============faq=====================");
      });
    });
    FirebaseFirestore.instance.collection("direct-selling-referral").doc(category).collection("how-to-earn").get().then((eValue) {
      eValue.docs.forEach((element) {
        print("==============how to earn=====================");
        print(jsonEncode(element.data()));
        HowToEarn _howToEarn = HowToEarn.fromJson(element.data());
        setHowToEarnListList(_howToEarn);
        print("==============how to earn=====================");
      });
    });
    FirebaseFirestore.instance.collection("direct-selling-referral").doc(category).collection("know-more").get().then((eValue) {
      eValue.docs.forEach((element) {
        print("==============know more=====================");
        print(jsonEncode(element.data()));
        KnowMore _knowMore =KnowMore.fromJson(element.data());
        setKnowMoreList(_knowMore);
        print("==============know more=====================");
      });
    });
  }

  Future<void> submitReferral(LeadModel leadModel,String url) async{

    _launchURL() async {
        await launch(url);
    }
    showLoader();
    FirebaseFirestore.instance.collection("leads").where("customer_phone",isEqualTo:leadModel.customerPhone ).
    where("product",isEqualTo: leadModel.product).get().then((value) {
      print("===========================================");
      print(value.docs.length);
      if(value.docs.length == 0){
        FirebaseFirestore.instance.collection("leads").add(leadModel.toJson()).then((value) {
          closeLoader();
          Navigator.pop(Get.context);
          _launchURL();
         // Share.share(url, sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);
        }).then((value) {

        });
      }
      else{
        closeLoader();
        Get.snackbar("Alert", "Lead Already Submitted for the same customer");
      }
    });

  }

  DocumentSnapshot lastDocument;
  Future<void> myLeads() async{
    leadList.value.clear();

    print("===================New Load======================");
    FirebaseFirestore.instance.collection("leads").where("referral_id",isEqualTo:int.parse(FirebaseAuth.instance.currentUser.phoneNumber.replaceAll("+91", "")) ).limit(5).get().then((value) {
      lastDocument = value.docs[value.docs.length -1];
      value.docs.forEach((element) {
        LeadModel leadModel = LeadModel.fromJson(element.data());
        setLeadList(leadModel);
      });



    });

  }
  Future<void> myRefreshLeads() async{
    print("===================onRefresh======================");
    FirebaseFirestore.instance.collection("leads").where("referral_id",isEqualTo:int.parse(FirebaseAuth.instance.currentUser.phoneNumber.replaceAll("+91", "")) ).limit(5).startAfterDocument(lastDocument).get().then((value) {
      print(value.docs.length);
      lastDocument = value.docs[value.docs.length -1];
      value.docs.forEach((element) {
        LeadModel leadModel = LeadModel.fromJson(element.data());
        setLeadList(leadModel);
      });
    });

  }

  void updateStatus(ReferModel refer) {
    showLoader();
    FirebaseFirestore.instance.collection("direct-selling-referral").doc(refer.key).update(refer.toJson()).then((value) {
      referralPartners(true,"");
      closeLoader();
      Get.snackbar("Sucess", "Product status changed");
    });

  }
  void addPartner(ReferModel refer) {
    showLoader();
    try{
      FirebaseFirestore.instance.collection("direct-selling-referral").add(refer.toJson()).then((value) {
        closeLoader();
        Navigator.pop(Get.context);
        Get.snackbar("Success", "Partner has bee added");
        referralPartners(true,"");
      });

    }catch(e){
      Get.snackbar("Error", e.toString());
      throw e;

    }

  }
  void updatePartner(ReferModel refer) {
    showLoader();
    try{
      FirebaseFirestore.instance.collection("direct-selling-referral").doc(refer.key).update(refer.toJson()).then((value) {
        closeLoader();
        Navigator.pop(Get.context);
        Get.snackbar("Success", "Partner has bee updated");
        referralPartners(true,"");
      });

    }catch(e){
      Get.snackbar("Error", e.toString());
      throw e;

    }

  }

  void deletePartner(ReferModel refer) {
    showLoader();
    try{
      FirebaseFirestore.instance.collection("direct-selling-referral").doc(refer.key).delete().then((value) {

        closeLoader();
        Navigator.pop(Get.context);
        Get.snackbar("Success", "Partner has bee deleted");
        referralPartners(true,"");

      });

    }catch(e){
      Get.snackbar("Error", e.toString());
      throw e;

    }

  }

  var productCategoryList = <CategoryModel>[].obs;
  List<CategoryModel> get getProductCategoryList => productCategoryList.value;
  setProductCategory(CategoryModel val){
    productCategoryList.value.add(val);
    productCategoryList.refresh();
  }
  void productCategory(){
    productCategoryList.clear();
    FirebaseFirestore.instance.collection("product-category").get().then((value) {
      value.docs.forEach((element) {
        element.data();
        CategoryModel categoryModel = CategoryModel.fromJson(element.data());
        categoryModel.key = element.id;
        setProductCategory(categoryModel);
      });
    });
  }

  void updateCategoryStatus(CategoryModel val) {
    showLoader();
    FirebaseFirestore.instance.collection("product-category").doc(val.key).update(val.toJson()).then((value) {
      referralPartners(true,"");
      closeLoader();
      Get.snackbar("Success", "Category status changed");
    });
  }

  void createCategory(CategoryModel val){
    try{
      showLoader();
      FirebaseFirestore.instance.collection("product-category").where("categoryName",isEqualTo: val.categoryName).get().then((value) {
        if(value.docs.length == 0){
          print("===================empty =================");
          FirebaseFirestore.instance.collection("product-category").add(val.toJson()).then((value) {
            closeLoader();
            productCategory();
            Navigator.pop(Get.context);
          }).onError((error, stackTrace) {
            closeLoader();
            Get.snackbar("Error",error.toString());
          });
        }
        else{
          closeLoader();
          Get.snackbar("Alert", "This category is already exist");
        }
      }).onError((error, stackTrace) {
        closeLoader();
        Get.snackbar("Error", error.toString());
      });
    }catch(e){
      closeLoader();
      Get.snackbar("Error",e.toString());
      throw e;
    }

  }


  var productCategoryDashBoardList = <CategoryModel>[].obs;
  List<CategoryModel> get getProductCategoryDashBoardList => productCategoryDashBoardList.value;
  setProductCategoryDashBoard(CategoryModel val){
    productCategoryDashBoardList.value.add(val);
    productCategoryDashBoardList.refresh();
  }
  void productCategoryDashBoard(){
    productCategoryDashBoardList.clear();
    FirebaseFirestore.instance.collection("product-category").where("isEnabled",isEqualTo: true).get().then((value) {
      value.docs.forEach((element) {
        element.data();
        CategoryModel categoryModel = CategoryModel.fromJson(element.data());
        categoryModel.key = element.id;
        setProductCategoryDashBoard(categoryModel);
      });
    });
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
        showLoader(isLoading: true);
        //  print(jsonData.length);
        print("------------------json---------");
        // print(jsonEncode(element));
        Map<String, dynamic> map = json.decode(jsonEncode(element));
        print(map["mobile"]);


        try{
          FirebaseFirestore.instance.collection("leads").where("customer_phone",isEqualTo:map["mobile"] ).where("product",isEqualTo: map["product"]).where("leadClosed",isEqualTo: false).get().then((value) {
            value.docs.forEach((element) {
              LeadModel _leadModel = LeadModel.fromJson(element.data());
              _leadModel.key = element.id;
              FirebaseFirestore.instance.collection("leads").doc(element.id).update({
                "referralId" : _leadModel.referralId,
                "status" : map["status"],
                "leadClosed": map["leadClosed"],
                "customerEmail" : _leadModel.customerEmail,
                "customerName ": _leadModel.customerName,
                "customerPhone" : _leadModel.customerPhone,
                "product": _leadModel.product,
                "referralPrice" : _leadModel.referralPrice,
                "comment":map["comment"],
                "time" : Timestamp,

              }).then((value) {
                if(map["status"] == "success"){
                  // Get User Details
                  FirebaseFirestore.instance.collection("user_details").doc(_leadModel.referralId.toString()).get().then((value) {
                    UserDetailModel _userDetailModel = UserDetailModel.fromJson(value.data());
                    //Update User details
                    FirebaseFirestore.instance.collection("user_details").doc(_userDetailModel.advisorPhoneNumber).update({
                      "referedBy":_userDetailModel.referedBy,
                      "advisorPhoneNumber":_userDetailModel.advisorPhoneNumber,
                      "advisor":_userDetailModel.advisor,
                      "total_wallet":double.parse(_userDetailModel.total_wallet) + _leadModel.referralPrice,
                      "current_wallet":double.parse(_userDetailModel.current_wallet) + _leadModel.referralPrice,
                      "isEnabled":_userDetailModel.isEnabled,
                      "advisorAdd1":_userDetailModel.advisorAdd1,
                      "advisorAdd2":_userDetailModel.advisorAdd2,
                      "advisorCity":_userDetailModel.advisorCity,
                      "advisorDob":_userDetailModel.advisorDob,
                      "advisorEmail":_userDetailModel.advisorEmail,
                      "advisorName":_userDetailModel.advisorName,
                      "advisorOccupation":_userDetailModel.advisorOccupation,
                      "advisorPincode":_userDetailModel.advisorPincode,
                      "advisorState":_userDetailModel.advisorState,
                      "advisorUrl":_userDetailModel.advisorUrl,
                      "isAdmin":_userDetailModel.isAdmin,
                    }).then((value) {
                      //Get Referral details
                      FirebaseFirestore.instance.collection("user_details").doc(_userDetailModel.referedBy).get().then((value) {
                        UserDetailModel _referralUserDetailModel = UserDetailModel.fromJson(value.data());
                        //Update Referral details
                        FirebaseFirestore.instance.collection("user_details").doc(_userDetailModel.referedBy).update({
                          "referedBy":_referralUserDetailModel.referedBy,
                          "advisorPhoneNumber":_referralUserDetailModel.advisorPhoneNumber,
                          "advisor":_referralUserDetailModel.advisor,
                          "total_wallet":double.parse(_referralUserDetailModel.total_wallet) + ((10/100)*_leadModel.referralPrice),
                          "current_wallet":double.parse(_referralUserDetailModel.current_wallet) + ((10/100)*_leadModel.referralPrice),
                          "isEnabled":_referralUserDetailModel.isEnabled,
                          "advisorAdd1":_referralUserDetailModel.advisorAdd1,
                          "advisorAdd2":_referralUserDetailModel.advisorAdd2,
                          "advisorCity":_referralUserDetailModel.advisorCity,
                          "advisorDob":_referralUserDetailModel.advisorDob,
                          "advisorEmail":_referralUserDetailModel.advisorEmail,
                          "advisorName":_referralUserDetailModel.advisorName,
                          "advisorOccupation":_referralUserDetailModel.advisorOccupation,
                          "advisorPincode":_referralUserDetailModel.advisorPincode,
                          "advisorState":_referralUserDetailModel.advisorState,
                          "advisorUrl":_referralUserDetailModel.advisorUrl,
                          "isAdmin":_referralUserDetailModel.isAdmin,
                        });
                      });

                    });
                  });
                }
              });
            });
          });
          closeLoader();
        }catch(e){
          closeLoader();
          Get.snackbar("Error", e.toString());
        }
        
        /*FirebaseFirestore.instance.collection("contactData").add(map).then((value) {
          cnd = cnd+1;
          if(jsonData.length ==cnd){
            closeLoader();
            Get.snackbar("Success", "Data Uploaded........",backgroundColor: Constants().mainColor);
          }



        }).onError((error, stackTrace) {
          closeLoader();
          Get.snackbar("Error", error.toString());
        });*/

        closeLoader();
      });

    }catch(exception){
      closeLoader();
      Get.snackbar("Error", exception.toString());
      throw exception;
    }


  }
}