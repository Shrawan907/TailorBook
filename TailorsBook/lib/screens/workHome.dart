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
import 'package:TailorsBook/screens/assign_work.dart';

final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

List todayData = [];

Map pref = {
  'coat_maker': ['coat', 'jacket', 'achkan', 'others'],
  'shirt_maker': ['shirt', 'kurta', 'pajama', 'others'],
  'pent_maker': ['pent', 'others'],
  'n_coat': ['shirt', 'pent', 'pajama', 'kurta'],
  'n_shirt': ['coat', 'pent', 'jacket', 'achkan'],
  'n_pent': ['pajama', 'coat', 'shirt', 'jacket', 'achkan', 'kurta'],
};

class WorkHome extends StatefulWidget {
  final String profile;
  final String name;
  WorkHome({this.profile, this.name});
  @override
  _WorkHomeState createState() =>
      _WorkHomeState(profile: this.profile, name: this.name);
}

class _WorkHomeState extends State<WorkHome> {
  final String profile;
  final String name;
  _WorkHomeState({this.profile, this.name});

  String prefKey = 'coat_maker';
  String prefNKey = 'n_coat';

  bool showMore = false;

  @override
  void initState() {
    super.initState();
    if (profile == 'COAT MAKER') {
      prefKey = 'coat_maker';
      prefNKey = 'n_coat';
    } else if (profile == 'PENT MAKER') {
      prefKey = 'pent_maker';
      prefNKey = 'n_pent';
    } else if (profile == 'SHIRT MAKER') {
      prefKey = 'shirt_maker';
      prefNKey = 'n_shirt';
    }
  }

  @override
  Widget build(BuildContext parentContext) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.amber[100],
      appBar: AppBar(
        title: Text("Select Item"),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          SizedBox(
            height: 10,
          ),
          for (int i = 0; i < pref[prefKey].length; i++)
            WorkItemBox(
              item: pref[prefKey][i],
              color: Colors.red[100],
              name: this.name,
              profile: this.profile,
            ),
          Container(
            margin: EdgeInsets.all(5),
            child: GestureDetector(
              onTap: () {
                showMore = showMore ^ true;
                setState(() {});
              },
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Row(
                  children: [
                    Text(
                      showMore ? 'Less' : 'More',
                      style: TextStyle(color: Colors.blue, fontSize: 20),
                    ),
                    Icon(
                      (showMore ? Icons.expand_less : Icons.expand_more),
                      color: Colors.blue,
                    ),
                  ],
                ),
              ),
            ),
          ),
          if (showMore)
            for (int i = 0; i < pref[prefNKey].length; i++)
              WorkItemBox(
                item: pref[prefNKey][i],
                color: Colors.blue[200],
                name: this.name,
                profile: this.profile,
              )
        ],
      ),
    );
  }
}

class WorkItemBox extends StatelessWidget {
  final String item;
  final Color color;
  final String name;
  final String profile;
  WorkItemBox({this.item, this.color, this.profile, this.name});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => AssignWork(
                    item: this.item,
                    name: this.name,
                  )),
        );
      },
      child: Card(
        color: color, // lightGreenAccent
        child: Container(
          height: 60,
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Container(
                    width: 30,
                    child: SvgPicture.asset(
                      'assets/images/$item.svg',
                      height: 30,
                      width: 30,
                      color: Colors.black,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    "$item",
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
