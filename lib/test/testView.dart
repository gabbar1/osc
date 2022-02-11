import 'package:flutter/material.dart';
class TestView extends StatefulWidget {
  TestView({this.name="rinkesh"});
  String name ;
  @override
  _TestViewState createState() => _TestViewState();
}

class _TestViewState extends State<TestView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
           ElevatedButton(
             style: ElevatedButton.styleFrom(
               primary: Colors.orange,
               onPrimary: Colors.white
             ),
             child: Text('Name'),
             onPressed: () {
               print('pressed name');
             },
           ),
      ElevatedButton(
        style: ElevatedButton.styleFrom(
            primary: Colors.orange,
            onPrimary: Colors.white
        ),
        child: Text('phone'),
        onPressed: () {
          print('pressed phone');
        },
      ),
      ElevatedButton(
        style: ElevatedButton.styleFrom(
            primary: Colors.orange,
            onPrimary: Colors.white
        ),
        child: Text('Email'),
        onPressed: () {
          print('pressed Email');
        },
      ),
      ],

              ),
            ),
        );


  }
}
