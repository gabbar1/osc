import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:upen/commonWidget/commonWidget.dart';
import 'package:upen/screen/CustomerVerification/customerVerificationController.dart';
import 'package:upen/screen/CustomerVerification/loadModel.dart';
import 'package:upen/screen/helper/constant.dart';
import 'package:contacts_service/contacts_service.dart';
enum SingingCharacter { a,b,c }

class CustomerVerificationView extends StatefulWidget {
  @override
  _CustomerVerificationViewState createState() => _CustomerVerificationViewState();
}

class _CustomerVerificationViewState extends State<CustomerVerificationView> {
  SingingCharacter _character = SingingCharacter.a;
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
          CommonText(text: "Please enter the customer mobile",fontSize: 28,textColor: Constants().mainColor),
          Form(
            key: verification,
            child: Padding(
                padding: EdgeInsets.only(left: 30.0, right: 30.0, bottom: 15.0, top: 20),
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
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CommonText(
                  text: 'Home', textColor: Colors.black, fontSize: 18),
              Radio<SingingCharacter>(
                activeColor: Constants().mainColor,
                value: SingingCharacter.a,
                groupValue: _character,
                onChanged: (SingingCharacter value) {
                  setState(() {
                    print("-------------------");
                    print(_character);
                    _character = value;
                  });
                },
              ),
              CommonText(text: 'Personal', textColor: Colors.black, fontSize: 18),
              Radio<SingingCharacter>(
                activeColor: Constants().mainColor,
                value: SingingCharacter.b,
                groupValue: _character,
                onChanged: (SingingCharacter value) {
                  setState(() {
                    _character = value;
                  });
                },
              ),
            ],
          ),
          SizedBox(height: 10,),
          CommonButton(
              vPadding: 20,
              onPressed: (){
                if (verification.currentState.validate()) {
                  print("Validated");
                  print("---------------------------");
                  print(customerVerificationController.getVerification.text);
                  Get.to(CustomerDetailsScreen(phoneValue: customerVerificationController.getVerification,loanType: SingingCharacter.a ==_character?"home": SingingCharacter.b ==_character?"personal":"car",));
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
  CustomerDetailsScreen({this.phoneValue,this.loanType});
  TextEditingController phoneValue;
  String loanType;
  CustomerVerificationController _controller = Get.put(CustomerVerificationController());
  GlobalKey<FormState> detailsKey = new GlobalKey<FormState>();
  TextEditingController dobController = TextEditingController();
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(centerTitle: true,title: Text("Personal details"),),
      body: Container(

        padding: EdgeInsets.only(left: 30.0, right: 30.0, bottom: 15.0, top: 20),
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
                textInputAction: TextInputAction.next

              ),
              CommonTextInput(
                labeltext: "Name",
                hint: "Enter Name",
                isReadOnly: false,
                inputController:_controller.nameController,
                  errortext: "Enter name",
                  textInputAction: TextInputAction.next
              ),
              CommonTextInput(
                labeltext: "Email",
                hint: "Enter Email",
                isReadOnly: false,
                inputController:_controller.emailController,
                regexp:
                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
                  errortext: "Enter valid email",
                  textInputAction: TextInputAction.next

              ),
              SizedBox(height: 20,),
              TextFormField(

                textInputAction: TextInputAction.next,
                cursorColor:   Constants().mainColor,
                validator: (value) {

                  if (value.toString().isEmpty) {
                    return "Field Required";
                  }
                  return null;
                },
                style: TextStyle(color: Constants().mainColor),
                readOnly: true,
                controller: dobController,
                decoration: InputDecoration(
                  labelStyle:   TextStyle(color:  Constants().mainColor),
                  labelText:"Date of Birth",
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

                      builder: (BuildContext context, Widget child) {
                        return Theme(
                          data: ThemeData.light().copyWith(
                            primaryColor: Constants().mainColor,
                            accentColor: Constants().mainColor,
                            colorScheme: ColorScheme.light(primary: Constants().mainColor),
                            buttonTheme: ButtonThemeData(
                                textTheme: ButtonTextTheme.primary
                            ),
                          ),
                          child: child,
                        );
                      },
                      context: context,
                      initialDate:DateTime.now(),
                      firstDate:DateTime(1900),
                      lastDate: DateTime.now());
                  dobController.text = date.toString().substring(0,10);

                },),
              CommonTextInput(
                  textInputAction: TextInputAction.next,
                inputController: _controller.addressController,
                labeltext: "Address ",
                hint: "Enter Address",
                  errortext: "Enter address"
              ),
              CommonTextInput(
                  textInputAction: TextInputAction.next,
                  labeltext: "State",
                  hint: "Enter State",
                  isReadOnly: false,
                  inputController:_controller.stateController,
                  errortext: "Enter state"
              ),
              CommonTextInput(textInputAction: TextInputAction.next,
                  labeltext: "City",
                  hint: "Enter City",
                  isReadOnly: false,
                  inputController:_controller.cityController,
                  errortext: "Enter city"
              ),
              CommonTextInput(
                  inputController: _controller.pinCodeController,
                  labeltext: "Pincode",
                  hint: "Pincode",
                  textInputType: TextInputType.phone,
                  maxLength: 6,
                  errortext: "Enter valid pincode"
              ),
              CommonButton(
                vPadding: 20,
                hPadding: 20,
                onPressed: (){
                  if(detailsKey.currentState.validate()){
                    LoanModel loanModel = LoanModel(mobile: phoneValue.text,name: _controller.nameController.text, email: _controller.emailController.text,dob: dobController.text,
                    address: _controller.addressController.text,state: _controller.stateController.text,city:_controller.cityController.text,loanType: loanType,pincode: _controller.pinCodeController.text );
                    print("------Validated-------------");
                    Get.to(CheckExistingLoanView(loanModel: loanModel,));
                  }
                  else{
                    print("------Not-Validated-------------");
                  }
                },
                buttonText: "Confirm Details",

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
  CheckExistingLoanView({this.loanModel});
  LoanModel loanModel;

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
          padding: EdgeInsets.only(left: 30.0, right: 30.0, bottom: 15.0, top: 20),


          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CommonText(text: "Please enter if any existing loan is running",fontSize: 28,textColor: Constants().mainColor),
              CommonTextInput(
                  textInputType: TextInputType.phone,
                  labeltext: "Existing Loan",
                  inputController: customerVerificationController.existingLoanController,
                  lableFontSize: 20,
                  lableFontStyle: FontWeight.bold,
                  lableTextColor: Constants().mainColor,
                  regexp: r"^[0-9]{10}$",
                  errortext: "Enter valid Existing loan amount"),
              CommonTextInput(
                  textInputType: TextInputType.phone,
                  labeltext: "Monthly EMI",
                  inputController: customerVerificationController.monthlyEmiController,
                  lableFontSize: 20,
                  lableFontStyle: FontWeight.bold,
                  lableTextColor: Constants().mainColor,
                  regexp: r"^[0-9]{10}$",
                  errortext: "Enter monthly EMI"),
              SizedBox(
                height: 15,
              ),
              CommonButton(
                vPadding: 20,

                  onPressed: () {
                    Get.to(CustomerIncomeDetailsScreen(loanModel: loanModel,emi: customerVerificationController.monthlyEmiController.text,loanAmount:customerVerificationController.existingLoanController.text ,));
                  },
                  context: context,
                  buttonText: "Continue",
                  buttonColor: Constants().mainColor,
                  shdowColor: Colors.lightBlue,
                  buttonTextColor: Colors.white,
                  buttonTextSize: 18,
                  buttonTextStyle: FontWeight.bold),

            ],
          ),
        ),
      ),
    );
  }
}

