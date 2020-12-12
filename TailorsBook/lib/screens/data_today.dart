import 'dart:async';
import 'package:TailorsBook/signin.dart';
import 'package:flutter/material.dart';
import 'package:TailorsBook/common/nav_drower.dart';
import 'package:TailorsBook/common/cardBox.dart';
import 'package:TailorsBook/handle_cloud/data_file.dart';
import 'package:TailorsBook/screens/register_new.dart';
import 'package:TailorsBook/screens/on_working.dart';

List todayData = [];

class DataToday extends StatefulWidget {
  @override
  _DataTodayState createState() => _DataTodayState();
}

class _DataTodayState extends State<DataToday> {
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
          ),
          backgroundColor: branch == 0 ? Colors.blueAccent : Colors.blueGrey,
        ),
      ),
      backgroundColor: Colors.blue,
      drawer: NavDrawer(),
      appBar: AppBar(
        title: Text("Return Today"),
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
                side: BorderSide(color: Colors.blue),
              ),
              color: branch == 0 ? Colors.blueAccent : Colors.blueGrey,
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
          SizedBox(
            height: 2,
          ),
          Container(
            height: 20,
            decoration: BoxDecoration(
              color: Colors.cyan,
              border: Border(
                bottom: BorderSide(
                  color: Colors.white,
                  width: 1.0,
                ),
              ),
            ),
            padding: EdgeInsets.only(left: 30, right: 0),
            child: Container(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                      child: Text(
                    "reg_no",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: Colors.white),
                  )),
                  Expanded(
                      child: Text(
                    "coat",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: Colors.white),
                  )),
                  Expanded(
                      child: Text(
                    "complete",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: Colors.white),
                  ))
                ],
              ),
            ),
          ),
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
              child: Container(
                child: ListView.builder(
                  itemCount: todayData.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: openDetail,
                      child: CardBox(
                        reg_no: todayData[index]['reg_no'],
                        is_complete: todayData[index]['is_complete'],
                        coat: todayData[index]['coat'],
                      ),
                    );
                  },
                ),
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
            child: Text("Refresh"),
          ),
        ],
      ),
    );
  }
}
