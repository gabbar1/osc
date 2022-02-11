
import 'package:flutter/material.dart';

import 'package:upen/commonWidget/commonWidget.dart';
import 'package:upen/screen/helper/constant.dart';


class AboutUs extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        backgroundColor: Constants().mainColor,
        appBar: AppBar(
          title: CommonText(text: "About US"),
          centerTitle: true,
        ),
        body: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.only(top: 10),
                child: Image.asset("assets/icons/icon.png"),
              ),
              CommonText(text: "CardKarobar private limited is a financial platform where any person who is looking for job in sells can join us and get an interactive pay scale from us. We provide full time work from home opportunity also best incentives in the market.  "),
              SizedBox(height: 20,),
              Center(child: Text("Contact us : admin@cardkarobar.in",style:TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),),
              Spacer()
            ],
          ),
        ));
  }
}


