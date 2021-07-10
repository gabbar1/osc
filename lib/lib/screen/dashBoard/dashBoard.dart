import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:upen/lib/commonWidget/commonWidget.dart';
import 'package:upen/lib/screen/helper/constant.dart';

class DashBoardView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child : Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CommonText(text: "Welcome to Dashboard",textColor: Constants().mainColor),
        CommonButton(
          buttonText: "Logout",
          context: context,
          buttonColor: Constants().mainColor,
          onTap: (){
            FirebaseAuth.instance.signOut();
            },
        ),
      ],
    ),
    ),
    );
  }
}

