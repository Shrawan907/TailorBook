import 'dart:async';
import 'package:TailorsBook/locale/app_localization.dart';
import 'package:flutter/material.dart';
import 'package:TailorsBook/common/nav_drower.dart';
import 'package:TailorsBook/common/cardBox.dart';
import 'package:TailorsBook/handle_cloud/data_file.dart';
import 'package:TailorsBook/screens/register_new.dart';
import 'package:TailorsBook/screens/on_working.dart';
import 'package:TailorsBook/screens/book_screen.dart';
import 'package:TailorsBook/test_conn.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

List displayData = [];
List data = [];
DateTime todayDate = DateTime.now();
var tommorowDate = todayDate.add(Duration(days: 1));
var overmorrowDate = todayDate.add(Duration(days: 2));
DateTime selectedDate = tommorowDate;
String showDate =
    "${selectedDate.day}-${selectedDate.month}-${selectedDate.year}";
int branch = 0;

class DayData extends StatefulWidget {
  @override
  _DayDataState createState() => _DayDataState();
}

class _DayDataState extends State<DayData> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  int listSize = 0;
  bool searching = false;

  @override
  void initState() {
    super.initState();
    fetchInitalData();
  }

  void fetchInitalData() async {
    if (selectedDate.day == tommorowDate.day &&
        selectedDate.month == tommorowDate.month &&
        selectedDate.year == tommorowDate.year) {
      await fetchTomData();
    } else if (selectedDate.day == overmorrowDate.day &&
        selectedDate.month == overmorrowDate.month &&
        selectedDate.year == overmorrowDate.year) {
      await fetchOverData();
    } else {
      await fetchData();
    }
    setState(() {});
  }

  Future fetchTomData() async {
    displayData.clear();
    displayData.addAll(await tommdata());
    print(displayData);
    listSize = displayData[0].length + displayData[1].length;
  }

  Future fetchOverData() async {
    displayData.clear();
    displayData.addAll(await overmdata());
    listSize = displayData[0].length + displayData[1].length;
  }

  Future fetchData() async {
    displayData.clear();
    displayData.addAll(await fetchTodayData(selectedDate));
    listSize = displayData[0].length + displayData[1].length;
  }

  addNewData() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => RegisterNewData(branch: branch)),
    );
  }

  _selectDate(BuildContext context) async {
    setState(() {
      searching = true;
    });
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: selectedDate, // Refer step 1
      firstDate: DateTime(2020),
      lastDate: DateTime(2050),
      builder: (context, child) {
        return Theme(
          data: ThemeData.light(), // This will change to light theme.
          child: child,
        );
      },
    );
    if (picked != null) {
      selectedDate = picked;
      await fetchData();
    }
    setState(() {
      searching = false;
      showDate =
          "${selectedDate.day}-${selectedDate.month}-${selectedDate.year}";
    });
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
        title: Text(
          showDate,
        ),
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.all(10),
            child: Center(
              child: Text(
                "$listSize",
                style: TextStyle(
                  fontSize: 25,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                ),
              ),
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
                    color: selectedDate == tommorowDate
                        ? Colors.black
                        : Colors.cyan,
                    onPressed: () async {
                      if (selectedDate != tommorowDate) {
                        selectedDate = tommorowDate;
                        await fetchTomData();
                        setState(() {
                          showDate =
                              "${selectedDate.day}-${selectedDate.month}-${selectedDate.year}";
                        });
                      }
                    },
                    child: Center(
                      child: Text(
                        AppLocalizations.of(context).translate('tomorrow'),
                        style: TextStyle(
                            fontSize: selectedDate == tommorowDate ? 18 : 15,
                            color: selectedDate == tommorowDate
                                ? Colors.white
                                : Colors.black45),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: RaisedButton(
                    color: selectedDate == overmorrowDate
                        ? Colors.black
                        : Colors.cyan,
                    onPressed: () async {
                      if (selectedDate != overmorrowDate) {
                        selectedDate = overmorrowDate;
                        await fetchOverData();
                        setState(() {
                          showDate =
                              "${selectedDate.day}-${selectedDate.month}-${selectedDate.year}";
                        });
                      }
                    },
                    child: Center(
                      child: Text(
                        AppLocalizations.of(context).translate("overmorrow"),
                        style: TextStyle(
                            fontSize: selectedDate == overmorrowDate ? 18 : 15,
                            color: selectedDate == overmorrowDate
                                ? Colors.white
                                : Colors.black45),
                      ),
                    ),
                  ),
                ),
                Container(
                  width: 80,
                  child: RaisedButton(
                    onPressed: () {
                      _selectDate(context);
                    },
                    child: searching == false
                        ? Icon(Icons.calendar_today_outlined)
                        : SpinKitThreeBounce(
                            color: Colors.blueAccent,
                            size: 20,
                          ),
                    color: Colors.greenAccent,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 2,
          ),
          buildHeader("dailyInfo", context),
          SizedBox(
            height: 2,
          ),
          Expanded(
            child: Container(
                child: //displayData.isNotEmpty ?
                    RefreshIndicator(
              onRefresh: () async {
                try {
                  initConnectivity(_scaffoldKey, context);
                  if (selectedDate.day == tommorowDate.day &&
                      selectedDate.month == tommorowDate.month &&
                      selectedDate.year == tommorowDate.year) {
                    clearTomData();
                    await fetchTomData();
                  } else if (selectedDate.day == overmorrowDate.day &&
                      selectedDate.month == overmorrowDate.month &&
                      selectedDate.year == overmorrowDate.year) {
                    clearOverData();
                    await fetchOverData();
                  } else
                    await fetchData();
                  setState(() {});
                  print(displayData.isEmpty);
                } catch (err) {
                  print("Refresh Bar Error: " + err);
                }
              },
              child: ListView.builder(
                itemCount: displayData.isEmpty ? 0 : displayData[branch].length,
                itemBuilder: (context, index) {
                  return DayCardBox(
                    regNo: displayData[branch][index]['regNo'],
                    isComplete: displayData[branch][index]['isComplete'],
                    coat: displayData[branch][index]['coat'],
                    branch: branch,
                  );
                },
              ),
            )),
          ),
        ],
      ),
    );
  }
}
