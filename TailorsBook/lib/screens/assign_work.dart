import 'package:TailorsBook/common/buttons.dart';
import 'package:TailorsBook/common/cardBox.dart';
import 'package:TailorsBook/locale/app_localization.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';

class AssignWork extends StatefulWidget {
  @override
  _AssignWorkState createState() => _AssignWorkState();
}

List items = [];

class _AssignWorkState extends State<AssignWork> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _textController = new TextEditingController();
  int branch = 0;
  int val1 = 0;
  int value = 0;
  int regNo = -1, count = -1;
  String type;
  @override
  Widget build(BuildContext parentContext) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Name"),
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.max,
          children: [
            buildHeader("add_shirt", context),
            Expanded(
              child: Container(
                child: Column(
                  children: [
                    for (var item in items)
                      Container(
                        color: Colors.yellow,
                        height: 50,
                        margin: EdgeInsets.all(5),
                        child: Row(
                          children: [
                            Expanded(
                              child: Center(
                                child: Text(item["regNo"]),
                              ),
                            ),
                            Expanded(
                              child: Center(
                                child: Text(item["count"]),
                              ),
                            ),
                            Expanded(
                              child: Center(
                                child: Text(AppLocalizations.of(context)
                                    .translate(item["type"])),
                              ),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Card(
              child: Container(
                height: 160,
                width: double.infinity,
                color: Colors.amber[50],
                child: Column(
                  children: [
                    Container(
                      //color: Colors.yellow,
                      height: 45,
                      margin: EdgeInsets.only(
                          left: 10, right: 10, top: 5, bottom: 5),
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                branch = branch ^ 1;
                              });
                            },
                            child: Container(
                              width: 40,
                              height: 40,
                              margin: EdgeInsets.only(right: 10),
                              decoration: BoxDecoration(
                                border: Border.all(width: 1),
                              ),
                              child: Center(
                                child: Text(
                                  branch == 0 ? "A" : "B",
                                  style: TextStyle(fontSize: 30),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(2),
                            height: 50,
                            width: 150,
                            color: Colors.white,
                            child: Form(
                              child: TextFormField(
                                onChanged: (value) {
                                  regNo = int.parse(value);
                                },
                                controller: _textController,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  hintText: 'Reg. No.',
                                  fillColor: Colors.white,
                                  contentPadding: EdgeInsets.only(
                                      bottom: 0, left: 10, right: 10),
                                ),
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly
                                ],
                                keyboardType: TextInputType.number,
                                style: TextStyle(fontSize: 30),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              //margin: EdgeInsets.only(left: 40, right: 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  UpdateValueButton(
                                    icon: Icons.remove,
                                    perform: () {
                                      setState(() {
                                        if (val1 > 1) val1--;
                                        count = val1;
                                      });
                                    },
                                  ),
                                  Container(
                                    height: 30,
                                    width: 40,
                                    child: Center(
                                      child: Text(
                                        val1.toString(),
                                        style: TextStyle(
                                          fontSize: 25,
                                        ),
                                      ),
                                    ),
                                  ),
                                  UpdateValueButton(
                                    icon: Icons.add,
                                    perform: () {
                                      setState(() {
                                        val1++;
                                        count = val1;
                                      });
                                    },
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      height: 45,
                      margin: EdgeInsets.only(left: 10, right: 10),
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: [
                          Container(
                              width: 90,
                              child: Center(
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      value = 0;
                                      type = "shirt";
                                    });
                                  },
                                  child: Text(
                                      AppLocalizations.of(context)
                                          .translate("shirt"),
                                      style: value == 0
                                          ? TextStyle(
                                              fontSize: 25, color: Colors.blue)
                                          : null),
                                ),
                              )),
                          SizedBox(
                            width: 10,
                          ),
                          Container(
                              width: 90,
                              child: Center(
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      value = 1;
                                      type = "kurta";
                                    });
                                  },
                                  child: Text(
                                      AppLocalizations.of(context)
                                          .translate("kurta"),
                                      style: value == 1
                                          ? TextStyle(
                                              fontSize: 25, color: Colors.blue)
                                          : null),
                                ),
                              )),
                          SizedBox(
                            width: 10,
                          ),
                          Container(
                              width: 100,
                              child: Center(
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      value = 2;
                                      type = "pajama";
                                    });
                                  },
                                  child: Text(
                                      AppLocalizations.of(context)
                                          .translate("pajama"),
                                      style: value == 2
                                          ? TextStyle(
                                              fontSize: 25, color: Colors.blue)
                                          : null),
                                ),
                              )),
                          SizedBox(
                            width: 10,
                          ),
                          Container(
                              width: 90,
                              child: Center(
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      value = 3;
                                      type = "safari";
                                    });
                                  },
                                  child: Text(
                                      AppLocalizations.of(context)
                                          .translate("safari"),
                                      style: value == 3
                                          ? TextStyle(
                                              fontSize: 25, color: Colors.blue)
                                          : null),
                                ),
                              )),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    RaisedButton(
                      onPressed: () {
                        if (regNo != -1 && count > 0 && type != null) {
                          items.add({
                            "regNo": regNo.toString(),
                            "type": type,
                            "count": count.toString()
                          });
                        }
                        setState(() {
                          regNo = -1;
                          type = null;
                          count = -1;
                          val1 = 0;
                          value = 0;
                          _textController.clear();
                        });
                      },
                      child: Container(
                        height: 45,
                        child: Center(
                          child: Text(
                            AppLocalizations.of(context).translate("save"),
                            style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                color: Colors.deepPurple),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
