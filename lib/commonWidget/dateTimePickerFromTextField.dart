import 'package:flutter/material.dart';
import 'package:upen/screen/CustomerVerification/customerVerificationController.dart';
import 'package:upen/screen/helper/constant.dart';

class DatePicker extends StatefulWidget {
  String labelText="Date of Birth";
  final dateController = TextEditingController();
  DatePicker({ this.labelText});

  @override
  _DatePickerState createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {

  CustomerVerificationController customerVerificationController = CustomerVerificationController();

  @override
  void dispose() {
    // Clean up the controller when the widget is removed
    widget.dateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return  TextFormField(
      validator: (value) {

        if (value.toString().isEmpty) {
         return "Field Required";
        }
        return null;
      },
        style: TextStyle(color: Constants().mainColor),
        readOnly: true,
        controller: widget.dateController,
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
          widget.dateController.text = date.toString().substring(0,10);
          setState(() {
           // customerVerificationController.odbController.text =  date.toString().substring(0,10);
            customerVerificationController.setDob(date.toString().substring(0,10));
            print("---------------Datesssss-----------");
          //  print(customerVerificationController.odbController.text);
          });

        },);
  }
}