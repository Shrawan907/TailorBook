import 'dart:async';
import 'package:TailorsBook/locale/app_localization.dart';
import 'package:TailorsBook/screens/signin.dart';
import 'package:TailorsBook/screens/updateData.dart';
import 'package:flutter/material.dart';
import 'package:TailorsBook/common/nav_drower.dart';
import 'package:TailorsBook/common/cardBox.dart';
import 'package:TailorsBook/handle_cloud/data_file.dart';
import 'package:TailorsBook/screens/register_new.dart';
import 'package:TailorsBook/screens/on_working.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../locale/app_localization.dart';

Map info = {};
List detail = [];

DateTime selectedDate = DateTime.now();

class SearchResult extends StatefulWidget {
  final int regNo;
  final int branch;
  SearchResult({this.regNo, this.branch});

  @override
  _SearchResultState createState() =>
      _SearchResultState(regNo: this.regNo, branch: this.branch);
}

class _SearchResultState extends State<SearchResult> {
  final int regNo;
  final int branch;
  String showDate = '...';
  _SearchResultState({this.regNo, this.branch});

  bool waiting = true;
  @override
  void initState() {
    super.initState();
    initialData();
  }

  void initialData() async {
    await fetchInfo();
    waiting = false;
    setState(() {});
  }

  Future fetchInfo() async {
    info.clear();
    info = (await fetchDetail(this.regNo, this.branch));
    try {
      if (info.containsKey('returnDate')) {
        selectedDate = info['returnDate'];
        showDate =
            "${selectedDate.day}-${selectedDate.month}-${selectedDate.year}";
      }
    } catch (err) {
      print(err);
    }
  }

  @override
  Widget build(BuildContext parentContext) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context).translate("search_result") +
              (branch == 0 ? " [ A ]" : " [ B ]"),
        ), //Text(AppLocalizations.of(context).translate("t_return_today")),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 30),
            child: waiting == false
                ? GestureDetector(
                    onTap: () {
                      if (info.isNotEmpty) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    UpdateData(initialDetail: info)));
                      } else {
                        Navigator.pop(context);
                      }
                    },
                    child: Center(
                      child: Icon(Icons.edit),
                    ),
                  )
                : Container(),
          ),
          GestureDetector(
            onTap: () {
              if (info.isNotEmpty) waiting = false;
              setState(() {});
            },
            child: Container(
                margin: EdgeInsets.only(right: 20), child: Icon(Icons.refresh)),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await fetchInfo();
          setState(() {});
        },
        child: ListView(
          children: [
            Container(
              padding: EdgeInsets.all(20),
              child: waiting == true
                  ? Center(
                      child: Container(
                        margin: EdgeInsets.all(20),
                        child: Text(info.isEmpty
                            ? AppLocalizations.of(context)
                                .translate("please_wait")
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
                                bottom:
                                    BorderSide(width: 2, color: Colors.amber)),
                          ),
                          child: Row(
                            children: [
                              Container(
                                child: Text(
                                    AppLocalizations.of(context)
                                        .translate("reg_no"),
                                    style: TextStyle(
                                      fontSize: 20,
                                    )),
                              ),
                              Expanded(
                                  child: Text(
                                      (branch == 0 ? " A" : " B") + " $regNo",
                                      style: TextStyle(
                                          fontSize: 25,
                                          fontWeight: FontWeight.bold,
                                          color: branch == 0
                                              ? Colors.deepPurple
                                              : Colors.red[800]))),
                              Expanded(
                                  child: Text(showDate,
                                      style: TextStyle(fontSize: 20))),
                            ],
                          ),
                        ),
                        if (info != null &&
                            info.containsKey('delivered') &&
                            info['delivered'])
                          Container(
                            margin: EdgeInsets.only(top: 10),
                            child: Text(
                              AppLocalizations.of(context)
                                  .translate('delivered'),
                              style: TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        if (info.containsKey("coat")) dataContainer("coat"),
                        if (info.containsKey("jacket")) dataContainer("jacket"),
                        if (info.containsKey("pent")) dataContainer("pent"),
                        if (info.containsKey("shirt")) dataContainer("shirt"),
                        if (info.containsKey("kurta")) dataContainer("kurta"),
                        if (info.containsKey("pajama")) dataContainer("pajama"),
                        if (info.containsKey("achkan")) dataContainer("achkan"),
                        if (info.containsKey("jodJacket"))
                          dataContainer("jodJacket"),
                        if (info.containsKey("blazer")) dataContainer("blazer"),
                        if (info.containsKey("safari")) dataContainer("safari"),
                        if (info.containsKey("others")) dataContainer("others"),
                      ],
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Container dataContainer(String key) {
    int count = 0;
    if ((info[key]).containsKey('count')) {
      count = info[key]['count'];
    }
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
                AppLocalizations.of(context).translate("$key") + " ( $count )",
                style: TextStyle(fontSize: 25, color: Colors.amber),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          for (int i = 0; i < count; i++)
            Row(
              children: [
                Expanded(
                  child: Icon(Icons.arrow_right_alt),
                ),
                Expanded(
                    child: Text(
                        AppLocalizations.of(context)
                            .translate(info["$key"]["status"][i]),
                        style: TextStyle(fontSize: 20))),
              ],
            ),
        ],
      ),
    );
  }
}
