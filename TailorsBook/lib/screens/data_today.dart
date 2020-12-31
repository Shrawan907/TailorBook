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
import 'package:TailorsBook/test_conn.dart';
import 'package:connectivity/connectivity.dart';

List displayData = [];

DateTime date = DateTime.now();

class DataToday extends StatefulWidget {
  @override
  _DataTodayState createState() => _DataTodayState();
}

class _DataTodayState extends State<DataToday> {
  int branch = 0;
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    initalData();
  }

  void initalData() async {
    await fetchData();
    setState(() {});
  }

  Future fetchData() async {
    displayData = [...(await todaydata())];
  }

  addNewData() {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => RegisterNewData(branch: this.branch)),
    );
  }

  @override
  Widget build(BuildContext parentContext) {
    return Scaffold(
      key: _scaffoldKey,
      floatingActionButton: Container(
        height: 90,
        width: 70,
        child: FloatingActionButton(
          onPressed: addNewData,
          child: Icon(
            Icons.add,
            size: 40,
            color: Colors.white,
          ),
          backgroundColor: branch == 0 ? Colors.deepPurple : Colors.red[700],
        ),
      ),
      backgroundColor: Colors.black12,
      drawer: NavDrawer(),
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).translate("t_return_today")),
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.only(right: 30.0),
            child: RaisedButton(
              child: Text(
                branch == 0 ? "A" : "B",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 25),
              ),
              onPressed: () {
                setState(() {
                  if (branch == 0)
                    branch = 1;
                  else
                    branch = 0;
                });
              },
              shape: CircleBorder(
                side: BorderSide(color: Colors.transparent),
              ),
              color: branch == 0 ? Colors.deepPurple : Colors.red[700],
            ),
          ),
          Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => BookScreen(
                                branch: this.branch,
                              )));
                },
                child: Icon(
                  Icons.search,
                  size: 26.0,
                ),
              )),
        ],
      ),
      body: Column(
        children: <Widget>[
          SizedBox(
            height: 2,
          ),
          SizedBox(
            height: 2,
          ),
          buildHeader("dailyInfo", context),
          Expanded(
            child: Container(
              child: //displayData.isNotEmpty ?
                  RefreshIndicator(
                onRefresh: () async {
                  try {
                    initConnectivity(_scaffoldKey);
                    clearTodayData();
                    await fetchData();
                    setState(() {});
                    print(displayData.isEmpty);
                  } catch (err) {
                    print("Refresh Bar Error: " + err);
                  }
                },
                child: Container(
                  child: ListView.builder(
                    itemCount:
                        displayData.isEmpty ? 0 : displayData[branch].length,
                    itemBuilder: (context, index) {
                      return CardBox(
                          regNo: displayData[branch][index]['reg_no'],
                          isComplete: displayData[branch][index]['is_complete'],
                          coat: displayData[branch][index]['coat'],
                          branch: this.branch);
                    },
                  ),
                ),
              ),
            ),
          ),
          RaisedButton(
            onPressed: () async{
              try {
                initConnectivity(_scaffoldKey);
                clearTodayData();
                await fetchData();
                setState(() {});
                print(displayData.isEmpty);
              } catch (err) {
                print("Refresh Bar Error: " + err);
              }
            },
            child: Text(AppLocalizations.of(context).translate("refresh")),
          ),
        ],
      ),
    );
  }
}
