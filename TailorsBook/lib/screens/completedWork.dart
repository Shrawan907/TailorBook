import 'dart:async';
import 'package:TailorsBook/locale/app_localization.dart';
import 'package:TailorsBook/screens/day_data.dart';
import 'package:TailorsBook/screens/signin.dart';
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
import 'package:TailorsBook/screens/assign_work.dart';
import 'package:TailorsBook/screens/workHome.dart';

List items = [];

class Completed extends StatefulWidget {
  final String name;
  final String profile;
  final String phoneNo;
  Completed({this.name, this.profile, this.phoneNo});
  @override
  _CompletedState createState() => _CompletedState(
      name: this.name, profile: this.profile, phoneNo: this.phoneNo);
}

class _CompletedState extends State<Completed> {
  String name = "";
  String profile = "";
  String phoneNo = "";

  _CompletedState({this.name, this.profile, this.phoneNo});

  @override
  void initState() {
    super.initState();
    initialData();
  }

  void initialData() async {
    clearCompletedData();
    await getData();
    setState(() {});
  }

  Future getData() async {
    items.clear();
    items = [...(await getCompletedData(this.phoneNo))];
  }

  @override
  Widget build(BuildContext parentContext) {
    return Scaffold(
      appBar: AppBar(
        title: Text(name),
        actions: [
          GestureDetector(
            onTap: getData,
            child: Container(
              margin: EdgeInsets.only(right: 20),
              child: Icon(Icons.refresh),
            ),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          try {
            clearCompletedData();
            await getData();
            setState(() {});
          } catch (err) {
            print(err);
          }
        },
        child: ListView(
          children: [
            StickyHeader(
              header: buildHeader('profile_header', context),
              content: Column(
                children: [
                  for (int i = 0; i < items.length; i++)
                    ProfileItemCardBox(
                      branch: items[i]['branch'],
                      regNo: items[i]['regNo'],
                      type: items[i]["type"],
                      count: items[i]["count"],
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
