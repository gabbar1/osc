import 'package:flutter/material.dart';
import 'package:upen/screen/helper/constant.dart';

class DatePicker extends StatefulWidget {
  String labelText="Date of Birth";
  DatePicker({ this.labelText});

  @override
  _DatePickerState createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {
  final dateController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is removed
    dateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return  TextFormField(
      validator: (value) {
        print("---------------Date-----------");
        print(value);
        if (value.toString().isEmpty) {
         return "Field Required";
        }
        return null;
      },
        style: TextStyle(color: Constants().mainColor),
        readOnly: true,
        controller: dateController,
        decoration: InputDecoration(
          labelText: widget.labelText,
          border: new OutlineInputBorder(
            borderRadius: BorderRadius.circular(40.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Color(0xff523374), width: 2.0),
            borderRadius: BorderRadius.circular(25.0),
          ),
        ),
        onTap: () async {
          var date =  await showDatePicker(
              context: context,
              initialDate:DateTime.now(),
              firstDate:DateTime(1900),
              lastDate: DateTime(2100));
          dateController.text = date.toString().substring(0,10);
        },);
  }
}