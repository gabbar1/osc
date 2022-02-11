import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:upen/commonWidget/commonWidget.dart';
class ReferView extends StatefulWidget {


  @override
  _ReferViewState createState() => _ReferViewState();
}

class _ReferViewState extends State<ReferView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
        Padding(
          padding: const EdgeInsets.only(left: 10,right: 10),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            color: Color(0xFF0F1B25),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CommonText(text: "Refer & Earn 10% Lifetime"),
                    SvgPicture.asset("assets/icons/refer.svg")

                  ],),
                CommonText(text: "Refer CardKarobar app to your friends or family and earn extra 10% of their earnings"),
                SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                          CommonText(
                              text: "Referral Code:"
                          ),
                          CommonText(
                              text: FirebaseAuth.instance.currentUser.phoneNumber.replaceAll("+91", "")
                          ),

                        ],),
                        SizedBox(width: 10,),
                        Container(
                            decoration: BoxDecoration(
                                //color: Constants,
                                borderRadius: BorderRadius.all(Radius.circular(10))
                            ),
                            child: SvgPicture.asset("assets/icons/copy.svg")
                        ),
                      ],
                    ),
                    Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              colors: [
                                const Color(0xFFD88BBC),
                                const Color(0xFF9361A8),
                              ],
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                              stops: [0.0, 2.0],
                              tileMode: TileMode.clamp),
                          color: Colors.white24,
                          borderRadius: BorderRadius.all(Radius.circular(20))
                      ),
                      child: CommonText(
                          text: "REFER NOW"
                      ),
                    ),
                  ],
                )
              ],),
            ),
          ),
        ),
          Image.asset("assets/icons/refer_logo.png"),
          CommonText(
            text: "Refer Now & Earn",
            fontStyle: FontWeight.bold,
            fontSize: 18
          ),

          Padding(
            padding: const EdgeInsets.only(left: 20,right: 20,top: 10),
            child: CommonText(
              textAlign: TextAlign.center,
              text: "Refer Cardkarobar Nnow to add member in your team and earn more",

            ),
          ),
        ],
      ),
    );
  }
}
