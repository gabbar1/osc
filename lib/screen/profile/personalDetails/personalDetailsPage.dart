import 'package:flutter/material.dart';
import 'package:upen/commonWidget/commonWidget.dart';
import 'package:upen/screen/helper/constant.dart';

class PersonalDetailsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Personal details"),),
      body: Container(
        padding:
        EdgeInsets.only(left: 10.0, right: 10.0, bottom: 15.0, top: 20),
        color: Colors.blue[30],
        child: ListView(
          children: <Widget>[
            ListTile(
              title: Text("First Name"),
              subtitle: Text("RInkesh"),
            ),
            ListTile(
              title: Text("Last Name"),
              subtitle: Text("Singh"),
            ),
            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                labelText: "Select one",
              ),
              items: <String>['Individual','Non-Individual'].map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: new Text(value),
                );
              }).toList(),
              onChanged: (_) {},
            ),
            CommonTextInput(
              labeltext: "Firm Name",
              hint: "Firm Name",
            ),
            CommonTextInput(
              labeltext: "Firm Name",
              hint: "Firm Name",
            ),
            ListTile(
              title: Text("Phone Number"),
              subtitle: Text("7878751580"),
            ),
            ListTile(
              title: Text("Email"),
              subtitle: Text("rinkeshs010@gmail.com"),
            ),
            CommanDateTimePicker(
              labelText: "Date of Birth"
            ),
            CommonTextInput(
              labeltext: "Address Line 1",
              hint: "Address Line 1",
            ),
            CommonTextInput(
              labeltext: "Address Line 2",
              hint: "Address Line 2",
            ),
            CommonTextInput(
              labeltext: "Pincode",
              hint: "Pincode",
              textInputType: TextInputType.phone,
              maxLength: 6,
            ),
            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                labelText: "Select State",
              ),
              items: <String>['--Select State--','Gujarat','Rajsthan'].map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: new Text(value),
                );
              }).toList(),
              onChanged: (_) {},
            ),
            SizedBox(height: 15,),
            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                labelText: "Select City",
              ),
              items: <String>['--Select City--','Surat','Jaypur'].map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: new Text(value),
                );
              }).toList(),
              onChanged: (_) {},
            ),

            CommonTextInput(
              labeltext: "Nominee Name",
              hint: "Nominee Name",
            ),
            CommonTextInput(
              labeltext: "Nominee Relation",
              hint: "Nominee Relation",
            ),
            SizedBox(height: 15,),
            CommanDateTimePicker(
                labelText: "Nominee DOB"
            ),
             SizedBox(height: 15,),
             CommonButton(
                onPressed: (){},
                buttonText: "Submit",
                vPadding: 15,
                buttonColor: Constants().appBarColor,
              ),
          ],
        ),
      ),
    );
  }
}
