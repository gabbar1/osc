
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/svg.dart';
import 'package:upen/commonWidget/commonWidget.dart';
import 'package:upen/screen/helper/constant.dart';
import 'package:upen/screen/myWork/my_work.dart';
import 'package:upen/screen/partner/lead_list_view.dart';
import 'package:upen/screen/profile/personalDetails/personalDetailController.dart';
import 'package:upen/screen/profile/profilePage.dart';
import 'package:upen/screen/refer/refer_view.dart';
import 'package:upen/test/testView.dart';
import 'dashboard.dart';
import 'package:url_launcher/url_launcher.dart';
class HomeNavigator extends StatefulWidget {
  @override
  _HomeNavigatorState createState() => _HomeNavigatorState();
}
int _CurrentIdex=0;


Widget callPage(int currentIdex){

  switch(currentIdex){

    case 0 : return DashBoardView();
    case 1:return  LeadListView(isHide: true,);
    case 2:return  ReferView();
    //case 2:return  ProfileScreen(isHide: true,);

    break;
    default: return ProfileScreen(isHide: true,);
  }

}


class _HomeNavigatorState extends State<HomeNavigator> {

  PersonalDetailsController _personalDetailsController = Get.put(PersonalDetailsController());
  @override
  void initState() {
    // TODO: implement initState

    _personalDetailsController.personalDetails();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.0),
        child: Center(
          child: AppBar(
            elevation: 0,
            actions: [
            InkWell(
              child: Container(
                height: 65,
                width: 40,
                padding: EdgeInsets.only(left: 10, right: 5),
                child: SvgPicture.asset(
                  "assets/icons/support.svg",
                  color: Colors.white,
                  height: 10,
                ),
              ),
              onTap: ()  async{
                await launch("https://wa.me/919726868497?text=%20Hi%20I%20need%20some%20help", forceSafariVC: false);
              },
            ),
            SizedBox(
              width: 10,
            )
          ],
            title: Obx(()=>
            Row(children: [
              _personalDetailsController.getDocumentUrl.isBlank ?
              Icon(Icons.camera_alt_outlined):
              Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                ),
                child: Obx(()=>CachedNetworkImage(
                  imageUrl: _personalDetailsController.getDocumentUrl,
                  imageBuilder: (context, imageProvider) => Container(
                    decoration: BoxDecoration(
                      borderRadius:
                      BorderRadius.all(Radius.circular(5)),
                      image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                )),
              ),
              SizedBox(width: 5,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CommonText(
                      text: "Hello,",
                    fontSize: 10
                  ),
                  CommonText(
                      text: _personalDetailsController.getNameController.text.capitalize,

                  )
                ],
              )
            ],)),
            //title: CommonText(text: _CurrentIdex ==0 ? "DashBoard":_CurrentIdex ==1 ?"Leads":_CurrentIdex ==2?"Calculator":_CurrentIdex ==3?"Earning":_CurrentIdex ==4?"Profile":"DashBoard"),
          ),
        ),
      ),
      body: callPage(_CurrentIdex),
        bottomNavigationBar:BottomNavigationBar(
          unselectedItemColor: Colors.white,
          backgroundColor: Constants().appBackGroundColor,
          type : BottomNavigationBarType.fixed,
          items: [
            new BottomNavigationBarItem(
                //backgroundColor: Colors.white,
                icon:SvgPicture.asset("assets/icons/home.svg",color: _CurrentIdex == 0 ?Constants().mainColor:Colors.white,),
                label: "Home"
                ),

            BottomNavigationBarItem(
              icon:SvgPicture.asset("assets/icons/lead.svg",color: _CurrentIdex == 1 ?Constants().mainColor:Colors.white,),
              label: 'Leads',
            ),

            BottomNavigationBarItem(
              icon:SvgPicture.asset("assets/icons/referal.svg",color: _CurrentIdex == 2 ?Constants().mainColor:Colors.white,),

              label: 'Referal',
            ),
            BottomNavigationBarItem(
              icon:SvgPicture.asset("assets/icons/profile.svg",color: _CurrentIdex == 3 ?Constants().mainColor:Colors.white,),

              label: 'Profile',
            ),
          ],
          currentIndex: _CurrentIdex,
          selectedItemColor: Constants().mainColor,
          onTap: (position) {
            setState(() {
              _CurrentIdex = position;
            });
          },
        ),
     // drawer: AppDrawer(),

   );
  }
}
