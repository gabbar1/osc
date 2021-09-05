import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:upen/commonWidget/commonWidget.dart';
import 'package:upen/screen/helper/constant.dart';
import 'package:upen/screen/profile/personalDetails/personalDetailController.dart';

import 'personalDetailModel.dart';

class PersonalDetailsScreen extends StatefulWidget {
  @override
  _PersonalDetailsScreenState createState() => _PersonalDetailsScreenState();
}

class _PersonalDetailsScreenState extends State<PersonalDetailsScreen> {
  TextEditingController dobController = TextEditingController();

  PersonalDetailsController _personalDetailsController = Get.put(PersonalDetailsController());
  File croppedFile;
  @override
  void initState() {
    // TODO: implement initState
    _personalDetailsController.personalDetails();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Personal details"),),
      body: Container(
        padding: EdgeInsets.only(left: 30.0, right: 30.0, bottom: 15.0, top: 20),
        color: Colors.blue[30],
        child: ListView(
          children: <Widget>[
           Obx(()=> Container(decoration: BoxDecoration(
               border: Border.all(color:Constants().borderColor),
               borderRadius: BorderRadius.circular(30)
           ),child:  ListTile(
             title: Text("Name"),
             subtitle: Text(_personalDetailsController.getNameController.text),
           ),),),
            SizedBox(height: 20,),
            Obx(()=>Container(decoration: BoxDecoration(
                border: Border.all(color:Constants().borderColor),
                borderRadius: BorderRadius.circular(30)
            ),child:  ListTile(
              title: Text("Phone Number"),
              subtitle: Text(_personalDetailsController.getPhoneController.text),
            ),),),
            SizedBox(height: 20,),
            Obx(()=>Container(decoration: BoxDecoration(
                border: Border.all(color:Constants().borderColor),
                borderRadius: BorderRadius.circular(30)
            ),child:    ListTile(
              title: Text("Email"),
              subtitle: Text(_personalDetailsController.getEmailController.text),
            ))),
            SizedBox(height: 20,),
            Obx(()=>TextFormField(

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
              controller: _personalDetailsController.getDobController,
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
                _personalDetailsController.dobController.value.text = date.toString().substring(0,10);

              },)),
            Obx(()=>CommonTextInput(
              textInputAction: TextInputAction.next,
              inputController: _personalDetailsController.getAdd1Controller,
              labeltext: "Address Line 1",
              hint: "Address Line 1",
            )),
            Obx(()=>CommonTextInput(
              textInputAction: TextInputAction.next,
              inputController: _personalDetailsController.getAdd2Controller,
              labeltext: "Address Line 2",
              hint: "Address Line 2",
            )),
            Obx(()=>CommonTextInput(
              textInputAction: TextInputAction.next,
              inputController:   _personalDetailsController.getCityController,
              labeltext: "City",
              hint: "Enter City Name",
            )),
            Obx(()=>CommonTextInput(
              textInputAction: TextInputAction.next,
              inputController:   _personalDetailsController.getStateController,
              labeltext: "State",
              hint: "Enter State Name",
            )),
            Obx(()=>CommonTextInput(
              textInputAction: TextInputAction.done,
              inputController:   _personalDetailsController.getPincodeController,
              labeltext: "Pincode",
              hint: "Pincode",
              textInputType: TextInputType.phone,
              maxLength: 6,
            )),

            Obx(() => Container(decoration: BoxDecoration(
                border: Border.all(color:Constants().borderColor),
                borderRadius: BorderRadius.circular(30)
            ),child:  ListTile(
              title: Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text("Occupation Type"),
              ),
              subtitle: Padding(
                padding: EdgeInsets.only(left: 0, right: 20),
                child: Row(
                  children: [
                    CommonText(
                        text: 'Salaried', textColor: Colors.black, fontSize: 18),
                    Radio<SingingCharacter>(
                      activeColor: Constants().mainColor,
                      value: SingingCharacter.a,
                      groupValue: _personalDetailsController.getOccupationType,
                      onChanged: (SingingCharacter value) {
                        setState(() {
                          print("-------------------");

                          _personalDetailsController.occupationType.value = value;
                          _personalDetailsController.occupationType.refresh();
                          print(_personalDetailsController.getOccupationType);
                        });
                      },
                    ),
                    CommonText(
                        text: 'Business', textColor: Colors.black, fontSize: 18),
                    Radio<SingingCharacter>(
                      activeColor: Constants().mainColor,
                      value: SingingCharacter.b,
                      groupValue: _personalDetailsController.getOccupationType,
                      onChanged: (SingingCharacter value) {

                          _personalDetailsController.occupationType.value = value;
                          _personalDetailsController.occupationType.refresh();
                        print(_personalDetailsController.getOccupationType);
                      },
                    )
                  ],
                ),
              ),
            ),),),
            SizedBox(height: 20,),
            InkWell(
              onTap: (){
                _showPicker();
                print("-------------------------path----------");
                print(_personalDetailsController.getFilePath.path);
              },
              child:Obx(()=>_personalDetailsController.getFilePath.path.isBlank  ? Container(
                width: 40,
                height: 180,
                decoration: BoxDecoration(
                  image: DecorationImage(image:NetworkImage(_personalDetailsController.getDocumentUrl),fit: BoxFit.fill),
                  border: Border.all(),
                  color: Colors.grey.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Icon(Icons.camera_alt,size: 60,color: Colors.grey),
              ):Container(
                width: 40,
                height: 180,
                decoration: BoxDecoration(
                  image: DecorationImage(image:FileImage(_personalDetailsController.getFilePath),fit: BoxFit.fill),
                  border: Border.all(),
                  color: Colors.grey.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Icon(Icons.camera_alt,size: 60,color: Colors.grey),
              )),
            ),
            SizedBox(
              height: 25,
            ),
            SizedBox(height: 15,),
            CommonButton(
              onPressed: (){
                _personalDetailsController.uploadFile(_personalDetailsController.getFilePath);


              },
              buttonText: "Submit",
              vPadding: 15,
              buttonColor: Constants().appBarColor,
            ),
          ],
        ),
      ),
    );
  }

  final ImagePicker _picker = ImagePicker();
  void _showPicker() {
    showModalBottomSheet(
        context: Get.context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Photo Library'),
                      onTap: () {
                        _imgFromGallery();
                        Navigator.of(Get.context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Camera'),
                    onTap: () {
                      _imgFromCamera();
                      Navigator.of(Get.context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  _imgFromCamera() async {

    final pickedFile = await _picker.pickImage(
        source: ImageSource.camera);
    if (pickedFile != null) {
      displayImageOptions(pickedFile.path);
    } else {
      print('No image selected.');
    }

  }

  _imgFromGallery() async {
    final pickedFile = await _picker.pickImage(
        source: ImageSource.gallery);

    if (pickedFile != null) {
      displayImageOptions(pickedFile.path);
    } else {
      print('No image selected.');
    }

  }

  Future<void> displayImageOptions(String path) async {

    croppedFile = await ImageCropper.cropImage(
        sourcePath: path,
        aspectRatioPresets: [CropAspectRatioPreset.ratio16x9],
        androidUiSettings: AndroidUiSettings(
            toolbarTitle: "Adjust Image",
            toolbarColor: Constants().mainColor,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.ratio16x9,
            lockAspectRatio: true),
        iosUiSettings: IOSUiSettings(minimumAspectRatio: 1.0));
    _personalDetailsController.setFilePath(croppedFile);




  }
}



