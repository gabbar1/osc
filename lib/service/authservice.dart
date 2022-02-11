import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:upen/screen/dashBoard/homeNavigator.dart';
import '../screen/login/loginPage.dart';




class AuthService extends ChangeNotifier {
  AuthService();
  handleAuth() {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (BuildContext context,spanshot){
        if(spanshot.hasData){
          return HomeNavigator();
        } else {
          return LoginView();
        }

      }
      );
  }

  signOut() {
    FirebaseAuth.instance.signOut();
    notifyListeners();
  }





}