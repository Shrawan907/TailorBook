import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:TailorsBook/test_screen.dart';
import 'package:TailorsBook/screens/create_company.dart';
import 'package:TailorsBook/common/nav_drower.dart';
import 'package:TailorsBook/screens/data_today.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  PageController pageController;
  int pageIndex = 0;

  @override
  void initState() {
    super.initState();
    pageController = PageController();
  }

  onPageChanged(int pageIndex) {
    setState(() {
      this.pageIndex = pageIndex;
    });
  }

  onTap(int pageIndex) {
    pageController.animateToPage(pageIndex,
        duration: Duration(milliseconds: 250), curve: Curves.easeInOut);
  }

  @override
  Widget build(BuildContext parentContext) {
    return Scaffold(
        body: PageView(
          children: <Widget>[
            //Timeline(),
            DataToday(),
            CreateCompany(),
          ],
          controller: pageController,
          onPageChanged: onPageChanged,
          physics: NeverScrollableScrollPhysics(),
        ),
        bottomNavigationBar: CupertinoTabBar(
          currentIndex: pageIndex,
          onTap: onTap,
          activeColor: Theme.of(context).primaryColor,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.whatshot),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.notifications_active),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.photo_camera, size: 35.0),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
            ),
            // BottomNavigationBarItem(
            //   icon: Icon(Icons.account_circle),
            // ),
          ],
        ));
//    return RaisedButton(
//      child: Text('Logout'),
//      onPressed: logout,
//    );
  }
}
