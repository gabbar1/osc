import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:upen/commonWidget/commonWidget.dart';
import 'package:upen/screen/helper/constant.dart';
import 'package:upen/screen/partner/controller/partner_controller.dart';
import 'package:upen/screen/profile/personalDetails/personalDetailController.dart';
class LeadListView extends StatefulWidget {
  bool isHide;
  LeadListView({this.isHide});

  @override
  _LeadListViewState createState() => _LeadListViewState();
}

class _LeadListViewState extends State<LeadListView> {
  PartnerController _PartnerController = Get.put(PartnerController());
  PersonalDetailsController _personalDetailsController = Get.put(PersonalDetailsController());
  final RefreshController _refreshController = RefreshController(
    initialRefresh: false,

  );
  void _onRefresh() async {
    // monitor network fetch
    await _PartnerController.myRefreshLeads();

    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    // monitor network fetch
    await _PartnerController.myRefreshLeads();

    _refreshController.refreshCompleted();
  }
  @override
  void initState() {
    // TODO: implement initState
    _PartnerController.myLeads();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: widget.isHide
            ? null
            : AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);

            },
            icon: Icon(
              Icons.arrow_back_ios_outlined,
              color: Colors.white,
            ),
          ),
          title: Text("My Work"),
          centerTitle: true,
        ),
        body: Obx(() => _PartnerController.getLeadList.isEmpty
            ? Center(
          child: CircularProgressIndicator(
            valueColor:
            new AlwaysStoppedAnimation<Color>(Constants().mainColor),
          ),
        )
            : Padding(
          padding: const EdgeInsets.only(left: 8,top: 8,right: 8),
          child: SmartRefresher(
            enablePullDown: false,
            enablePullUp: true,
            controller: _refreshController,
            onRefresh: (){
              print("-------------checkRefresh");
              _PartnerController.myRefreshLeads();
            },
            onLoading: (){
              print("-------------checkLoading");
              _PartnerController.myRefreshLeads().then((value){
                _refreshController.loadComplete();
              });
            },

            child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: _PartnerController.getLeadList.length,
                //shrinkWrap: true,
                itemBuilder: (context, index) {

                  return Card(
                    color: Colors.white,
                    child: SizedBox(
                      height: 120,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20,right: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width:
                              MediaQuery.of(context).size.width - 200,
                              child: Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CommonText(text: "Customer Name",textColor: Colors.black),
                                  SizedBox(height: 5,),
                                  SizedBox(
                                    width:
                                    MediaQuery.of(context).size.width *
                                        .6,
                                    child: Text(
                                      _PartnerController.getLeadList[index].customerName,
                                      style: TextStyle(fontSize: 15),
                                    ),
                                  ),
                                  SizedBox(height: 5,),
                                  CommonText(text: "Product Name",textColor: Colors.black),
                                  SizedBox(height: 5,),
                                  CommonText(
                                      text:
                                      _PartnerController.getLeadList[index].product,
                                      textColor: Colors.black,
                                      fontSize: 20),

                                  /* CommonText(
                                              text:
                                              "${_myWorkController.getContacts[index].comment}",
                                              textColor: Colors.black,
                                              fontSize: 10),*/
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 50.0, right: 5),
                              child: Container(
                                  padding: EdgeInsets.only(left: 5,right: 5,bottom: 5,top: 5),
                                  decoration: BoxDecoration(
                                      color: Constants().mainColor.withOpacity(0.7),
                                      borderRadius: BorderRadius.all(Radius.circular(5))

                                  ),
                                  child: CommonText(text: _PartnerController.getLeadList[index].status)),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                }),
          ),
        )),
        floatingActionButton:_personalDetailsController.getIsAdmin? FloatingActionButton(
          onPressed: (){
            _PartnerController.uploadData();
          },
          backgroundColor: Constants().inactiveColor,
          child: SvgPicture.asset("assets/icons/add.svg"),
        ):SizedBox()

    );
  }
}


