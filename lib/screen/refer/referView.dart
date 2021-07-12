import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share/share.dart';
import 'package:upen/commonWidget/commonWidget.dart';
import 'package:upen/screen/helper/constant.dart';
import 'dart:ui' as ui;
import 'package:dotted_border/dotted_border.dart';

class ReferView extends StatefulWidget {
  @override
  _ReferViewState createState() => _ReferViewState();
}

class _ReferViewState extends State<ReferView> {

  ScreenshotController imageController = ScreenshotController();
  GlobalKey imagekey = GlobalKey();
  Uint8List pngBytes ;
  File capturedFile;
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: CommonText(
            text: "Refer",
          ),
          bottom: TabBar(
            tabs: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CommonText(text: "Refer & Earn"),
              ),
              CommonText(text: "Greeting Cards"),
              CommonText(text: "Visiting Cards"),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            refer(),
            Icon(Icons.directions_transit),
            Icon(Icons.directions_bike),
          ],
        ),
      ),
    );
  }

  Widget refer() {
    return Container(
      child: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height / 3.0,
            color: Constants().mainColor,
          ),
          Positioned(
              child: Container(
            padding: EdgeInsets.only(top: 30),
            height: MediaQuery.of(context).size.height / 1.6,
            width: MediaQuery.of(context).size.width,
            child: Card(
              color: Constants().mainColor,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(55.0),
                    bottomRight: Radius.circular(55.0)),
              ),
              child: Column(
                children: [
                 RepaintBoundary(child:  Screenshot(
                   key: imagekey,
                   controller: imageController,
                   child: Container(
                     color: Constants().mainColor,
                     child: Column(
                       children: [
                         CommonText(
                             text: "Refer your Friends \nEnd Earn ", fontSize: 26),
                         SizedBox(
                           height: 20,
                         ),
                         Container(
                           margin: EdgeInsets.only(bottom: 5),
                           height: 150,
                           width: 150,
                           child: SvgPicture.asset("assets/icons/gift.svg"),
                         ),
                         SizedBox(
                           height: 10,
                         ),
                         Container(padding: EdgeInsets.only(left: 30,right: 30),child: CommonText(text: "Refer to your friend and get 20% of his/her earnings lifetime"),),
                         SizedBox(
                           height: 20,
                         ),
                       ],
                     ),
                   ),
                 ),),
                  Padding(
                    padding: const EdgeInsets.only(left: 30, right: 30),
                    child: DottedBorder(
                      borderType: BorderType.RRect,
                      color: Colors.white,
                      radius: Radius.circular(12),
                      child: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                        child: Container(
                          height: 70,
                          width: MediaQuery.of(context).size.width,
                          color: Colors.amber,
                          child: Row(

                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 80,top: 10),
                                child: Column(children: [CommonText(text: "Copy the referral code"),SizedBox(height: 10,),CommonText(text: "9725131037")],),
                              ),
                              Spacer(),
                              VerticalDivider(
                                width: 50,
                                thickness: 2,
                              ),
                              InkWell(
                                onTap: (){
                                  Clipboard.setData(ClipboardData(text: "9725131037")).then((value) {
                                    Fluttertoast.showToast(msg: "referral code copied");
                                  });
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 25),
                                  child: CommonText(text: "Copy \nCode"),
                                ),
                              )

                            ],
                          ),
                        ),
                      ),
                    ),
                  ),

                  SizedBox(
                    height: 20,
                  ),
                  InkWell(
                    onTap: () async {
                      final RenderRepaintBoundary boundary =
                      imagekey.currentContext.findRenderObject();
                      final ui.Image image = await boundary.toImage(pixelRatio: 3.0);
                      final ByteData byteData =
                          await image.toByteData(format: ui.ImageByteFormat.png);
                      pngBytes = byteData.buffer.asUint8List();
                      String dir = (await getApplicationDocumentsDirectory()).path;

                      final String fullPath = '$dir/${DateTime.now().millisecond}.png';

                      capturedFile = File(fullPath);

                      await capturedFile.writeAsBytes(pngBytes);

                      capturedFile = File(fullPath);
                      List<String> imgPath = [capturedFile.path];
                      Share.shareFiles(
                        imgPath,
                        subject: "Baking Ocean",
                        text: "Download Banking Ocean" +
                            "\n\n" +
                            "For more funny content download Gaaliya app now \n\n" +
                            "https://play.google.com/store/apps/details?id=com.boss.gaaliya",
                      );
                    },
                    child: ClipRRect(

                      borderRadius: BorderRadius.all(Radius.circular(12)),
                      child: Container(
                        height: 50,
                        width: MediaQuery.of(context).size.width/5,
                        color: Colors.amber,
                        child:  Container(
                          height: 100,
                          width: 100,
                          child:
                          Center(child: SvgPicture.asset("assets/icons/more.svg")),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ))
        ],
      ),
    );
  }
}
