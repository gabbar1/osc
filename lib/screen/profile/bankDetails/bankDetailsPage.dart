import 'package:flutter/material.dart';
import 'package:upen/commonWidget/commonWidget.dart';
import 'package:upen/screen/helper/constant.dart';

class BankDetailsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Bank Details"),
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
                labelText: "Select bank",
              ),
              items: <String>['SBI', 'HDFC', 'ICICI'].map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: new Text(value),
                );
              }).toList(),
              onChanged: (_) {},
            ),
            CommonTextInput(
              labeltext: "Name as per bank record",
            ),
            CommonTextInput(
              labeltext: "Account Number",
              textInputType: TextInputType.phone,
            ),
            CommonTextInput(
              labeltext: "IFSC Code",
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 10),
              child: CommonText(
                  text: "Upload cancelled cheque or passbook",
                  textColor: Constants().mainColor),
            ),
            DropdownButtonFormField(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                labelText: "Select Type",
              ),
              items: <String>['Cheque', 'Passbook'].map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: new Text(value),
                );
              }).toList(),
              onChanged: (_) {},
            ),
            SizedBox(
              height: 20,
            ),
            InkWell(
              onTap: (){},
              child: Container(
                width: 40,
                height: 180,
                decoration: BoxDecoration(
                  border: Border.all(),
                  color: Colors.grey.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Icon(Icons.camera_alt,size: 60,color: Colors.lightBlueAccent),
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
