import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:upen/commonWidget/commonWidget.dart';
import 'package:upen/screen/helper/constant.dart';
import 'package:upen/screen/partner/controller/partner_controller.dart';
import 'refer_info_view.dart';

class ReferPartnerView extends StatefulWidget {
  String videoID;
  String category;
  ReferPartnerView({this.videoID,this.category});
  @override
  _ReferPartnerViewState createState() => _ReferPartnerViewState();
}

class _ReferPartnerViewState extends State<ReferPartnerView> {
  PartnerController _PartnerController = Get.put(PartnerController());
  @override
  void initState() {
    // TODO: implement initState
    _PartnerController.referralPartners(false,widget.category);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {



    return Scaffold(
      appBar: AppBar(
        title: Text("Partners"),
        centerTitle: true,
      ),
      body: Obx(() => _PartnerController.getReferList.isEmpty ? Center(
        child: CircularProgressIndicator(
          valueColor:
          new AlwaysStoppedAnimation<Color>(Constants().mainColor),
        ),
      ):Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView.builder(
                itemCount: _PartnerController.getReferList.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Get.to(ReferInfoView(referModel: _PartnerController.getReferList[index],));
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
                                    _PartnerController.getReferList[index].banner),
                          ),
                          Positioned(
                              right: 20,
                              top: 20,
                              child: CommonText(
                                  text: "Earn " +
                                      _PartnerController.getReferList[index].price
                                          .toString(),
                                  fontStyle: FontWeight.w500,
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
