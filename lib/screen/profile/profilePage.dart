import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:upen/commonWidget/commonWidget.dart';
import 'package:upen/screen/profile/personalDetails/personalDetailsPage.dart';

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
              padding: const EdgeInsets.symmetric(horizontal: 17.0),
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
                      ElevatedButton(
                        child: Text("Personal details"),
                        onPressed: (){Get.to(PersonalDetailsScreen());},
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
                      onPressed: () {print("--Personal Details Clicked--");},
                      vPadding: 15,
                      hPadding: 100,
                      buttonText: "Personal Details",
                      buttonColor: Color(0xff125650)),
                  CommonButton(
                      onPressed: () {},
                      vPadding: 15,
                      hPadding: 100,
                      buttonText: "Education Details",
                      buttonColor: Colors.white,
                      buttonTextColor: Color(0xff123374)),
                  CommonButton(
                      onPressed: () {},
                      vPadding: 15,
                      hPadding: 90,
                      buttonText: "Professional Details",
                      buttonColor: Colors.deepPurple.shade400),
                  CommonButton(
                      onPressed: () {},
                      vPadding: 15,
                      hPadding: 115,
                      buttonText: "KYC Details",
                      buttonColor: Colors.white,
                      buttonTextColor: Color(0xff123374)),
                  CommonButton(
                      onPressed: () {},
                      vPadding: 15,
                      hPadding: 130,
                      buttonText: "e-KYC",
                      buttonColor: Color(0xff523374)),
                  CommonButton(
                      onPressed: () {},
                      vPadding: 15,
                      hPadding: 110,
                      buttonText: "KYC Details",
                      buttonColor: Colors.white,
                      buttonTextColor: Color(0xff123374)),
                ],
              ),
            ),
            SizedBox(
              height: 30,
            ),
            ElevatedButton(onPressed: () {},
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.red),
                ),
                child: Text("Logout",style: TextStyle(fontSize: 20),)
            ),
          ],
        ),
      ),
    );
  }
}
