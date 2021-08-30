import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:upen/commonWidget/commonWidget.dart';
import 'package:upen/commonWidget/dateTimePickerFromTextField.dart';
import 'package:upen/screen/CustomerVerification/customerVerificationController.dart';
import 'package:upen/screen/customerCrediCardVerification/creditCardController.dart';
import 'package:upen/screen/customerCrediCardVerification/creditCardModel.dart';
import 'package:upen/screen/helper/constant.dart';
import 'package:contacts_service/contacts_service.dart';

class CustomerCreditCardVerificationView extends StatelessWidget {
  int productID;

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
          CommonText(
              text: "Please enter the customer mobile",
              fontSize: 28,
              textColor: Constants().mainColor),
          Form(
            key: verification,
            child: Padding(
                padding: EdgeInsets.only(left: 30.0, right: 30.0, bottom: 15.0, top: 20),
                child: Obx(() => TextFormField(
                      maxLength: 10,
                      keyboardType: TextInputType.phone,
                      controller:
                          customerVerificationController.getVerification,
                      style: TextStyle(color: Constants().mainColor),
                      decoration: InputDecoration(
                        labelStyle:   TextStyle(color:  Constants().mainColor),
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
                      validator: (val) {
                        if (val.toString().isEmpty ||
                            val.toString().length < 10) {
                          return "enter valid phone";
                        }
                        return null;
                      },
                    ))),
          ),
          CommonButton(

              vPadding: 20,
              onPressed: () {
                if (verification.currentState.validate()) {
                  print("Validated");
                  print("---------------------------");
                  print(customerVerificationController.getVerification.text);
                  Get.to(CustomerDetailsScreen(
                    phoneValue: customerVerificationController.getVerification,
                  ));
                } else {
                  print("not validated");
                }
              },
              buttonColor: Constants().mainColor,
              buttonText: "next")
        ],
      ),
    );
  }
}

