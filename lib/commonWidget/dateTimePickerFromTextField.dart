import 'package:flutter/material.dart';

import 'package:upen/screen/helper/constant.dart';

class DatePicker extends StatefulWidget {
  String labelText="Date of Birth";
  final dateController = TextEditingController();
  DatePicker({ this.labelText});

  @override
  _DatePickerState createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {


  @override
  void dispose() {
    // Clean up the controller when the widget is removed
    widget.dateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return  Container(
      decoration: const BoxDecoration(
        color: Color(0xff0F1B25),
        borderRadius: BorderRadius.all(
          Radius.circular(5.0),
        ),
      ),
      child: TextFormField(
        validator: (value) {

          if (value.toString().isEmpty) {
           return "Field Required";
          }
          return null;
        },

          readOnly: true,
          controller: widget.dateController,
        style: TextStyle(color: Colors.white),
        cursorColor: Colors.white,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color: Colors.transparent, width: 0.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius:
            BorderRadius.all(Radius.circular(4)),
            borderSide: BorderSide(
                width: 1, color: Colors.transparent),
          ),
          fillColor: Colors.white,
          focusColor: Colors.white,
          border: OutlineInputBorder(),
          /* prefixIcon: Padding(
                            padding: EdgeInsets.all(15),
                            child: Icon(Icons.otp)),*/
        ),
          onTap: () async {
            var date =  await showDatePicker(
                builder: (BuildContext context, Widget child) {
                  return Theme(
                    data: ThemeData.light().copyWith(
                        primaryColor: Constants().mainColor,
                        accentColor: Constants().mainColor,
                        colorScheme:
                        ColorScheme.light(primary: Constants().mainColor),
                        buttonTheme:
                        ButtonThemeData(textTheme: ButtonTextTheme.primary)),child: child,);
                },
                context: context,
                initialDate:DateTime.now(),
                firstDate:DateTime(1900),
                lastDate: DateTime(2100));
            widget.dateController.text = date.toString().substring(0,10);
            setState(() {
             // customerVerificationController.odbController.text =  date.toString().substring(0,10);
             // customerVerificationController.setDob(date.toString().substring(0,10));
              print("---------------Datesssss-----------");
            //  print(customerVerificationController.odbController.text);
            });

          },),
    );
  }
}