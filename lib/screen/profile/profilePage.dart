import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:upen/commonWidget/commonWidget.dart';
import 'package:upen/screen/helper/constant.dart';
import 'package:upen/screen/profile/personalDetails/personalDetailsPage.dart';
import 'package:upen/screen/profile/professionalDetails/professionalDetailsPage.dart';

import 'bankDetails/bankDetailsPage.dart';
import 'educationalDetails/educationalDetailsPage.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 17.0, top: 20),
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.width * 0.25,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        blurRadius: 10,
                      ),
                    ]),
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 18.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        child: CachedNetworkImage(
                          imageUrl: 'https://picsum.photos/250?image=9',
                          imageBuilder: (context, imageProvider) => Container(
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50)),
                              image: DecorationImage(
                                image: imageProvider,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Column(
                        children: <Widget>[
                          CommonText(
                              text: "Rinkesh Singh",
                              textColor: Colors.black,
                              fontSize: 16),
                          CommonText(text: "Adviser", textColor: Colors.black),
                          CommonText(
                              text: "11/07/2021", textColor: Colors.black)
                        ],
                      ),
                      Container(
                        width: 100,
                        height: 20,
                        decoration: BoxDecoration(
                          color: Colors.orange,
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: Center(child: Text("Unverified")),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            Container(
              width: MediaQuery.of(context).size.width * .9,
              height: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      blurRadius: 10,
                    ),
                  ]),
              child: Column(
                /*itemExtent: 150,
               diameterRatio: 1.2,*/
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  SizedBox(
                    height: 5,
                  ),
                  CommonButton(
                      onPressed: () {
                        Get.to(PersonalDetailsScreen());
                      },
                      vPadding: 15,
                      hPadding: 100,
                      buttonText: "Personal Details",
                      buttonColor: Color(0xff265259)),
                  CommonButton(
                      onPressed: () {
                        Get.to(BankDetailsScreen());
                      },
                      vPadding: 15,
                      hPadding: 110,
                      buttonText: "Bank Details",
                      buttonColor: Colors.white,
                      buttonTextColor: Constants().mainColor),
                  CommonButton(
                      onPressed: () {Get.to(ProfessionalDetailsScreen());},
                      vPadding: 15,
                      hPadding: 90,
                      buttonText: "Professional Details",
                      buttonColor: Colors.deepPurple.shade400),
                  CommonButton(
                      onPressed: () {Get.to(EducationalDetailsScreen());},
                      vPadding: 15,
                      hPadding: 90,
                      buttonText: "Educational Details",
                      buttonColor: Colors.white,
                      buttonTextColor: Constants().mainColor),
                  CommonButton(
                      onPressed: () {},
                      vPadding: 15,
                      hPadding: 115,
                      buttonText: "KYC Details",
                      buttonColor: Constants().mainColor),
                ],
              ),
            ),
            SizedBox(
              height: 30,
            ),
            ElevatedButton(
                onPressed: () {},
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.red),
                ),
                child: Text(
                  "Logout",
                  style: TextStyle(fontSize: 20),
                )),
          ],
        ),
      ),
    );
  }
}
