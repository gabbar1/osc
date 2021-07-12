import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:upen/commonWidget/commonWidget.dart';
import 'package:upen/screen/helper/constant.dart';

import 'notesController.dart';

class NotesView extends StatelessWidget {
  NotesController notesController = Get.put(NotesController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: CommonText(text: "My Notes"),
      ),
      body: ListView.builder(
          itemCount: 5,
          itemBuilder: (BuildContext context, index) {
            return Card(
              child: ExpansionTile(
                title: CommonText(
                    text: "title",
                    textColor: Constants().mainColor,
                    fontStyle: FontWeight.bold,
                    fontSize: 18),
                children: [
                  ListTile(
                      subtitle: Container(
                        margin: EdgeInsets.only(top: 10, bottom: 10),
                        child: CommonText(
                            text:
                                "This is the note of Leaded generatedThis is the note of Leaded generatedThis is the note of Leaded generatedThis is the note of Leaded generatedThis is the note of Leaded generatedThis is the note of Leaded generatedThis is the note of Leaded generatedThis is the note of Leaded generatedThis is the note of Leaded generated",
                            textColor: Colors.black,
                            fontSize: 10),
                      ),
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CommonText(
                            text: "Discription",
                            textColor: Constants().mainColor,
                            fontStyle: FontWeight.bold,
                          ),
                          CommonText(
                            text: "11-07-2021",
                            textColor: Constants().mainColor,
                            fontStyle: FontWeight.bold,
                          )
                        ],
                      ))
                ],
              ),
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          CommonBottomSheet().bottomSheet(
              title: "Add Note",
              context: context,
              content: Form(
                child: Padding(
                  padding: const EdgeInsets.only(left: 15,right: 15),
                  child: Column(
                    children: [
                      CommonTextInput(
                          labeltext: "Enter Topic",
                          inputController: notesController.topic,
                          /* lable: "Name",*/
                          lableFontSize: 20,
                          lableFontStyle: FontWeight.bold,
                          lableTextColor: Constants().mainColor),
                      CommonTextInput(
                          labeltext: "Enter Description",
                          inputController: notesController.decription,
                          /* lable: "Name",*/
                          lableFontSize: 20,
                          lableFontStyle: FontWeight.bold,
                          lableTextColor: Constants().mainColor),
                      SizedBox(height: 20,),
                      CommanDateTimePicker(labelText: "Select Date"),
                      SizedBox(height: 20,),
                      CommonButton(context: context,onTap: (){},buttonText: "Save")
                    ],
                  ),
                ),
              ));
        },
        backgroundColor: Constants().mainColor,
        child: Icon(Icons.add),
      ),
    );
  }
}
