import 'dart:async';
import 'package:TailorsBook/locale/app_localization.dart';
import 'package:TailorsBook/screens/book_screen.dart';
import 'package:TailorsBook/screens/cuttingRegister.dart';
import 'package:TailorsBook/screens/item_register.dart';
import 'package:TailorsBook/screens/search_result.dart';
import 'package:TailorsBook/screens/signin.dart';
import 'package:flutter/material.dart';
import 'package:TailorsBook/common/nav_drower.dart';
import 'package:TailorsBook/common/cardBox.dart';
import 'package:TailorsBook/handle_cloud/data_file.dart';
import 'package:TailorsBook/screens/register_new.dart';
import 'package:flutter/services.dart';
import 'package:TailorsBook/screens/on_working.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_svg/flutter_svg.dart';

final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

List todayData = [];

class CutHome extends StatefulWidget {
  @override
  _CutHomeState createState() => _CutHomeState();
}

class _CutHomeState extends State<CutHome> {
  int branch = 0;
  @override
  Widget build(BuildContext parentContext) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.blue[200],
      drawer: NavDrawer(),
      appBar: AppBar(
        title: Text("Cutting Register"),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Cutting(item: "coat")));
            },
            child: Card(
              color: Colors.amber[50], // lightGreenAccent
              child: Container(
                height: 80,
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Container(
                          width: 30,
                          child: SvgPicture.asset(
                            'assets/images/coat.svg',
                            height: 30,
                            width: 30,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          "COAT",
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.w500),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Cutting(item: "pent")));
            },
            child: Card(
              color: Colors.amber[50], // lightGreenAccent
              child: Container(
                height: 80,
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Container(
                          width: 30,
                          child: SvgPicture.asset(
                            'assets/images/pent.svg',
                            height: 30,
                            width: 30,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          "PENT",
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.w500),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Cutting(item: "shirt")));
            },
            child: Card(
              color: Colors.amber[50], // lightGreenAccent
              child: Container(
                height: 80,
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Container(
                          width: 30,
                          child: SvgPicture.asset(
                            'assets/images/shirt.svg',
                            height: 30,
                            width: 30,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          "SHIRT",
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.w500),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Cutting(item: "jacket")));
            },
            child: Card(
              color: Colors.amber[50], // lightGreenAccent
              child: Container(
                height: 80,
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Container(
                          width: 30,
                          child: SvgPicture.asset(
                            'assets/images/jacket.svg',
                            height: 30,
                            width: 30,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          "JACKET",
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.w500),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Cutting(item: "kurta")));
            },
            child: Card(
              color: Colors.amber[50], // lightGreenAccent
              child: Container(
                height: 80,
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Container(
                          width: 30,
                          child: SvgPicture.asset(
                            'assets/images/kurta.svg',
                            height: 30,
                            width: 30,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          "KURTA",
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.w500),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Cutting(item: "pajama")));
            },
            child: Card(
              color: Colors.amber[50], // lightGreenAccent
              child: Container(
                height: 80,
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Container(
                          width: 30,
                          child: SvgPicture.asset(
                            'assets/images/pajama.svg',
                            height: 30,
                            width: 30,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          "PAJAMA",
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.w500),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Cutting(item: "achkan")));
            },
            child: Card(
              color: Colors.amber[50], // lightGreenAccent
              child: Container(
                height: 80,
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Container(
                          width: 30,
                          child: SvgPicture.asset(
                            'assets/images/achkan.svg',
                            height: 30,
                            width: 30,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          "ACHKAN",
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.w500),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => Cutting(item: "others")),
              );
            },
            child: Card(
              color: Colors.amber[50], // lightGreenAccent
              child: Container(
                height: 80,
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Container(
                          width: 30,
                          child: SvgPicture.asset(
                            'assets/images/others.svg',
                            height: 30,
                            width: 30,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          "OTHERS",
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.w500),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
