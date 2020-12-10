import 'dart:async';
import 'package:TailorsBook/signin.dart';
import 'package:flutter/material.dart';
import 'package:TailorsBook/common/nav_drower.dart';
import 'package:TailorsBook/common/cardBox.dart';
import 'package:TailorsBook/handle_cloud/data_file.dart';

List todayData = [];

class DataToday extends StatefulWidget {
  @override
  _DataTodayState createState() => _DataTodayState();
}

class _DataTodayState extends State<DataToday> {
  @override
  void initState() {
    super.initState();
    fetchData();
  }

  void fetchData() async {
    todayData = await fetchTodayData();
  }

  openDetail() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => MyHomePage()));
  }

  @override
  Widget build(BuildContext parentContext) {
    return Scaffold(
      backgroundColor: Colors.blue,
      drawer: NavDrawer(),
      appBar: AppBar(
        title: Text("Return Today"),
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
              child: todayData.isNotEmpty
                  ? ListView.builder(
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
                    )
                  : Container(
                      child: RaisedButton(
                        onPressed: () {
                          setState(() {});
                        },
                        child: Text("Refresh"),
                      ),
                    ),
            ),
          ),
          RaisedButton(
            onPressed: () {
              setState(() {
                fetchData();
              });
            },
            child: Text("Refresh"),
          ),
        ],
      ),
    );
  }
}

/*
  const CardBox(
      {Key key,
      this.country,
      this.flag,
      this.confirmed,
      this.active,
      this.recovered,
      this.deaths})
      : super(key: key);
*/
