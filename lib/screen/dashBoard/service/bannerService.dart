import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:upen/screen/dashBoard/models/bannerModel.dart';

class BannerService {
  Future<BannerModel> getBannerService() async {
    try {
      FirebaseFirestore.instance
          .collection("banners")
          .get()
          .then((QuerySnapshot querySnapshot) {
        querySnapshot.docs.forEach((element) {
          print("-----------------Banners----------------");
          // print(element.data());
          Map<String, dynamic> bannerList = element.data();
          BannerModel bannerModel = BannerModel.fromJson(bannerList);
         // print(bannerModel.url);
          return bannerModel;
        });
        // print(banners);
      });
    } catch (exception) {
      throw exception;
    }
  }
}
