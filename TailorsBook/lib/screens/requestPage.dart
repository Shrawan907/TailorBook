import 'dart:async';
import 'package:TailorsBook/locale/app_localization.dart';
import 'package:TailorsBook/screens/signin.dart';
import 'package:flutter/material.dart';
import 'package:TailorsBook/common/nav_drower.dart';
import 'package:TailorsBook/common/cardBox.dart';
import 'package:TailorsBook/handle_cloud/data_file.dart';
import 'package:TailorsBook/screens/register_new.dart';
import 'package:TailorsBook/screens/on_working.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:TailorsBook/screens/book_screen.dart';

List requestData = [];

DateTime date = DateTime.now();

class RequestPage extends StatefulWidget {
  @override
  _RequestPageState createState() => _RequestPageState();
}

class _RequestPageState extends State<RequestPage> {
  int branch = 0;
  @override
  void initState() {
    super.initState();
    initalData();
  }

  void initalData() async {
    await getData();
    setState(() {});
  }

  Future getData() async {
    requestData.clear();
    requestData = [...(await getRequestData())];
  }

  removeOne() async {
    await getData();
    setState(() {});
  }

  @override
  Widget build(BuildContext parentContext) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            "Requests"), //AppLocalizations.of(context).translate("t_return_today")),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          try {
            clearRequestData();
            await getData();
            setState(() {});
          } catch (err) {
            print("Request Page: " + err);
          }
        },
        child: ListView.builder(
          itemCount: requestData.length,
          itemBuilder: (context, index) {
            return RequestCard(
              name: requestData[index]['username'],
              phoneNo: requestData[index]['phoneNo'],
              profile: requestData[index]['requestProfile'],
              function: removeOne,
            );
          },
        ),
      ),
    );
  }
}
