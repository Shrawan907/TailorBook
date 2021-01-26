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

import '../locale/app_localization.dart';

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
        title: Text(AppLocalizations.of(context).translate("cutting_register")),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          buildGestureDetector('blazer', true),
          buildGestureDetector('coat', false),
          buildGestureDetector('pent', true),
          buildGestureDetector('shirt', false),
          buildGestureDetector('jacket', true),
          buildGestureDetector('jodJacket', false),
          buildGestureDetector('kurta', true),
          buildGestureDetector('pajama', false),
          buildGestureDetector('safari', true),
          buildGestureDetector('achkan', false),
          buildGestureDetector('others', true),
        ],
      ),
    );
  }

  GestureDetector buildGestureDetector(String key, bool odd) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => Cutting(item: key)));
      },
      child: Card(
        color: odd ? Colors.amber[50] : Colors.lime[100], // lightGreenAccent
        child: Container(
          height: 60,
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 100,
                  child: Center(
                    child: SvgPicture.asset(
                      'assets/images/$key.svg',
                      height: 30,
                      width: 30,
                      color: Colors.black,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    AppLocalizations.of(context).translate("$key"),
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
