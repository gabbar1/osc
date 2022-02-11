import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:html/parser.dart';
import 'package:share/share.dart';
import 'package:upen/commonWidget/commonWidget.dart';
import 'package:upen/screen/helper/constant.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import 'controller/partner_controller.dart';
import 'customer_details.dart';
import 'model/leadModel.dart';
import 'model/referModel.dart';
import 'package:flutter_html/flutter_html.dart';
class ReferInfoView extends StatefulWidget {

  ReferModel referModel;
  ReferInfoView({this.referModel});

  @override
  _ReferInfoViewState createState() => _ReferInfoViewState();
}

class _ReferInfoViewState extends State<ReferInfoView> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  PartnerController _partnerController = Get.put(PartnerController());
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  List<String> productInstructionList = <String>["Benefits","Description","How to Earn","FAQ's"];
  YoutubePlayerController _controller;
  @override
  void initState() {
    // TODO: implement initState
    nameController.clear();
    emailController.clear();
    phoneController.clear();
    _partnerController.referralInfo(widget.referModel.key);
    _partnerController.setCategoryIndex(0);

    _controller = YoutubePlayerController(
      initialVideoId:widget.referModel.youtube,

      flags: YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
      ),

    );
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    print(_partnerController.getAboutList.length);

    return Scaffold(
      appBar: AppBar(
        title: CommonText(
          text: widget.referModel.name
        ),
      ),
      body: Column(children: [
        SizedBox(height: 10,),
        SizedBox(
          height: 50,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
             itemCount: productInstructionList.length,
              itemBuilder: (context,index){
            return Padding(
              padding: const EdgeInsets.only(left: 10,right: 10),
              child: InkWell(
                onTap: (){
                  _partnerController.setCategoryIndex(index);
                },
                child: Container(

                  padding: EdgeInsets.only(left: 20,right: 20,top: 10,bottom: 10),
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [
                            const Color(0xFFD88BBC),
                            const Color(0xFF9361A8),
                          ],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          stops: [0.0, 2.0],
                          tileMode: TileMode.clamp),
                      color: Colors.white24,
                      borderRadius: BorderRadius.all(Radius.circular(5))
                  ),
                  child: Center(child: CommonText(
                      text: productInstructionList[index]
                  )),
                ),
              ),
            );
          }),
        ),
        Expanded(child: Obx((){
          if(_partnerController.getCategoryIndex ==0){
            return about();
          }else if (_partnerController.getCategoryIndex ==1){
            return knowMore();
          }else if(_partnerController.getCategoryIndex ==2){
            return howToEarn();
          }else{
            return faq();

          }
        }))
      ],),
      floatingActionButton: Row(

        mainAxisAlignment: MainAxisAlignment.center,
        children: [
        InkWell(
          onTap: (){
            final RenderBox box = Get.context.findRenderObject();
            widget.referModel.name;
            widget.referModel.price;
            var referralID =FirebaseAuth.instance.currentUser.phoneNumber.replaceAll("+91", "");
            Share.share("https://cardkarobar.in/referal.html?id=$referralID&product=${widget.referModel.name}&price=${widget.referModel.price}", sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);

          },
          child: Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Container(

                height: 50,
                width: MediaQuery.of(context).size.width/2.5,
                //width: 300,
                decoration: const BoxDecoration(
                    color: Color(0xffFFFFFF),
                    borderRadius: BorderRadius.all(
                      Radius.circular(5.0),
                    )),
                child: Center(
                  child: Text(
                    "Refer To Customer",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                  ),
                )
            ),
          ),
        ),
        SizedBox(width: 10,),
        InkWell(
          onTap: (){
            nameController.clear();
            emailController.clear();
            phoneController.clear();
            showModalBottomSheet(
                backgroundColor: Constants().appBackGroundColor,
                isScrollControlled: true,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(30),topRight: Radius.circular(30)),
                ),
                context: context,
                builder: (context){
                  return Form(
                  key:_formKey ,
                      child: SizedBox(
                    height: MediaQuery.of(context).size.width,
                    child: Padding(
                      padding: MediaQuery.of(context).viewInsets,

                        child: Container(
                          height: 400,
                          padding: EdgeInsets.only(left: 20,right: 20),
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 25,),
                                CommonText(text: "Customer Details",fontSize: 20),
                                SizedBox(height: 25,),
                                CommonTextInput1(textInputAction: TextInputAction.next,hint: "Enter Name",labeltext: "Name",inputController:nameController ),
                                SizedBox(height: 10,),
                                CommonTextInput1(textInputAction: TextInputAction.next,hint: "Enter Email",labeltext: "Email",inputController:emailController ),
                                SizedBox(height: 10,),
                                CommonTextInput1(maxLines: 10,textInputType: TextInputType.number,textInputAction: TextInputAction.done,hint: "Enter Phone",labeltext: "Phone",inputController:phoneController ),
                                SizedBox(height: 20,),
                                Center(
                                  child: CommonButton(
                                      buttonText: "Submit",
                                      buttonColor: Constants().mainColor,
                                      vPadding: 20,
                                      onPressed: (){
                                        if(_formKey.currentState.validate()){

                                          LeadModel leadModel = LeadModel(status: "submitted",
                                            customerEmail:emailController.text,
                                            customerName: nameController.text,
                                            customerPhone: int.parse(phoneController.text),
                                            product: widget.referModel.name,
                                            referralId: int.parse(FirebaseAuth.instance.currentUser.phoneNumber.replaceAll("+91", "")),
                                            referralPrice: widget.referModel.price,
                                            time: Timestamp.now(),
                                          );
                                          _partnerController.submitReferral(leadModel,widget.referModel.url);
                                        }
                                      }
                                  ),
                                ),
                                SizedBox(height: 20,),
                              ],),
                          ),
                        ),
                      
                    ),
                  )
                  );
                }
            );

          },
          child: Container(
              height: 50,
              width: MediaQuery.of(context).size.width/2.5,
              //width: 300,
              decoration: const BoxDecoration(
                  color: Color(0xffFFFFFF),
                  borderRadius: BorderRadius.all(
                    Radius.circular(5.0),
                  )),
              child: Center(
                child: Text(
                  "Open Account",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                ),
              )
          ),
        ),
      ],),
    );
  }

  Widget about(){

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
        Padding(
          padding: const EdgeInsets.only(left: 10,top: 10),
          child: CommonText(text: "Watch video for steps to sell",fontSize: 20),
        ),
        SizedBox(height: 20,),
        Padding(
          padding: const EdgeInsets.only(left: 20,right: 20),
          child: YoutubePlayer(

            controller: _controller,
            showVideoProgressIndicator: true,
            onReady: (){

            },
          ),
        ),
          SizedBox(height: 20,),
        ListView.builder(

            shrinkWrap: true,
            itemCount: _partnerController.getAboutList.length,
            itemBuilder: (context,index){
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(

                  padding: EdgeInsets.only(left: 20,right: 20,bottom: 0),
                  child: Html(
                    data: _partnerController.getAboutList[index].html,
                    style: {
                      "body": Style(
                        margin: EdgeInsets.zero, padding: EdgeInsets.zero,


                      )
                    },


                  ),
                ),
              );
            }),

      ],),
    );
  }
  Widget faq(){
    return ListView.builder(
        padding: EdgeInsets.only(bottom: 100),
        shrinkWrap: true,
        itemCount: _partnerController.getFaqList.length,
        itemBuilder: (context,index){
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(

              padding: EdgeInsets.only(left: 20,right: 20,bottom: 0),

              child: Html(
                data: _partnerController.getFaqList[index].html,
                style: {
                  "body": Style(
                    margin: EdgeInsets.zero, padding: EdgeInsets.zero,

                  )
                },

              ),
            ),
          );
        });
  }
  Widget howToEarn(){
    return ListView.builder(
      padding: EdgeInsets.only(bottom: 100),
        shrinkWrap: true,
        itemCount: _partnerController.getHowToEarnListList.length,
        itemBuilder: (context,index){
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(

              padding: EdgeInsets.only(left: 20,right: 20,bottom: 0),

              child: Html(
                data: _partnerController.getHowToEarnListList[index].html,
                style: {
                  "body": Style(
                    margin: EdgeInsets.zero, padding: EdgeInsets.zero,

                  )
                },

              ),
            ),
          );
        });
  }
  Widget knowMore(){
    return ListView.builder(
        padding: EdgeInsets.only(bottom: 100),
        shrinkWrap: true,
        itemCount: _partnerController.getKnowMoreList.length,
        itemBuilder: (context,index){
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(

              padding: EdgeInsets.only(left: 20,right: 20,bottom: 0),

              child: Html(
                data: _partnerController.getKnowMoreList[index].html,
                style: {
                  "body": Style(
                    margin: EdgeInsets.zero, padding: EdgeInsets.zero,

                  )
                },

              ),
            ),
          );
        });
  }
}
