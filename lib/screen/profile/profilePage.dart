import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:upen/commonWidget/commonWidget.dart';
import 'package:upen/screen/helper/constant.dart';
import 'package:upen/screen/profile/personalDetails/personalDetailsPage.dart';
import 'bankDetails/bankDetailsPage.dart';
import 'personalDetails/personalDetailController.dart';

class ProfileScreen extends StatefulWidget {
  bool isHide;
  ProfileScreen({this.isHide});
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {


  PersonalDetailsController _personalDetailsController = Get.put(PersonalDetailsController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:widget.isHide ?null :AppBar(title: Text("Profile"),centerTitle: true),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0, top: 20,right: 20.0),
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
                        child: Obx(()=>CachedNetworkImage(
                          imageUrl: _personalDetailsController.getDocumentUrl,
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
                        )),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Obx(()=>CommonText(
                              text: _personalDetailsController.getNameController.text,
                              textColor: Colors.black,
                              fontSize: 25)),
                          CommonText(text: "Adviser", textColor: Colors.black),
                         Obx(()=> CommonText(
                             text: _personalDetailsController.getDobController.text, textColor: Colors.black))
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

                children: <Widget>[
                  SizedBox(
                    height: 40,
                  ),
                  CommonButton(
                      onPressed: () {
                        Get.to(PersonalDetailsScreen());
                      },
                      vPadding: 15,
                      hPadding: 100,
                      buttonText: "Personal Details",
                      buttonColor: Constants().mainColor),
                  SizedBox(
                    height: 15,
                  ),
                  CommonButton(
                      onPressed: () {
                        Get.to(BankDetailsScreen());
                      },
                      vPadding: 15,
                      hPadding: 110,
                      buttonText: "Bank Details",
                      buttonColor: Colors.white,
                      buttonTextColor: Constants().mainColor),
                  SizedBox(
                    height: 15,
                  ),

                  SizedBox(
                    height: 25,
                  ),
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


  @override
  void initState() {
    // TODO: implement initState
    _personalDetailsController.personalDetails();
    super.initState();
  }
}