class CustomerIncomeDetailsScreen extends StatelessWidget {
  CustomerIncomeDetailsScreen({this.phoneValue,this.loanAmount,this.emi,this.loanModel});
  TextEditingController phoneValue;
  String loanAmount,emi;
  LoanModel loanModel;
  CustomerVerificationController _controller = Get.put(CustomerVerificationController());
  GlobalKey<FormState> detailsKey = new GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(centerTitle: true,title: Text("Income details"),),
      body: Container(
        padding: EdgeInsets.only(left: 30.0, right: 30.0, bottom: 15.0, top: 20),
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
              CommonTextInput(
                labeltext: "Experience",
                hint: "Enter Experience",
                isReadOnly: false,
                inputController:_controller.expController,
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
                inputController:_controller.officeAddressController,


              ),
              CommonTextInput(
                labeltext: "Office state",
                hint: "Enter office state name",
                isReadOnly: false,
                inputController:_controller.officeStateController,
                regexp:
                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
                errortext: "Enter valid state",

              ),
              CommonTextInput(
                labeltext: "Office city",
                hint: "Enter office city",
                isReadOnly: false,
                inputController:_controller.officeCityController,
                regexp:
                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
                errortext: "Enter valid city",

              ),
              CommonTextInput(
                  inputController: _controller.officePinCodeController,
                  labeltext: "Office Pincode",
                  hint: "Enter Office PinCode",
                  textInputType: TextInputType.phone,
                  maxLength: 6,
                  errortext: "Enter valid pincode"
              ),
              CommonButton(
                hPadding: 20,
                onPressed: (){
                  if(detailsKey.currentState.validate()){
                    print("-------------Check----------------");
                    print(loanModel.email);
                    SubmitLoadModel submitLoadModel = SubmitLoadModel(
                      loanModel: loanModel,
                      cPincode:  _controller.officePinCodeController.text,
                      cCity: _controller.officeCityController.text,
                      cState: _controller.officeStateController.text,
                      cAdd: _controller.officeAddressController.text,
                      cEmail: _controller.officeEmailController.text,
                      designation: _controller.designationController.text,
                      cName: _controller.companyNameController.text,
                      exp: _controller.expController.text,
                      salary: _controller.monthlySalaryController.text
                    );
                   _controller.checkEligibility(submitLoadModel: submitLoadModel);
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
