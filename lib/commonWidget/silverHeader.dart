import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:upen/screen/helper/constant.dart';

class SliverHeader extends StatelessWidget {
  final Widget body;
  final Widget headerBackgroundBody;
  final String headerBackgroundImage;
  final String storeLogo;
  final Widget fabButton;
  final Widget title;
  final bool isFab;
  final bool pinned;
  final ScrollController controller;
  final bool onBack;
  final onBackOperation;

  SliverHeader(
      {@required this.body,
      this.headerBackgroundBody,
      this.headerBackgroundImage ,
      this.storeLogo ,
      this.fabButton,
      this.isFab = false,
      this.pinned = true,
      this.controller,
      this.onBack = false,
        this.title ,
      this.onBackOperation});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        controller: controller,
        physics: BouncingScrollPhysics(),
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              title: title,
              centerTitle: true,
              backgroundColor: Constants().mainColor,
              expandedHeight: MediaQuery.of(context).size.height / 3.5,
              floating: false,
              pinned: pinned,
              elevation: 0,
              stretch: true,
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: true,
                titlePadding: EdgeInsets.only(top: 5, bottom: 10),

                background: Container(

                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                    child: headerBackgroundBody,
                  ),
                ),
              ),
            ),
          ];
        },
        body: body,
      ),
      floatingActionButton: isFab ? fabButton : SizedBox(),
    );
  }
}
