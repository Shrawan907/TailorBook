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
import 'package:flutter_svg/flutter_svg.dart';

Map info = {};
List detail = [];

class SearchResult extends StatefulWidget {
  final int regNo;
  final int branch;
  String status = "";
  SearchResult({this.regNo, this.branch});
  @override
  _SearchResultState createState() =>
      _SearchResultState(regNo: this.regNo, branch: this.branch);
}

class _SearchResultState extends State<SearchResult> {
  final int regNo;
  final int branch;
  _SearchResultState({this.regNo, this.branch});
  @override
  void initState() {
    super.initState();
    initialData();
  }

  void initialData() async {
    await fetchInfo();
    setState(() {});
  }

  Future fetchInfo() async {
    info.clear();
    info = (await fetchDetail(this.regNo, this.branch));
  }

  @override
  Widget build(BuildContext parentContext) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context).translate("search_result"),
        ), //Text(AppLocalizations.of(context).translate("t_return_today")),
        actions: [
          GestureDetector(
            onTap: () {
              setState(() {});
            },
            child: Container(
                margin: EdgeInsets.only(right: 20), child: Icon(Icons.refresh)),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(20),
          child: info.isEmpty || info.containsKey("no_detail")
              ? Center(
                  child: Container(
                    margin: EdgeInsets.all(20),
                    child: Text(info.isEmpty
                        ? AppLocalizations.of(context).translate("please_wait")
                        : "Entry with given Register Number is not exist!"),
                  ),
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: 40,
                      decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(width: 2, color: Colors.amber)),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                              child: Text(AppLocalizations.of(context).translate("reg_no")+".:"+"$regNo",
                                  style: TextStyle(fontSize: 25))),
                          Expanded(
                            child: info.containsKey("return_date")
                                ? Text('${info["return_date"]}',
                                    style: TextStyle(fontSize: 20))
                                : null,
                          ),
                        ],
                      ),
                    ),
                    if (info.containsKey("coat")) dataContainer("coat"),
                    if (info.containsKey("jacket")) dataContainer("jacket"),
                    if (info.containsKey("pent")) dataContainer("pent"),
                    if (info.containsKey("shirt")) dataContainer("shirt"),
                    if (info.containsKey("kurta")) dataContainer("kurta"),
                    if (info.containsKey("pajama")) dataContainer("pajama"),
                    if (info.containsKey("achkan")) dataContainer("achkan"),
                    if (info.containsKey("others")) dataContainer("others"),
                  ],
                ),
        ),
      ),
    );
  }

  Container dataContainer(String key) {
    return Container(
      margin: EdgeInsets.only(top: 20),
      padding: EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
          border: Border(bottom: BorderSide(width: 1, color: Colors.amber))),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              SvgPicture.asset(
                'assets/images/$key.svg',
                height: 25,
                width: 25,
                color: Colors.amber,
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                  AppLocalizations.of(context).translate("$key") + " ( " + info["$key"]["count"].toString() + " )",
                style: TextStyle(fontSize: 25, color: Colors.amber),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          for (int i = 0; i < info["$key"]["count"]; i++)
            Row(
              children: [
                Expanded(
                  child: Icon(Icons.arrow_right_alt),
                ),
                Expanded(
                    child: Text(AppLocalizations.of(context).translate(info["$key"]["status"][i])/**/,
                        style: TextStyle(fontSize: 20))),
              ],
            ),
        ],
      ),
    );
  }
}
