import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:upen/commonWidget/commonWidget.dart';
import 'package:upen/screen/helper/constant.dart';

class EducationalDetailsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Educational Details"),
      ),
      body: Container(
        padding:
        EdgeInsets.only(left: 10.0, right: 10.0, bottom: 15.0, top: 20),
        color: Colors.white70,
        child: ListView(
          children: [
            Container(
              width: MediaQuery.of(context).size.width/1.5,
              height: MediaQuery.of(context).size.height/3.5,
              decoration: BoxDecoration(
                color: Colors.blue.withOpacity(0.1),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CachedNetworkImage(
                    imageUrl: 'https://cdn2.iconfinder.com/data/icons/education-and-knowledge-3-1/128/124-512.png',
                    imageBuilder: (context, imageProvider) => Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        borderRadius:
                        BorderRadius.circular(100),
                        image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10.0,),
                  Text("Education Details",style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: Constants().appBarColor,
                  ),)
                ],
              ),
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
