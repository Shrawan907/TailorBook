import 'dart:async';
import 'package:TailorsBook/locale/app_localization.dart';
import 'package:flutter/material.dart';
import 'package:TailorsBook/common/nav_drower.dart';
import 'package:TailorsBook/common/cardBox.dart';
import 'package:TailorsBook/handle_cloud/data_file.dart';
import 'package:TailorsBook/screens/register_new.dart';
import 'package:TailorsBook/screens/book_screen.dart';
import 'package:TailorsBook/test_conn.dart';

List displayData = [[], []];

DateTime date = DateTime.now();
int branch = 0;

class DataToday extends StatefulWidget {
  @override
  _DataTodayState createState() => _DataTodayState();
}

class _DataTodayState extends State<DataToday> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  bool today = true;
  @override
  void initState() {
    super.initState();
    initalData();
  }

  Future initalData() async {
    await fetchData();
    setState(() {});
  }

  Future fetchData() async {
    displayData = [[], []];
    if (today == true)
      displayData = [...(await todaydata())];
    else {
      displayData = [...(await getOldData())];
    }
  }

  addNewData() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => RegisterNewData(branch: branch)),
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
        title: Text(AppLocalizations.of(context)
            .translate(today ? "t_return_today" : "old")),
        actions: <Widget>[
          Center(
            child: Text(
              (displayData == null)
                  ? '0'
                  : (displayData[0].length + displayData[1].length).toString(),
              style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic),
            ),
          ),
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
                                branch: branch,
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
          Container(
            height: 35,
            decoration: BoxDecoration(
              color: Colors.deepPurple,
            ),
            child: Row(
              children: [
                Expanded(
                  child: RaisedButton(
                    color: today ? Colors.orange[800] : Colors.orange[100],
                    onPressed: () async {
                      if (today == false) {
                        today = true;
                        setState(() {});
                        await fetchData();
                        setState(() {});
                      }
                    },
                    child: Center(
                      child: Text(
                        AppLocalizations.of(context).translate("today"),
                        style: TextStyle(
                            fontSize: today ? 18 : 15,
                            color: today ? Colors.white : Colors.black45),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: RaisedButton(
                    color: today ? Colors.orange[100] : Colors.orange[800],
                    onPressed: () async {
                      if (today == true) {
                        today = false;
                        setState(() {});
                        await fetchData();
                        setState(() {});
                      }
                    },
                    child: Center(
                      child: Text(
                        AppLocalizations.of(context).translate("old"),
                        style: TextStyle(
                            fontSize: today ? 15 : 18,
                            color: today ? Colors.black45 : Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 2,
          ),
          buildHeader(today ? "dailyInfo" : "oldData", context),
          Expanded(
            child: Container(
              child: //displayData.isNotEmpty ?
                  RefreshIndicator(
                onRefresh: () async {
                  try {
                    initConnectivity(_scaffoldKey, context);
                    if (today)
                      clearTodayData();
                    else
                      clearOldData();
                    await fetchData();
                    setState(() {});
                  } catch (err) {
                    print("Refresh Bar Error: " + err);
                  }
                },
                child: today
                    ? Container(
                        child: ListView.builder(
                          itemCount: (displayData == null ||
                                  displayData.isEmpty ||
                                  displayData[branch].isEmpty)
                              ? 0
                              : displayData[branch].length,
                          itemBuilder: (context, index) {
                            return CardBox(
                                regNo: displayData[branch][index]['regNo'],
                                isComplete: displayData[branch][index]
                                    ['isComplete'],
                                coat: displayData[branch][index]['coat'],
                                branch: branch);
                          },
                        ),
                      )
                    : Container(
                        child: ListView.builder(
                          itemCount: (displayData == null ||
                                  displayData.isEmpty ||
                                  displayData[branch].isEmpty)
                              ? 0
                              : displayData[branch].length,
                          itemBuilder: (context, index) {
                            return OldCardBox(
                                regNo: displayData[branch][index]['regNo'],
                                isComplete: displayData[branch][index]
                                    ['isComplete'],
                                returnDate: displayData[branch][index]
                                        ['returnDate']
                                    .toDate(),
                                branch: branch);
                          },
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
