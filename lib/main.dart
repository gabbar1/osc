import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:google_fonts/google_fonts.dart';
import 'screen/helper/constant.dart';
import 'screen/updateScreen/forceUpdate.dart';
import 'service/authservice.dart';
import 'package:get/get.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(GetMaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      unselectedWidgetColor:Colors.white,
      scaffoldBackgroundColor: Constants().appBackGroundColor,
      backgroundColor:Constants().appBackGroundColor ,
      primaryColor: Constants().appBackGroundColor,
      appBarTheme: AppBarTheme(backgroundColor: Constants().appBackGroundColor),
      textTheme: GoogleFonts.latoTextTheme(),
    ),
    home: MyApp(),
  ));
}


class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> {
  FirebaseMessaging firebaseMessaging;
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  static Future<dynamic> backgroundMessageHandler(
      Map<String, dynamic> message) {
    print("_backgroundMessageHandler");
    if (message.containsKey('data')) {
      // Handle data message
      final dynamic data = message['data'];
      print("_backgroundMessageHandler data: ${data}");
    }

    if (message.containsKey('notification')) {
      // Handle notification message
      final dynamic notification = message['notification'];
      print("_backgroundMessageHandler notification: ${notification}");
    }
  }

  var version = "2";
  @override
  void initState() {
    super.initState();
    print("_____________checkVersion-----------------");
    FirebaseFirestore.instance
        .collection("version")
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((element) {

        if (version == element["version"].toString()) {
          print("--------latestVersion----------");
          Get.offAll(AuthService().handleAuth());
          /*Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => AuthService().handleAuth()));*/
          // return AuthService().handleAuth();
        } else {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ForceUpdateView(
                      element["update"].toString(),
                      element['force'].toString(),
                      element['maintance'].toString())));
        }
      });
    });
    var android = new AndroidInitializationSettings('mipmap/ic_launcher');
    var ios = new IOSInitializationSettings();
    var platform = new InitializationSettings(android: android, iOS: ios);
    flutterLocalNotificationsPlugin.initialize(platform);
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print("--------------listen");
      RemoteNotification notification = message.notification;
      AndroidNotification android = message.notification?.android;
      if (notification != null && android != null) {
      } else {
        print(android.channelId);
      }
    });
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('A new onMessageOpenedApp event was published!');
    });
  }

  showNotification({var title, body}) async {
    print("0000000000000000" + title.toString());
    var android = new AndroidNotificationDetails(
      'sdffds dsffds',
      "CHANNLE NAME",
      "channelDescription",
    );
    var iOS = new IOSNotificationDetails();
    var platform = new NotificationDetails(android: android, iOS: iOS);
    await flutterLocalNotificationsPlugin.show(0, title, body, platform);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: Constants().appBackGroundColor,
        child: Image.asset("assets/icons/icon.png"),
      ),
    );
  }
}
