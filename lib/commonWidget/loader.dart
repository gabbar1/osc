import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:io' show Platform;



showLoader(
    {bool isLoading = false,
    Color loaderColor =   Colors.amber}) {
  Widget progressIndicator = Platform.isAndroid
      ? CircularProgressIndicator(
          valueColor: new AlwaysStoppedAnimation<Color>(loaderColor),
        )
      : CupertinoActivityIndicator(
          radius: 14,
        );

  return Get.dialog(
    Scaffold(
      backgroundColor: Colors.black.withOpacity(0.3),
      body: Center(
          child: isLoading
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Loading....",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    progressIndicator
                  ],
                )
              : progressIndicator),
    ),
    barrierColor: Colors.black.withOpacity(0.3),
    barrierDismissible: false,
  );
}

closeLoader() {
  if (Get.isOverlaysOpen) Get.back();
}
