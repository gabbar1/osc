import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:upen/commonWidget/commonWidget.dart';
import 'package:upen/screen/helper/constant.dart';

class ProfessionalDetailsScreen extends StatelessWidget {

  var _radioValue1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Professional Details"),
      ),
      body: Container(
        padding:
            EdgeInsets.only(left: 10.0, right: 10.0, bottom: 15.0, top: 20),
        color: Colors.white70,
        child: ListView(
          children: [
            DropdownButtonFormField(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                labelText: "Select primary source of income",
              ),
              items: <String>['Sancha', 'Embordery', 'Bobin'].map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: new Text(value),
                );
              }).toList(),
              onChanged: (_) {},
            ),
            Text("Total experience in any financial product",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
            DropdownButtonFormField(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                labelText: "Select total experience ",
              ),
              items: <String>['0 year', '1-5 year', '5+ year'].map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: new Text(value),
                );
              }).toList(),
              onChanged: (_) {},
            ),
            Text("Do you have own office to sell financial products?",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
            Row(
              children: [
                new Radio(
                  value: 0,
                  groupValue: _radioValue1,

                ),
              ],
            ),
            SizedBox(height: 10,),
            DropdownButtonFormField(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                labelText: "Select highest qualification",
              ),
              items: <String>['SSC', 'HSC', 'Graduate'].map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: new Text(value),
                );
              }).toList(),
              onChanged: (_) {},
            ),
            SizedBox(
              height: 15,
            ),
            InkWell(
              onTap: () {},
              child: Container(
                width: 40,
                height: 180,
                decoration: BoxDecoration(
                  border: Border.all(),
                  color: Colors.grey.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Icon(Icons.camera_alt,
                    size: 60, color: Colors.lightBlueAccent),
              ),
            ),
            SizedBox(
              height: 25,
            ),
            CommonButton(
              onPressed: () {},
              buttonText: "Submit",
              buttonColor: Constants().mainColor,
              vPadding: 15.0,
            ),
          ],
        ),
      ),
    );
  }
}
