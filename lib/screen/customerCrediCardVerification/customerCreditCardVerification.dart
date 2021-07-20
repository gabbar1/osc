import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:upen/commonWidget/commonWidget.dart';
import 'package:upen/screen/CustomerVerification/customerVerificationController.dart';
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
              text: "Please Enter the Customer mobile",
              fontSize: 28,
              textColor: Constants().mainColor),
          Form(
            key: verification,
            child: Padding(
                padding: EdgeInsets.only(top: 20, left: 10, right: 20),
                child: Obx(() => TextFormField(
                      maxLength: 10,
                      keyboardType: TextInputType.phone,
                      controller:
                          customerVerificationController.getVerification,
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
  CustomerVerificationController _controller =
      Get.put(CustomerVerificationController());
  GlobalKey<FormState> detailsKey = new GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Personal details"),
      ),
      body: Container(
        padding:
            EdgeInsets.only(left: 10.0, right: 10.0, bottom: 15.0, top: 20),
        color: Colors.blue[30],
        child: Form(
          key: detailsKey,
          child: ListView(
            children: <Widget>[
              CommonTextInput(
                labeltext: "Mobile No",
                hint: "Enter Mobile No",
                isReadOnly: true,
                inputController: phoneValue,
              ),
              CommonTextInput(
                  labeltext: "Full Name (As per the PanCard)",
                  hint: "Enter Name",
                  isReadOnly: false,
                  inputController: _controller.nameController,
                  errortext: "Enter name"),
              CommonTextInput(
                  labeltext: "Pan Card Number",
                  hint: "Enter Pan Card",
                  isReadOnly: false,
                  inputController: _controller.panController,
                  errortext: "Enter Pan"),
              CommonTextInput(
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
              CommanDateTimePicker(labelText: "Date of Birth"),
              CommonTextInput(
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
                  if (detailsKey.currentState.validate()) {
                    print("------Validated-------------");
                    Get.to(CheckExistingCrediCardView());
                  } else {
                    print("------Not-Validated-------------");
                  }
                },
                buttonText: "Confirm Details",
                vPadding: 20,
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

class CheckExistingCrediCardView extends StatefulWidget {
  @override
  _CheckExistingCrediCardViewState createState() =>
      _CheckExistingCrediCardViewState();
}

class _CheckExistingCrediCardViewState
    extends State<CheckExistingCrediCardView> {
  CustomerVerificationController customerVerificationController =
      Get.put(CustomerVerificationController());

  GlobalKey<FormState> loanKey = new GlobalKey<FormState>();
  SingingCharacter _character = SingingCharacter.yes;
  CreditCard _creditCard = CreditCard.yes;
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
            width: MediaQuery.of(context).size.width * .9,
            //  height: MediaQuery.of(context).size.width * .8,
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
                              textInputType: TextInputType.phone,
                              labeltext: "Company Name",
                              inputController: customerVerificationController
                                  .existingLoanController,
                              lableFontSize: 20,
                              lableFontStyle: FontWeight.bold,
                              lableTextColor: Constants().mainColor,
                              regexp: r"^[0-9]{10}$",
                              errortext: "Enter Company Name"),
                        )
                      : Padding(
                          padding: EdgeInsets.only(left: 20, right: 20),
                          child: CommonTextInput(
                              textInputType: TextInputType.text,
                              labeltext: "Firm Name",
                              inputController: customerVerificationController
                                  .existingLoanController,
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
                              textInputType: TextInputType.phone,
                              labeltext: "Monthly Salary",
                              inputController: customerVerificationController
                                  .monthlyEmiController,
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
                                  .monthlyEmiController,
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
                                  .existingLoanController,
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Income details"),
      ),
      body: Form(
        key: alreadyCards,
        child: ListView.builder(
            itemCount: cardCount,
            itemBuilder: (context, index) {
              totalLimitController.add(TextEditingController());
              availableLimitController.add(TextEditingController());
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
                    DropdownButtonFormField<String>(
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
                    CommonTextInput(
                        inputController: totalLimitController[index],
                        labeltext: "Total Limit"),
                    CommonTextInput(
                        inputController: availableLimitController[index],
                        labeltext: "Available Limit"),
                    SizedBox(
                      height: 15,
                    ),
                    DropdownButtonFormField<String>(
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
                        SizedBox(width: 25,),
                        Center(
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                if(index!=0){
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
            }),
      ),
    );
  }
}
