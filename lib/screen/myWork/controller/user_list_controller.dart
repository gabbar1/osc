import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../model/contact_model.dart';

class UserListController extends GetxController {

  var userList = <UserContactModel>[].obs;

  List<UserContactModel> get getUsersList => userList.value;

  setUser(UserContactModel userContactModel) {
    userList.value.add(userContactModel);
    userList.refresh();
  }


  Future<void> getUserList() async {
    userList.value.clear();
    try {
      FirebaseFirestore.instance
          .collection("user_details").get()
          .then((QuerySnapshot querySnapshot) {
        querySnapshot.docs.forEach((element) {

          UserContactModel _userModel = UserContactModel(name: element["advisor_name"], mobile: element["advisor_phone_number"],isEnabled: element["isEnabled"]);
          setUser(_userModel);
        });
      });
    } catch (exception) {
      throw exception;
    }
  }

  var userLeadDetails = <UserContactModel>[].obs;
  List<UserContactModel> get getUserDetailsList => userLeadDetails.value;
   setUserLeadDetails(UserContactModel val){
    userLeadDetails.value.add(val);
    userLeadDetails.refresh();
  }
  Future<void> getUserLeadDetails(String mobile,name,bool isEnabled)async{
    print(mobile);
    print(name);
    print(isEnabled);
    userLeadDetails.value.clear();
    try{
      UserContactModel _userModel = UserContactModel(name: name, mobile: mobile,isEnabled: isEnabled);
      FirebaseFirestore.instance.collection("contactData").where("assigned_to",isEqualTo:mobile ).get().then((value) {
        var _userMode = <UserContactModel1>[].obs;
        _userMode.clear();
        value.docs.forEach((sE) {
          UserContactModel1 _user = UserContactModel1.fromJson(sE.data());
          _userMode.add(_user);

        });
        _userModel.userData = _userMode;
        setUserLeadDetails(_userModel);
      });
    }catch(e){
      throw e;
    }
  }

  void updateStatus(bool isEnabled,String doc) {
    FirebaseFirestore.instance
        .collection("user_details").doc(doc).update({
          "isEnabled":isEnabled
    }).then((value) {
      getUserList();
    });
  }
}