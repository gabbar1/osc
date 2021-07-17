import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share/share.dart';
import 'package:upen/commonWidget/commonWidget.dart';
import 'package:upen/screen/dashBoard/dashBoardController.dart';
import 'package:upen/screen/helper/constant.dart';
import 'dart:ui' as ui;

class MyLevelView extends StatelessWidget {
  ScreenshotController imageController = ScreenshotController();
  DashBoardController dashBoardController = Get.put(DashBoardController());
  GlobalKey imagekey = GlobalKey();
  Uint8List pngBytes;
  File capturedFile;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: CommonText(text: "My Level"),
      ),
      body: Container(
        child: Column(
          children: [
            RepaintBoundary(
              child: Screenshot(   key: imagekey,
                controller: imageController,child:  Stack(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height / 3.0,
                      color: Constants().mainColor,
                    ),
                    Screenshot(
                      child: Positioned(
                          child: Center(
                            child: Container(
                              margin: EdgeInsets.only(top: 50),
                              child: Column(
                                children: [
                                  Column(
                                    children: [
                                      CommonText(
                                          text: "ABHISHEK MISHRA",
                                          textColor: Colors.white,
                                          fontSize: 28),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          CommonText(
                                              text: "Advisor Code :",
                                              textColor: Colors.white,
                                              fontSize: 16),
                                          CommonText(
                                              text: "394221",
                                              textColor: Colors.white,
                                              fontSize: 16)
                                        ],
                                      ),
                                      SizedBox(
                                        height: 100,
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(bottom: 5),
                                        height: 150,
                                        width: 150,
                                        child: SvgPicture.asset(
                                            "assets/icons/star.svg"),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      CommonText(
                                          text: "Wow, You Did it!",
                                          textColor: Colors.black,
                                          fontSize: 24),
                                      SizedBox(
                                        height: 25,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 25, right: 25),
                                        child: CommonText(
                                            text:
                                            "You won ${"Bronze"} Badge \nGoes to you",
                                            textColor: Constants().mainColor,
                                            fontSize: 24),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 50,
                                  ),
                                ],
                              ),
                            ),
                          )),
                    ),
                  ],
                ),),
            ),
            Center(
              child: Column(
                children: [
                  CommonText(
                      text: "SHARE WITH YOUR FRIENDS",
                      textColor: Colors.black45,
                      fontSize: 20),
                  SizedBox(
                    height: 20,
                  ),
                  InkWell(
                    onTap: () async {
                      dashBoardController.setIsHide(true);
                      final RenderRepaintBoundary boundary =
                      imagekey.currentContext.findRenderObject();
                      final ui.Image image =
                      await boundary.toImage(pixelRatio: 3.0);
                      final ByteData byteData = await image.toByteData(
                          format: ui.ImageByteFormat.png);
                      pngBytes = byteData.buffer.asUint8List();
                      String dir =
                          (await getApplicationDocumentsDirectory()).path;

                      final String fullPath =
                          '$dir/${DateTime.now().millisecond}.png';

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
                    child: CircleAvatar(
                      backgroundColor: Constants().mainColor,
                      radius: 30,
                      child: Icon(Icons.share),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
