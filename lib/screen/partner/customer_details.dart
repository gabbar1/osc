import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:upen/commonWidget/commonWidget.dart';
import 'package:upen/screen/helper/constant.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'controller/partner_controller.dart';
import 'model/leadModel.dart';

class ReferCustomerDetail extends StatelessWidget {


  PartnerController _referController = Get.put(PartnerController());
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {



    return Scaffold(
      appBar: AppBar(
        title: Text("Partners"),
        centerTitle: true,
      ),
      body: Obx(() => _referController.getReferList.isEmpty ? Center(
        child: CircularProgressIndicator(
          valueColor:
          new AlwaysStoppedAnimation<Color>(Constants().mainColor),
        ),
      ):Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
            itemCount: _referController.getReferList.length,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  nameController.clear();
                  emailController.clear();
                  phoneController.clear();
                  YoutubePlayerController _controller = YoutubePlayerController(
                    initialVideoId:_referController.getReferList[index].youtube,
                    flags: YoutubePlayerFlags(
                      autoPlay: true,
                      mute: false,
                    ),
                  );
                  CommonBottomSheet().bottomSheet(
                      context: Get.context, title: "User Information",
                      content: Padding(
                        padding: const EdgeInsets.only(left: 20,right: 20),
                        child: Form(
                          key:_formKey ,
                          child: Column(children: [
                            CommonTextInput1(textInputAction: TextInputAction.next,hint: "Enter Name",labeltext: "Name",inputController:nameController ),
                            SizedBox(height: 10,),
                            CommonTextInput1(textInputAction: TextInputAction.next,hint: "Enter Email",labeltext: "Email",inputController:emailController ),
                            SizedBox(height: 10,),
                            CommonTextInput1(textInputType: TextInputType.number,textInputAction: TextInputAction.done,hint: "Enter Phone",labeltext: "Phone",inputController:phoneController ),
                            SizedBox(height: 20,),
                            CommonButton(
                                buttonText: "Submit",
                                buttonColor: Constants().mainColor,
                                vPadding: 20,
                                onPressed: (){
                                  if(_formKey.currentState.validate()){

                                    LeadModel leadModel = LeadModel(status: "submitted",
                                      customerEmail:emailController.text,
                                      customerName: nameController.text,
                                      customerPhone: int.parse(phoneController.text),
                                      product: _referController.getReferList[index].name,
                                      referralId: int.parse(FirebaseAuth.instance.currentUser.phoneNumber.replaceAll("+91", "")),
                                      referralPrice: _referController.getReferList[index].price,
                                      time: Timestamp.now(),
                                    );
                                    _referController.submitReferral(leadModel,_referController.getReferList[index].url);
                                  }
                                }
                            ),
                          ],),
                        ),
                      ));
                },
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10.0),
                        child: CachedNetworkImage(
                            height: MediaQuery.of(context).size.height/5,
                            width: MediaQuery.of(context).size.width,
                            fit: BoxFit.fill,
                            imageUrl:
                            _referController.getReferList[index].banner),
                      ),
                      Positioned(
                          right: 20,
                          top: 20,
                          child: CommonText(
                              text: "Earn " +
                                  _referController.getReferList[index].price
                                      .toString(),
                              fontStyle: FontWeight.w500,
                              textColor: Colors.black,

                              fontSize: 18))
                    ],
                  ),
                ),
              );
            }),
      )),
    );
  }
}


