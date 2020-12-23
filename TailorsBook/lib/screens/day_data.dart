import 'dart:async';
import 'package:TailorsBook/locale/localInfo.dart';
import 'package:TailorsBook/locale/app_localization.dart';
import 'package:TailorsBook/screens/signin.dart';
import 'package:flutter/material.dart';
import 'package:TailorsBook/common/nav_drower.dart';
import 'package:TailorsBook/common/cardBox.dart';
import 'package:TailorsBook/handle_cloud/data_file.dart';
import 'package:TailorsBook/screens/register_new.dart';
import 'package:TailorsBook/screens/on_working.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:provider/provider.dart';

List todayData = [];
DateTime todayDate = DateTime.now();
var tommorowDate = todayDate.add(Duration(days: 1));
var overmorrowDate = todayDate.add(Duration(days: 2));
DateTime selectedDate = tommorowDate;
String showDate =
    "${selectedDate.day}-${selectedDate.month}-${selectedDate.year}";

class DayData extends StatefulWidget {
  @override
  _DayDataState createState() => _DayDataState();
}

class _DayDataState extends State<DayData> {
  int branch = 0;
  @override
  void initState() {
    super.initState();
    fetchData();
    print("\n  CALLED  \n");
  }

  void fetchData() async {
    todayData = await fetchTodayData();
  }

  openDetail() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => OnWork()));
  }

  addNewData() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => RegisterNewData()),
    );
  }

  _selectDate(BuildContext context) async {
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
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
        showDate =
            "${selectedDate.day}-${selectedDate.month}-${selectedDate.year}";
      });
  }

  @override
  Widget build(BuildContext parentContext) {
    return Scaffold(
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
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => OnWork()));
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
                    onPressed: () {
                      setState(() {
                        if (selectedDate != tommorowDate) {
                          selectedDate = tommorowDate;
                          showDate =
                              "${selectedDate.day}-${selectedDate.month}-${selectedDate.year}";
                        }
                      });
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
                    onPressed: () {
                      setState(() {
                        if (selectedDate != overmorrowDate) {
                          selectedDate = overmorrowDate;
                          showDate =
                              "${selectedDate.day}-${selectedDate.month}-${selectedDate.year}";
                        }
                      });
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
                    child: Icon(Icons.calendar_today_outlined),
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
                child: //todayData.isNotEmpty ?
                    RefreshIndicator(
              onRefresh: () async {
                try {
                  setState(() async {
                    todayData = await fetchTodayData();
                  });
                  print(todayData.isEmpty);
                } catch (err) {
                  print("Refresh Bar Error: " + err);
                }
              },
              child: ListView.builder(
                itemCount: todayData.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: openDetail,
                    child: DayCardBox(
                      reg_no: todayData[index]['reg_no'],
                      is_complete: todayData[index]['is_complete'],
                      coat: todayData[index]['coat'],
                    ),
                  );
                },
              ),
            )
                // : Container(
                //     child: RaisedButton(
                //       onPressed: () {
                //         setState(() {});
                //       },
                //       child: Text("Refresh"),
                //     ),
                //   ),
                ),
          ),
          RaisedButton(
            onPressed: () {
              setState(() {
                //fetchData();
              });
            },
            child: Text(AppLocalizations.of(context).translate("refresh")),
          ),
        ],
      ),
    );
  }
}
