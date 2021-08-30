import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class TeamController extends GetxController {
  var thisMonthEarning = 0.obs;
  int get getThisMonthEarning => thisMonthEarning.value;
  setMonthEarning(int val) {
    this.thisMonthEarning.value = this.thisMonthEarning.value + val;
  }

  var thisTotalEarning = 0.obs;
  int get getThisTotalEarning => thisTotalEarning.value;
  setTotalEarning(int val) {
    this.thisTotalEarning.value = this.thisTotalEarning.value + val;
  }

  var teamList = <String>[].obs;
  List<String> get getTeamList => teamList.value;
  setTeamList(String val){
    teamList.value.add(val);
    teamList.refresh();
  }
  Future<void> getLead() async {
    teamList.clear();
    getTeamList.clear();
    var doc = FirebaseFirestore.instance.collection("user_details").doc(
        FirebaseAuth.instance.currentUser.phoneNumber.replaceAll("+91", ""));
    doc.get().then((value) {
      doc.collection("earning").get().then((QuerySnapshot querySnapshot) {
        querySnapshot.docs.forEach((element) {
          print(DateTime.now()
              .difference(DateTime.parse(element['date']))
              .inDays);
          if (DateTime.now()
                  .difference(DateTime.parse(element['date']))
                  .inDays <=
              30) {
            setMonthEarning(element['amount']);
          }
          setTotalEarning(element['amount']);
        });
      });
    });
    FirebaseFirestore.instance.collection("user_details").get().then((QuerySnapshot querySnapshot) {
      print("==============user_details=================");
      querySnapshot.docs.forEach((element) {

        if(element['refered_By'] ==FirebaseAuth.instance.currentUser.phoneNumber.replaceAll("+91", "")){
          print(element['refered_By']);
          setTeamList(element['advisor_name']);
        }

      });
    });
  }
}
