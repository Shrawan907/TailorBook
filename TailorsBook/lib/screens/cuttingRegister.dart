import 'dart:async';
import 'package:TailorsBook/common/buttons.dart';
import 'package:TailorsBook/locale/app_localization.dart';
import 'package:TailorsBook/screens/signin.dart';
import 'package:flutter/material.dart';
import 'package:TailorsBook/common/nav_drower.dart';
import 'package:TailorsBook/common/cardBox.dart';
import 'package:TailorsBook/handle_cloud/data_file.dart';
import 'package:TailorsBook/screens/register_new.dart';
import 'package:TailorsBook/screens/on_working.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

List cuttingRegister = [];
List duplicateRegister = [];

class Cutting extends StatefulWidget {
  final String item;
  Cutting({this.item});
  @override
  _CuttingState createState() => _CuttingState(item: this.item);
}

class _CuttingState extends State<Cutting> {
  final String item;
  _CuttingState({this.item});
  bool searchBar = false;
  TextEditingController editingController = TextEditingController();
  @override
  void initState() {
    super.initState();
    print(item);
    getInitalData();
    print(item);
  }

  void getInitalData() async {
    await getData();
    setState(() {});
  }

  Future getData() async {
    cuttingRegister.clear();
    print(cuttingRegister);
    cuttingRegister = [...(await getCuttingRegister(item))];
    duplicateRegister.clear();
    duplicateRegister = [...cuttingRegister];
    searchBar = cuttingRegister.isNotEmpty;
    print(cuttingRegister);
  }

  void filterSearchResults(String query) {
    if (query.isNotEmpty) {
      List dummyListData = [];
      duplicateRegister.forEach((element) {
        if (element["regNo"].toString().contains(query)) {
          dummyListData.add(element);
        }
      });
      setState(() {
        print(duplicateRegister.length);
        cuttingRegister.clear();
        cuttingRegister.addAll(dummyListData);
      });
      return;
    } else {
      setState(() {
        print(duplicateRegister.length);
        cuttingRegister.clear();
        cuttingRegister = [...duplicateRegister];
      });
    }
  }

  @override
  Widget build(BuildContext parentContext) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title: Text(item),
        actions: <Widget>[
          searchBar
              ? Container(
            width: 150,
            height: 20,
            margin: EdgeInsets.only(right: 50, bottom: 5, top: 5),
            decoration: BoxDecoration(
              border: Border(bottom: BorderSide(width: 2)),
            ),
            child: TextField(
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              onChanged: (value) {
                filterSearchResults(value);
                print(value);
              },
              controller: editingController,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText:
                AppLocalizations.of(context).translate("search"),
                hintStyle: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                    fontWeight: FontWeight.normal),
                prefixIcon: Icon(
                  Icons.search,
                  color: Colors.black,
                ),
              ),
            ),
          )
              : Container(),
          GestureDetector(
              onTap: () async {
                await getData();
                setState(() {});
              },
              child: Container(
                padding: EdgeInsets.only(right: 20),
                child: Icon(Icons.refresh),
              )),
        ],
      ),
      body: Column(
        children: <Widget>[
          buildHeader("cuttingRegister", context),
          Expanded(
            child: Container(
              child: //register.isNotEmpty ?
              RefreshIndicator(
                onRefresh: () async {
                  try {
                    cleanCuttingRegister(this.item);
                    await getData();
                    setState(() {});
                  } catch (err) {
                    print("Refresh Bar Error: " + err);
                  }
                },
                child: Container(
                  child: ListView.builder(
                    itemCount: cuttingRegister.length,
                    itemBuilder: (context, index) {
                      return CuttingCardBox(
                          regNo: cuttingRegister[index]['regNo'],
                          count: cuttingRegister[index]['count'],
                          branch: cuttingRegister[index]['branch'],
                          returnDate: cuttingRegister[index]['returnDate'] !=
                              null
                              ? cuttingRegister[index]['returnDate'].toDate()
                              : null,
                          item: this.item,
                          function: () async {
                            await getData();
                            setState(() {});
                          });
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

/*
return CuttingCardBox(
                        regNo: cuttingRegister[index]['regNo'],
                        count: cuttingRegister[index]['count'],
                        branch: cuttingRegister[index]['branch'],
                        returnDate: cuttingRegister[index]['returnDate'] != null
                            ? cuttingRegister[index]['returnDate'].toDate()
                            : null,
                        item: this.item,
                      );
                      GestureDetector(
                        onTap: () async {
                          await onTap(
                              cuttingRegister[index]['regNo'],
                              cuttingRegister[index]['branch'],
                              cuttingRegister[index]['count']);
                          setState(() {});
                        },
                        child: Card(
                          color: Colors.red[50],
                          child: Container(
                            height: 40,
                            margin: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 5),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Expanded(
                                  child: Text(
                                    "${cuttingRegister[index]['regNo']}",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 30,
                                        color: cuttingRegister[index]
                                                    ['branch'] ==
                                                0
                                            ? Colors.deepPurple
                                            : Colors.red[800]),
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    "${cuttingRegister[index]['count']}",
                                    style: TextStyle(fontSize: 25),
                                  ),
                                ),
                                cuttingRegister[index]['returnDate'] != null
                                    ? Expanded(
                                        child: Text(
                                          '${cuttingRegister[index]['returnDate'].toDate().day} - ${cuttingRegister[index]['returnDate'].toDate().month}',
                                          style: TextStyle(fontSize: 25),
                                        ),
                                      )
                                    : Container(),
                              ],
                            ),
                          ),
                        ),
                      );
*/