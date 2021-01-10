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

class Profile extends StatefulWidget {
  final String name;
  final String profile;
  final String phoneNo;
  Profile({this.name, this.profile, this.phoneNo});
  @override
  _ProfileState createState() => _ProfileState(
      name: this.name, profile: this.profile, phoneNo: this.phoneNo);
}

class _ProfileState extends State<Profile> {
  String name = "";
  String profile = "";
  String phoneNo = "";

  _ProfileState({this.name, this.profile, this.phoneNo});

  @override
  void initState() {
    super.initState();
    initialData();
  }

  void initialData() async {
    await getData();
    setState(() {});
  }

  Future getData() async {
    items.clear();
    items = [...(await getAssignedData(this.phoneNo))];
  }

  onPressed() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => WorkHome(
                  profile: this.profile,
                  name: this.name,
                )));
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
            color: Colors.white,
          ),
          backgroundColor: Colors.amber,
        ),
      ),
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).translate("member_diary")),
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
            clearData();
            await getData();
            setState(() {});
          } catch (err) {
            print(err);
          }
        },
        child: ListView(
          children: [
            InfoCard(
              name: this.name,
              profile: this.profile,
              phone: this.phoneNo,
              image: AssetImage("assets/images/person.png"),
            ),
            StickyHeader(
              header: buildHeader('profile_header', context),
              content: Column(
                children: [
                  for (int i = 0; i < items.length; i++)
                    ProfileItemCardBox(
                      branch: items[i]['branch'],
                      regNo: items[i]['regNo'],
                      isComplete: items[i]['isComplete'],
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
