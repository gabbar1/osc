import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:upen/commonWidget/commonWidget.dart';
import 'package:upen/screen/helper/constant.dart';
import 'package:upen/screen/profile/bankDetails/bankDetail_controller.dart';

class BankDetailsScreen extends StatefulWidget {
  @override
  _BankDetailsScreenState createState() => _BankDetailsScreenState();
}

class _BankDetailsScreenState extends State<BankDetailsScreen> {


  File croppedFile;
  BankDetailsController _detailsController = Get.put(BankDetailsController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Bank Details"),
      ),
      body: Container(
        padding: EdgeInsets.only(left: 30.0, right: 30.0, bottom: 15.0, top: 20),
        color: Colors.white70,
        child: ListView(
          children: [
            Obx(()=>CommonTextInput(
              inputController: _detailsController.getBankNameController,
              textInputAction: TextInputAction.next,
              labeltext: "Bank Name",
            )),
            Obx(()=> CommonTextInput(
              inputController: _detailsController.getNameController,
              textInputAction: TextInputAction.next,
              labeltext: "Name as per bank record",
            )),
            Obx(()=>CommonTextInput(
              inputController: _detailsController.getAccountNumberController,
              textInputAction: TextInputAction.next,
              labeltext: "Account Number",
              textInputType: TextInputType.phone,
            )),
            Obx(()=>CommonTextInput(
              inputController: _detailsController.getIFSCController,
              textInputAction: TextInputAction.next,
              labeltext: "IFSC Code",
            )),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: CommonText(
                  text: "Upload cancelled cheque or passbook",
                  textColor: Constants().mainColor),
            ),
            Obx(()=>CommonTextInput(
              inputController: _detailsController.getDocTypeController,
              labeltext: "Enter Document Type",
            )),
            SizedBox(
              height: 20,
            ),
            InkWell(
              onTap: (){
                _showPicker();
                print("-------------------------path----------");
                print(_detailsController.getFilePath.path);
              },
              child:Obx(()=>_detailsController.getFilePath.path.isBlank  ? Container(
                width: 40,
                height: 180,
                decoration: BoxDecoration(
                  image: DecorationImage(image:NetworkImage(_detailsController.getDocumentUrl),fit: BoxFit.fill),
                  border: Border.all(),
                  color: Colors.grey.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Icon(Icons.camera_alt,size: 60,color: Colors.grey),
              ):Container(
                width: 40,
                height: 180,
                decoration: BoxDecoration(
                  image: DecorationImage(image:FileImage(_detailsController.getFilePath),fit: BoxFit.fill),
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
            CommonButton(
              onPressed: () {
                _detailsController.uploadFile(_detailsController.getFilePath);
              },
              buttonText: "Submit",
              buttonColor: Constants().mainColor,
              vPadding: 15.0,
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
    _detailsController.setFilePath(croppedFile);




  }



  @override
  void initState() {
    _detailsController.bankDetails();
  }
}