class CustomerDetailsScreen extends StatelessWidget {
  CustomerDetailsScreen({this.phoneValue});
  TextEditingController phoneValue;
  TextEditingController dobController = TextEditingController();
  CustomerVerificationController _controller =
      Get.put(CustomerVerificationController());
  GlobalKey<FormState> detailsKey = new GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
  //  _controller.setDob(DateTime.now().toString().substring(0,10));
    return Scaffold(

      appBar: AppBar(
        centerTitle: true,
        title: Text("Personal details"),
      ),
      body: Container(
        padding: EdgeInsets.only(left: 30.0, right: 30.0, bottom: 15.0, top: 20),

        child: Form(
          key: detailsKey,
          child: ListView(
            children: <Widget>[
              CommonTextInput(
                textInputAction: TextInputAction.next,
                labeltext: "Mobile No",
                hint: "Enter Mobile No",
                isReadOnly: true,
                inputController: phoneValue,
              ),
              CommonTextInput(
                  textInputAction: TextInputAction.next,
                  labeltext: "Full Name (As per the PanCard)",
                  hint: "Enter Name",
                  isReadOnly: false,
                  inputController: _controller.nameController,
                  errortext: "Enter name"),
              CommonTextInput(
                  textInputAction: TextInputAction.next,
                  labeltext: "Pan Card Number",
                  hint: "Enter Pan Card",
                  isReadOnly: false,
                  inputController: _controller.panController,
                  errortext: "Enter Pan"),
              CommonTextInput(
                textInputAction: TextInputAction.next,
                labeltext: "Email",
                hint: "Enter Email",
                isReadOnly: false,
                inputController: _controller.emailController,
                regexp:
                    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
                errortext: "Enter valid email",
              ),
              SizedBox(
                height: 20,
              ),
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
                  errortext: "Enter address"),
              CommonTextInput(
                  inputController: _controller.pinCodeController,
                  labeltext: "Pincode",
                  hint: "Pincode",
                  textInputType: TextInputType.phone,
                  maxLength: 6,
                  errortext: "Enter valid pincode"),
              SizedBox(
                height: 20,
              ),
              CommonButton(
                onPressed: () {
                  DatePicker datePicker = DatePicker();
                  if (detailsKey.currentState.validate()) {
                    print("------Validated----Dates-------------");
                    print(dobController.text);
                    Get.to(CheckExistingCreditCardView(
                      phone: phoneValue.text,
                      name: _controller.nameController.text,
                      email: _controller.emailController.text,
                      dob:  dobController.text,
                      address: _controller.addressController.text,
                      pan: _controller.panController.text,
                      pinCode: _controller.pinCodeController.text,
                    ));
                  } else {
                    print("------Not-Validated-------------");
                  }
                },
                buttonText: "Confirm Details",
                vPadding: 20,
                hPadding: 20,
                buttonColor: Constants().mainColor,
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

enum SingingCharacter { yes, no }
enum CreditCard { yes, no }

class CheckExistingCreditCardView extends StatefulWidget {
  String phone, name, pan, email, dob, address, pinCode;
  CheckExistingCreditCardView(
      {this.name,
      this.phone,
      this.pan,
      this.address,
      this.email,
      this.dob,
      this.pinCode});
  @override
  _CheckExistingCreditCardViewState createState() =>
      _CheckExistingCreditCardViewState();
}

class _CheckExistingCreditCardViewState
    extends State<CheckExistingCreditCardView> {
  CustomerVerificationController customerVerificationController =
      Get.put(CustomerVerificationController());

  GlobalKey<FormState> loanKey = new GlobalKey<FormState>();
  SingingCharacter _character = SingingCharacter.yes;
  CreditCard _creditCard = CreditCard.yes;
  CreditCardController _creditCardController = Get.put(CreditCardController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Professional Details"),
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(left: 30.0, right: 30.0, bottom: 15.0, top: 20),
            child: Form(
              key: loanKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 20, right: 20),
                    child: CommonText(
                        text: "Are you salaried ?",
                        textColor: Constants().mainColor,
                        fontSize: 28,
                        fontStyle: FontWeight.bold),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 20, right: 20),
                    child: Row(
                      children: [
                        CommonText(
                            text: 'Yes', textColor: Colors.black, fontSize: 18),
                        Radio<SingingCharacter>(
                          activeColor: Constants().mainColor,
                          value: SingingCharacter.yes,
                          groupValue: _character,
                          onChanged: (SingingCharacter value) {
                            setState(() {
                              print("-------------------");
                              print(_character);
                              _character = value;
                            });
                          },
                        ),
                        CommonText(
                            text: 'No', textColor: Colors.black, fontSize: 18),
                        Radio<SingingCharacter>(
                          activeColor: Constants().mainColor,
                          value: SingingCharacter.no,
                          groupValue: _character,
                          onChanged: (SingingCharacter value) {
                            setState(() {
                              _character = value;
                            });
                          },
                        )
                      ],
                    ),
                  ),
                  _character == SingingCharacter.yes
                      ? Padding(
                          padding: EdgeInsets.only(left: 20, right: 20),
                          child: CommonTextInput(
                              textInputAction: TextInputAction.next,
                              textInputType: TextInputType.name,
                              labeltext: "Company Name",
                              inputController: customerVerificationController
                                  .companyNameController,
                              lableFontSize: 20,
                              lableFontStyle: FontWeight.bold,
                              lableTextColor: Constants().mainColor,
                              regexp: r"^[0-9]{10}$",
                              errortext: "Enter Company Name"),
                        )
                      : Padding(
                          padding: EdgeInsets.only(left: 20, right: 20),
                          child: CommonTextInput(
                              textInputAction: TextInputAction.next,
                              textInputType: TextInputType.text,
                              labeltext: "Firm Name",
                              inputController: customerVerificationController
                                  .firmNameController,
                              lableFontSize: 20,
                              lableFontStyle: FontWeight.bold,
                              lableTextColor: Constants().mainColor,
                              regexp: r"^[0-9]{10}$",
                              errortext: "Enter Firm Name"),
                        ),
                  _character == SingingCharacter.yes
                      ? Padding(
                          padding: EdgeInsets.only(left: 20, right: 20),
                          child: CommonTextInput(
                              textInputAction: TextInputAction.next,
                              textInputType: TextInputType.phone,
                              labeltext: "Monthly Salary",
                              inputController: customerVerificationController
                                  .monthlySalaryController,
                              lableFontSize: 20,
                              lableFontStyle: FontWeight.bold,
                              lableTextColor: Constants().mainColor,
                              regexp: r"^[0-9]{10}$",
                              errortext: "Enter monthly salary"),
                        )
                      : Padding(
                          padding: EdgeInsets.only(left: 20, right: 20),
                          child: CommonTextInput(
                              textInputType: TextInputType.phone,
                              labeltext: "Latest ITR Amount",
                              inputController: customerVerificationController
                                  .itrController,
                              lableFontSize: 20,
                              lableFontStyle: FontWeight.bold,
                              lableTextColor: Constants().mainColor,
                              regexp: r"^[0-9]{10}$",
                              errortext: "Enter ITR Amount"),
                        ),
                  _character == SingingCharacter.yes
                      ? Padding(
                          padding: EdgeInsets.only(left: 20, right: 20),
                          child: CommonTextInput(
                              textInputType: TextInputType.phone,
                              labeltext: "Designation",
                              inputController: customerVerificationController
                                  .designationController,
                              lableFontSize: 20,
                              lableFontStyle: FontWeight.bold,
                              lableTextColor: Constants().mainColor,
                              regexp: r"^[0-9]{10}$",
                              errortext: "Enter Designation"),
                        )
                      : SizedBox(),
                  SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 20, right: 20),
                    child: CommonText(
                        text: "Do you have other credit card ?",
                        textColor: Constants().mainColor,
                        fontSize: 18,
                        fontStyle: FontWeight.bold),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 20, right: 20),
                    child: Row(
                      children: [
                        CommonText(
                            text: 'Yes', textColor: Colors.black, fontSize: 18),
                        Radio<CreditCard>(
                          activeColor: Constants().mainColor,
                          value: CreditCard.yes,
                          groupValue: _creditCard,
                          onChanged: (CreditCard value) {
                            setState(() {
                              print("-------------------");
                              print(_character);
                              _creditCard = value;
                            });
                          },
                        ),
                        CommonText(
                            text: 'No', textColor: Colors.black, fontSize: 18),
                        Radio<CreditCard>(
                          activeColor: Constants().mainColor,
                          value: CreditCard.no,
                          groupValue: _creditCard,
                          onChanged: (CreditCard value) {
                            setState(() {
                              _creditCard = value;
                            });
                          },
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Center(
                    child: CommonButton(
                      vPadding: 20,
                        onPressed: () {
                          print("-----Clicked------");
                          print(widget.dob);
                          if (loanKey.currentState.validate()) {
                            print("Validated");
                            if (_creditCard == CreditCard.yes) {
                              Get.to(CustomerIncomeDetailsScreen(phone: widget.phone,itr:customerVerificationController.itrController.text,alreadyCreditCard: _creditCard == CreditCard.yes ? true:false,address: customerVerificationController.addressController.text,name: widget.name,email: widget.email,dob: widget.dob,pan: widget.pan,pinCode: widget.pinCode,companyName: customerVerificationController.companyNameController.text,designation: customerVerificationController.designationController.text,firmName: customerVerificationController.firmNameController.text,salaried: _character == SingingCharacter.yes ? true : false,monthlySalary: customerVerificationController.monthlySalaryController.text ,));
                            }
                            else{
                              _creditCardController.checkEligibility(salaried:_character==SingingCharacter.no ? false :true,monthlySalary:customerVerificationController.monthlySalaryController.text,firmName: customerVerificationController.firmNameController.text,designation:customerVerificationController.designationController.text,companyName: customerVerificationController.companyNameController.text,pinCode: widget.pinCode,pan: widget.pan,dob: widget.dob,email: widget.email,name: widget.name,phone: widget.phone,address: widget.address,alreadyCreditCard: _character ==SingingCharacter.yes ? true:false,itr: customerVerificationController.itrController.text,creditCardList:  _creditCardController.getAlreadyCardList );

                            }
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
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class CustomerIncomeDetailsScreen extends StatefulWidget {
  String phone,
      name,
      pan,
      email,
      dob,
      address,
      pinCode,
      companyName,
      monthlySalary,
      designation,
      firmName,
      itr;
  bool salaried, alreadyCreditCard;
  CustomerIncomeDetailsScreen(
      {this.name,
      this.phone,
      this.pan,
      this.address,
      this.email,
      this.dob,
      this.pinCode,
      this.itr,
      this.companyName,
      this.alreadyCreditCard,
      this.designation,
      this.firmName,
      this.monthlySalary,
      this.salaried});

  @override
  _CustomerIncomeDetailsScreenState createState() =>
      _CustomerIncomeDetailsScreenState();
}

class _CustomerIncomeDetailsScreenState
    extends State<CustomerIncomeDetailsScreen> {
  int cardCount = 1;
  List<TextEditingController> totalLimitController = List();
  List<TextEditingController> availableLimitController = List();
  List<String> cardName = <String>[];
  List<String> cardVintage = <String>[];
  GlobalKey<FormState> alreadyCards = new GlobalKey<FormState>();
  CreditCardController _creditCardController = Get.put(CreditCardController());
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Income details"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height-200,
              child: Form(
                key: alreadyCards,
                child: ListView.builder(
                    itemCount: cardCount,
                    itemBuilder: (context, index) {
                      totalLimitController.add(TextEditingController());
                      availableLimitController.add(TextEditingController());
                      if (index == cardCount) {
                        return SizedBox(
                          height: 100,
                          width: 100,
                        );
                      } else {
                        return Card(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 15,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: CommonText(
                                    text: "Existing Credit Card ",
                                    fontSize: 18,
                                    textColor: Constants().mainColor),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: DropdownButtonFormField<String>(
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    labelText: "Select State",
                                  ),
                                  items: <String>['--Select Bank--', 'Axis', 'BOB']
                                      .map((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: CommonText(
                                          text: value, textColor: Constants().mainColor),
                                    );
                                  }).toList(),
                                  validator: (value) {
                                    print("-----------ValidatedOr not------------");
                                    print(value);
                                    if (value == null) {
                                      return 'Field required';
                                    }
                                    return null;
                                  },
                                  onChanged: (val) {
                                    setState(() {
                                      cardName.add(val);
                                    });
                                  },
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: CommonTextInput(
                                    inputController: totalLimitController[index],
                                    labeltext: "Total Limit"),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: CommonTextInput(
                                    inputController: availableLimitController[index],
                                    labeltext: "Available Limit"),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: DropdownButtonFormField<String>(
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    labelText: "Card Vintage",
                                  ),
                                  items: <String>[
                                    '--Select Duration--',
                                    '1 year',
                                    '2 years'
                                  ].map((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: CommonText(
                                          text: value, textColor: Constants().mainColor),
                                    );
                                  }).toList(),
                                  validator: (value) {
                                    print("-----------ValidatedOr not------------");
                                    print(value);
                                    if (value == null) {
                                      return 'Field required';
                                    }
                                    return null;
                                  },
                                  onChanged: (val) {
                                    print(
                                        "-------------------Selected___________________--");
                                    print(val);
                                    setState(() {
                                      cardVintage.add(val);
                                    });
                                  },
                                ),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Center(
                                    child: InkWell(
                                      onTap: () {
                                        setState(() {
                                          if (alreadyCards.currentState.validate()) {
                                            cardCount = cardCount + 1;
                                            print(cardCount);
                                            print("------------------------");
                                            print(ValueKey(index));
                                            print(totalLimitController[index].text);
                                            print(availableLimitController[index].text);
                                            print(cardName);
                                            print(index);
                                            print(cardVintage);
                                          } else {
                                            alreadyCards.currentState.validate();
                                          }
                                        });
                                      },
                                      child: Container(
                                        height: 25,
                                        width: MediaQuery.of(context).size.width / 4,
                                        decoration: BoxDecoration(
                                            color: Constants().mainColor,
                                            borderRadius:
                                                BorderRadius.all(Radius.circular(5))),
                                        child: Center(
                                          child: Icon(
                                            Icons.add,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 25,
                                  ),
                                  Center(
                                    child: InkWell(
                                      onTap: () {
                                        setState(() {
                                          if (index != 0) {
                                            cardCount = cardCount - 1;
                                            print(cardCount);
                                            print("------------------------");
                                            print(ValueKey(index));
                                            totalLimitController.removeAt(index);
                                            availableLimitController.removeAt(index);
                                            cardVintage.removeAt(index);
                                            cardName.removeAt(index);
                                            print(totalLimitController[index].text);
                                            print(availableLimitController[index].text);
                                            print(cardName);
                                            print(index);
                                            print(cardVintage);
                                          }
                                        });
                                      },
                                      child: Container(
                                        height: 25,
                                        width: MediaQuery.of(context).size.width / 4,
                                        decoration: BoxDecoration(
                                            color: Colors.grey,
                                            borderRadius:
                                                BorderRadius.all(Radius.circular(5))),
                                        child: Center(
                                          child: Icon(
                                            Icons.remove,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 15,
                              ),
                            ],
                          ),
                        );
                      }
                    }),
              ),
            ),

            CommonButton(
               onPressed: (){
                 _creditCardController.alreadyCardList.clear();
                 for(int i =0 ;i<cardCount;i++){
                   print("--------------CardDetails-------------------");
                   CreditCardModel creditCardModel  = CreditCardModel(bankName:cardName[i],availableLimit:availableLimitController[i].text ,totalLimit: totalLimitController[i].text,vintage:cardVintage[i]  );
                   _creditCardController.setCardList(creditCardModel);
                  print( _creditCardController.getAlreadyCardList.length);
                 }
                 print("---------------eligible-----------");
                 print(widget.dob);
                 _creditCardController.checkEligibility(salaried:widget.salaried,monthlySalary:widget.monthlySalary,firmName: widget.firmName,designation: widget.designation,companyName: widget.companyName,pinCode: widget.pinCode,pan: widget.pan,dob: widget.dob,email: widget.email,name: widget.name,phone: widget.phone,address: widget.address,alreadyCreditCard: widget.alreadyCreditCard,itr: widget.itr,creditCardList:  _creditCardController.getAlreadyCardList );
               },
                buttonText: "Submit",
                context: context,
                buttonColor: Constants().mainColor),
          ],
        ),
      ),

    );
  }
}
