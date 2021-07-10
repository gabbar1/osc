
import 'package:flutter/material.dart';
import 'package:upen/screen/helper/constant.dart';
import 'package:upen/screen/register/registerPage.dart';
import 'package:upen/screen/updateScreen/forceUpdate.dart';
import 'dashboard.dart';

class HomeNavigator extends StatefulWidget {
  @override
  _HomeNavigatorState createState() => _HomeNavigatorState();
}
int _CurrentIdex=0;

Widget callPage(int currentIdex){
  switch(currentIdex){
    case 0 : return DashBoardView();
    case 1:return  RegisterPageView();
    case 2:return  RegisterPageView();
    case 3:return  RegisterPageView();
    case 4:return  RegisterPageView();
    break;
    default: return DashBoardView();
  }
}


class _HomeNavigatorState extends State<HomeNavigator> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: callPage(_CurrentIdex),
        bottomNavigationBar:BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home,color: Colors.grey,),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_balance_outlined,color: Colors.grey,),
              label: 'Products',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.calculate_outlined,color: Colors.grey,),
              label: 'Calculator',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_balance_wallet_outlined,color: Colors.grey,),
              label: 'Earning',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_circle_outlined,color: Colors.grey,),
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
        )

   );
  }
}
