import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:upen/commonWidget/commonWidget.dart';
import 'package:upen/screen/CustomerVerification/customerVerificationController.dart';
import 'package:upen/screen/helper/constant.dart';
import 'package:contacts_service/contacts_service.dart';

class CustomerVerificationView extends StatelessWidget {
  CustomerVerificationController customerVerificationController =
  Get.put(CustomerVerificationController());
  GlobalKey<FormState> verification = new GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: CommonText(
          text: "Products",
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CommonText(text: "Please Enter the Customer mobile",fontSize: 28,textColor: Constants().mainColor),
          Form(
            key: verification,
            child: Padding(
                padding: EdgeInsets.only(top: 20, left: 10, right: 20),
                child: Obx(() => TextFormField(
                  maxLength: 10,
                  keyboardType: TextInputType.phone,
                  controller: customerVerificationController.getVerification,
                  style: TextStyle(color: Constants().mainColor),
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.phone,
                      color: Constants().mainColor,
                    ),
                    suffixIcon: InkWell(
                      onTap: () {
                        customerVerificationController.askPermissions();
                      },
                      child: Icon(
                        Icons.contact_phone_outlined,
                        color: Constants().mainColor,
                      ),
                    ),
                    hintText: "Mobile No",
                    labelText: "Enter Mobile",
                    border: new OutlineInputBorder(
                      borderRadius: BorderRadius.circular(40.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                          color: Color(0xff523374), width: 2.0),
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                  ),
                  validator: (val){
                    if(val.toString().isEmpty||val.toString().length<10){
                      return "enter valid phone";
                    }
                    return null;
                  },
                ))),
          ),
          CommonButton(onPressed: (){
            if (verification.currentState.validate()) {
              print("Validated");
              print("---------------------------");
              print(customerVerificationController.getVerification.text);
              Get.to(CustomerDetailsScreen(phoneValue: customerVerificationController.getVerification,));
            } else {
              print("not validated");
            }
          },buttonColor: Constants().mainColor,buttonText: "next")
        ],
      ),
    );
  }
}

class CustomerDetailsScreen extends StatelessWidget {
  CustomerDetailsScreen({this.phoneValue});
  TextEditingController phoneValue;
  CustomerVerificationController _controller = Get.put(CustomerVerificationController());
  GlobalKey<FormState> detailsKey = new GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(centerTitle: true,title: Text("Personal details"),),
      body: Container(
        padding:
        EdgeInsets.only(left: 10.0, right: 10.0, bottom: 15.0, top: 20),
        color: Colors.blue[30],
        child: Form(
          key:detailsKey ,
          child: ListView(
            children: <Widget>[
              CommonTextInput(
                labeltext: "Mobile No",
                hint: "Enter Mobile No",
                isReadOnly: true,
                inputController:phoneValue,


              ),
              CommonTextInput(
                labeltext: "Name",
                hint: "Enter Name",
                isReadOnly: false,
                inputController:_controller.nameController,
                  errortext: "Enter name"
              ),
              CommonTextInput(
                labeltext: "Email",
                hint: "Enter Email",
                isReadOnly: false,
                inputController:_controller.emailController,
                regexp:
                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
                  errortext: "Enter valid email",

              ),
              SizedBox(height: 20,),
              CommanDateTimePicker(
                  labelText: "Date of Birth"

              ),
              CommonTextInput(
                inputController: _controller.addressController,
                labeltext: "Address ",
                hint: "Enter Address",
                  errortext: "Enter address"
              ),
              CommonTextInput(
                inputController: _controller.pinCodeController,
                labeltext: "Pincode",
                hint: "Pincode",
                textInputType: TextInputType.phone,
                maxLength: 6,
                  errortext: "Enter valid pincode"
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
                    child: CommonText(text: value,textColor: Constants().mainColor),
                  );
                }).toList(),
                validator: (value) {
                  print("-----------ValidatedOr not------------");
                  print(value);
                  if (value==null) {
                    return 'Field required';
                  }
                  return null;
                },
                onChanged: (_) {},
              ),
              SizedBox(height: 20,),
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
                    child: CommonText(text: value,textColor: Constants().mainColor),
                  );
                }).toList(),
                validator: (value) {
                  if (value==null) {
                      return 'Field required';
                  }
                  return null;
                },
                onChanged: (_) {},
              ),
              SizedBox(height: 20,),
              CommonButton(
                onPressed: (){
                  if(detailsKey.currentState.validate()){
                    print("------Validated-------------");
                    Get.to(CheckExistingLoanView());
                  }
                  else{
                    print("------Not-Validated-------------");
                  }
                },
                buttonText: "Confirm Details",
                vPadding: 20,
                buttonColor: Constants().mainColor,
              ),
              SizedBox(height: 20,),
            ],
          ),
        ),
      ),
    );
  }
}

class CheckExistingLoanView extends StatelessWidget {
  CustomerVerificationController customerVerificationController =
  Get.put(CustomerVerificationController());

