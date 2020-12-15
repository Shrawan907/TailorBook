import 'dart:async';
import 'package:TailorsBook/locale/app_localization.dart';
import 'package:TailorsBook/screens/day_data.dart';
import 'package:TailorsBook/signin.dart';
import 'package:flutter/material.dart';
import 'package:TailorsBook/common/nav_drower.dart';
import 'package:TailorsBook/common/cardBox.dart';
import 'package:TailorsBook/handle_cloud/data_file.dart';
import 'package:TailorsBook/screens/register_new.dart';
import 'package:flutter/services.dart';
import 'package:TailorsBook/screens/on_working.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sticky_headers/sticky_headers.dart';
import 'package:easy_localization/easy_localization.dart';

List items = [
  {"regNo": "123", "type": "pajama", "isComplete": true},
  {"regNo": "124", "type": "shirt", "isComplete": false},
  {"regNo": "127", "type": "kurta", "isComplete": true},
  {"regNo": "127", "type": "shirt", "isComplete": true},
  {"regNo": "123", "type": "pajama", "isComplete": true},
  {"regNo": "124", "type": "shirt", "isComplete": false},
  {"regNo": "127", "type": "kurta", "isComplete": true},
  {"regNo": "127", "type": "shirt", "isComplete": true},
  {"regNo": "123", "type": "pajama", "isComplete": true},
  {"regNo": "124", "type": "shirt", "isComplete": false},
  {"regNo": "127", "type": "kurta", "isComplete": true},
  {"regNo": "127", "type": "shirt", "isComplete": true},
  {"regNo": "123", "type": "pajama", "isComplete": true},
  {"regNo": "124", "type": "shirt", "isComplete": false},
  {"regNo": "127", "type": "kurta", "isComplete": true},
  {"regNo": "127", "type": "shirt", "isComplete": true},
  {"regNo": "123", "type": "pajama", "isComplete": true},
  {"regNo": "124", "type": "shirt", "isComplete": false},
  {"regNo": "127", "type": "kurta", "isComplete": true},
  {"regNo": "127", "type": "shirt", "isComplete": true},
  {"regNo": "123", "type": "pajama", "isComplete": true},
  {"regNo": "124", "type": "shirt", "isComplete": false},
  {"regNo": "127", "type": "kurta", "isComplete": true},
  {"regNo": "127", "type": "shirt", "isComplete": true},
  {"regNo": "123", "type": "pajama", "isComplete": true},
  {"regNo": "124", "type": "shirt", "isComplete": false},
  {"regNo": "127", "type": "kurta", "isComplete": true},
  {"regNo": "127", "type": "shirt", "isComplete": true},
  {"regNo": "123", "type": "pajama", "isComplete": true},
  {"regNo": "124", "type": "shirt", "isComplete": false},
  {"regNo": "127", "type": "kurta", "isComplete": true},
  {"regNo": "127", "type": "shirt", "isComplete": true},
  {"regNo": "123", "type": "pajama", "isComplete": true},
  {"regNo": "124", "type": "shirt", "isComplete": false},
  {"regNo": "127", "type": "kurta", "isComplete": true},
  {"regNo": "127", "type": "shirt", "isComplete": true},
  {"regNo": "123", "type": "pajama", "isComplete": true},
  {"regNo": "124", "type": "shirt", "isComplete": false},
  {"regNo": "127", "type": "kurta", "isComplete": true},
  {"regNo": "127", "type": "shirt", "isComplete": true},
];

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  onPressed() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => OnWork()));
  }

  @override
  Widget build(BuildContext parentContext) {
    return Scaffold(
      //backgroundColor: Colors.grey[300],
      floatingActionButton: Container(
        height: 60,
        width: 60,
        margin: EdgeInsets.only(right: 15, bottom: 15),
        child: FloatingActionButton(
          onPressed: onPressed,
          child: Icon(
            Icons.note_add,
            size: 30,
          ),
        ),
      ),
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).translate("member_diary")),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            InfoCard(
              name: "Amitabh Ji",
              profile: AppLocalizations.of(context).translate("shirt_maker"),
              phone: "6377832265",
              image: AssetImage("assets/images/person.png"),
            ),
            StickyHeader(
              header: buildHeader("Shirt Maker", context),
              content: Column(
                children: [
                  for (int i = 0; i < items.length; i++)
                    ShirtCardBox(
                      regNo: items[i]['regNo'],
                      isComplete: items[i]['isComplete'],
                      type: items[i]['type'],
                      isColor: i & 1 == 1,
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
