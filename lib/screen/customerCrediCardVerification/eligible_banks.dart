import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:upen/commonWidget/commonWidget.dart';
import 'package:upen/screen/customerCrediCardVerification/creditCardModel.dart';

class EligibleBanksView extends StatelessWidget {
  EligibleBanksView({this.checkEligibilityModel, this.eligibleBankList});
  List<String> eligibleBankList;
  CheckEligibilityModel checkEligibilityModel;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: eligibleBankList.length,
        itemBuilder: (context, index) {
          return Scaffold(
            appBar: AppBar(
              title: CommonText(text: "Eligible Banks"),
              centerTitle: true,
            ),
            body: Row(
              children: [CommonText(text: eligibleBankList[index]),CommonButton(context: Get.context,onPressed: (){})],
            ),
          );
        });
  }
}