  GlobalKey<FormState> loanKey = new GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Existing Loan"),
        centerTitle: true,
      ),
      body: Center(
        child: Container(

          width: MediaQuery.of(context).size.width * .9,
          height: MediaQuery.of(context).size.width * .8,

          child: Form(
            key: loanKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                Padding(
                  padding: EdgeInsets.only(left: 20,right: 20),
                  child: CommonTextInput(
                      textInputType: TextInputType.phone,
                      labeltext: "Existing Loan",
                      inputController: customerVerificationController.existingLoanController,
                      lableFontSize: 20,
                      lableFontStyle: FontWeight.bold,
                      lableTextColor: Constants().mainColor,
                      regexp: r"^[0-9]{10}$",
                      errortext: "Enter valid Existing loan amount"),
                ),
                SizedBox(
                  height: 15,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 20,right: 20),
                  child: CommonTextInput(
                      textInputType: TextInputType.phone,
                      labeltext: "Monthly EMI",
                      inputController: customerVerificationController.monthlyEmiController,
                      lableFontSize: 20,
                      lableFontStyle: FontWeight.bold,
                      lableTextColor: Constants().mainColor,
                      regexp: r"^[0-9]{10}$",
                      errortext: "Enter monthly EMI"),
                ),
                SizedBox(
                  height: 15,
                ),
                CommonButton(
                    onPressed: () {
                      print("-----Clicked------");
                      if (loanKey.currentState.validate()) {
                        print("Validated");
                        Get.to(CustomerIncomeDetailsScreen());

                      } else {
                        print("not validated");
                      }
                    },
                    context: context,

                    buttonText: "Continue",
                    buttonColor: Constants().mainColor,
                    shdowColor: Colors.lightBlue,
                    buttonTextColor: Colors.white,
                    buttonTextSize: 18,
                    buttonTextStyle: FontWeight.bold),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CustomerIncomeDetailsScreen extends StatelessWidget {
  CustomerIncomeDetailsScreen({this.phoneValue});
  TextEditingController phoneValue;
  CustomerVerificationController _controller = Get.put(CustomerVerificationController());
  GlobalKey<FormState> detailsKey = new GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(centerTitle: true,title: Text("Income details"),),
      body: Container(
        padding:
        EdgeInsets.only(left: 20.0, right: 20.0, ),
        color: Colors.blue[30],
        child: Form(
          key:detailsKey ,
          child: ListView(
            children: <Widget>[
              CommonTextInput(
                textInputType: TextInputType.numberWithOptions(),
                labeltext: "Monthly Salary",
                hint: "Enter Monthly Salary",
                isReadOnly: false,
                inputController:_controller.monthlySalaryController,


              ),
              CommonTextInput(
                  labeltext: "Company Name",
                  hint: "Enter Company Name",
                  isReadOnly: false,
                  inputController:_controller.companyNameController,
                  errortext: "Enter Company Name"
              ),
              CommonTextInput(
                labeltext: "Designation",
                hint: "Enter Designation",
                isReadOnly: false,
                inputController:_controller.designationController,
              ),
              SizedBox(height: 20,),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  labelText: "Select Experience",
                ),
                items: <String>['--Select Experience--','1 Year','2 Years','2 Years','More than 3 Years'].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: CommonText(text: value,textColor: Constants().mainColor),
                  );
                }).toList(),
                validator: (value) {
                  print("-----------ValidatedOr not------------");
                  print(value);
                  if (value==null) {
                    return 'Field required';
                  }
                  return null;
                },
                onChanged: (_) {},
              ),
              CommonTextInput(
                labeltext: "Office Email",
                hint: "Enter Office Email",
                isReadOnly: false,
                inputController:_controller.officeEmailController,
                regexp:
                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
                errortext: "Enter valid email",

              ),
              CommonTextInput(
                labeltext: "Office Address",
                hint: "Enter Office Address",
                isReadOnly: true,
                inputController:_controller.officeAddressController,


              ),

              CommonTextInput(
                  inputController: _controller.officePinCodeController,
                  labeltext: "Office Pincode",
                  hint: "Enter Office PinCode",
                  textInputType: TextInputType.phone,
                  maxLength: 6,
                  errortext: "Enter valid pincode"
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
                    child: CommonText(text: value,textColor: Constants().mainColor),
                  );
                }).toList(),
                validator: (value) {
                  print("-----------ValidatedOr not------------");
                  print(value);
                  if (value==null) {
                    return 'Field required';
                  }
                  return null;
                },
                onChanged: (_) {},
              ),
              SizedBox(height: 20,),
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
                    child: CommonText(text: value,textColor: Constants().mainColor),
                  );
                }).toList(),
                validator: (value) {
                  if (value==null) {
                    return 'Field required';
                  }
                  return null;
                },
                onChanged: (_) {},
              ),
              SizedBox(height: 20,),
              CommonButton(
                onPressed: (){
                  if(detailsKey.currentState.validate()){
                    print("------Validated-------------");
                    Get.to(CheckExistingLoanView());
                  }
                  else{
                    print("------Not-Validated-------------");
                  }
                },
                buttonText: "Confirm Details",
                vPadding: 20,
                buttonColor: Constants().mainColor,
              ),
              SizedBox(height: 20,),
            ],
          ),
        ),
      ),
    );
  }
}
