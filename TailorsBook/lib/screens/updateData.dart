import 'dart:async';
import 'package:TailorsBook/common/buttons.dart';
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
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

DateTime returnDate = DateTime.now();

class UpdateData extends StatefulWidget {
  final Map initialDetail;
  UpdateData({this.initialDetail});
  @override
  _UpdateDataState createState() =>
      _UpdateDataState(initialDetail: this.initialDetail);
}

class _UpdateDataState extends State<UpdateData> {
  int branch = 0;
  Map initialDetail;
  String showDate = "Not Get Yet";
  bool change = false;
  int regNo = 0;
  int coatVal = 0,
      pentVal = 0,
      shirtVal = 0,
      jacketVal = 0,
      kurtaVal = 0,
      pajamaVal = 0,
      achkanVal = 0,
      othersVal = 0;
  List coatList = [],
      pentList = [],
      shirtList = [],
      jacketList = [],
      kurtaList = [],
      pajamaList = [],
      achkanList = [],
      othersList = [];

  _UpdateDataState({this.initialDetail});
  @override
  void initState() {
    super.initState();
    initialData();
  }

  void initialData() {
    if (initialDetail.containsKey("branch")) {
      branch = initialDetail["branch"];
    }
    if (initialDetail.containsKey('regNo')) {
      regNo = initialDetail['regNo'];
    }
    if (initialDetail.containsKey("returnDate") &&
        initialDetail['returnDate'] != null) {
      returnDate = initialDetail['returnDate'];
      showDate =
          "${selectedDate.day}-${selectedDate.month}-${selectedDate.year}";
    }
    if (initialDetail.containsKey('coat')) {
      coatVal = initialDetail['coat']['count'];
      coatList = [...(initialDetail['coat']['status'])];
    } else {
      coatVal = 0;
      coatList.clear();
    }
    if (initialDetail.containsKey('pent')) {
      pentVal = initialDetail['pent']['count'];
      pentList = [...(initialDetail['pent']['status'])];
    } else {
      pentVal = 0;
      pentList.clear();
    }
    if (initialDetail.containsKey('shirt')) {
      shirtVal = initialDetail['shirt']['count'];
      shirtList = [...(initialDetail['shirt']['status'])];
    } else {
      shirtVal = 0;
      shirtList.clear();
    }
    if (initialDetail.containsKey('jacket')) {
      jacketVal = initialDetail['jacket']['count'];
      jacketList = [...(initialDetail['jacket']['status'])];
    } else {
      jacketVal = 0;
      jacketList.clear();
    }
    if (initialDetail.containsKey('kurta')) {
      kurtaVal = initialDetail['kurta']['count'];
      kurtaList = [...(initialDetail['kurta']['status'])];
    } else {
      kurtaVal = 0;
      kurtaList.clear();
    }
    if (initialDetail.containsKey('pajama')) {
      pajamaVal = initialDetail['pajama']['count'];
      pajamaList = [...(initialDetail['pajama']['status'])];
    } else {
      pajamaVal = 0;
      pajamaList.clear();
    }
    if (initialDetail.containsKey('achkan')) {
      achkanVal = initialDetail['achkan']['count'];
      achkanList = [...(initialDetail['achkan']['status'])];
    } else {
      achkanVal = 0;
      achkanList.clear();
    }
    if (initialDetail.containsKey('others')) {
      othersVal = initialDetail['others']['count'];
      othersList = [...(initialDetail['others']['status'])];
    } else {
      othersVal = 0;
      othersList.clear();
    }
  }

  _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: returnDate, // Refer step 1
      firstDate: DateTime(2020),
      lastDate: DateTime(2050),
      builder: (context, child) {
        return Theme(
          data: ThemeData.light(), // This will change to light theme.
          child: child,
        );
      },
    );
    if (picked != null)
      setState(() {
        returnDate = picked;
        showDate = "${returnDate.day}-${returnDate.month}-${returnDate.year}";
      });
  }

  Future changeRegNo() async {
    int tempRegNo = regNo;
    int tempbranch = branch;
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              content: Container(
                height: 200,
                child: Column(
                  children: [
                    Text('This Will Change Reg. No.'),
                    Expanded(
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              if (tempbranch == 0)
                                tempbranch = 1;
                              else
                                tempbranch = 0;
                              setState(() {});
                            },
                            child: Container(
                              padding: EdgeInsets.all(10),
                              margin: EdgeInsets.only(right: 10),
                              decoration:
                                  BoxDecoration(border: Border.all(width: 1)),
                              child: Text(tempbranch == 0 ? "A" : "B",
                                  style: TextStyle(fontSize: 22)),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              child: TextFormField(
                                validator: (val) {
                                  if (val.trim().isEmpty)
                                    return AppLocalizations.of(context)
                                        .translate("must_not_empty");
                                  else if (val.trim().length > 6)
                                    return AppLocalizations.of(context)
                                        .translate("wrong_entry");
                                  else
                                    return null;
                                },
                                onChanged: (value) {
                                  tempRegNo = int.parse(value);
                                  print(tempRegNo);
                                },
                                initialValue: tempRegNo.toString(),
                                decoration: InputDecoration(
                                  contentPadding:
                                      EdgeInsets.only(left: 10, right: 10),
                                  labelStyle: TextStyle(fontSize: 15.0),
                                  hintText: AppLocalizations.of(context)
                                      .translate("reg_no_full"),
                                ),
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly
                                ],
                                keyboardType: TextInputType.number,
                                style: TextStyle(fontSize: 25),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.all(10),
                            child: RaisedButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Center(
                                child: Text('BACK'),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.all(10),
                            child: RaisedButton(
                              onPressed: () {
                                regNo = tempRegNo;
                                branch = tempbranch;
                                print(regNo);
                                Navigator.pop(context);
                              },
                              child: Center(
                                child: Text('SAVE'),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          });
        });
  }

  @override
  Widget build(BuildContext parentContext) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Update Detials",
        ), //Text(AppLocalizations.of(context).translate("t_return_today")),
        actions: [
          GestureDetector(
            onTap: () {
              setState(() {
                initialData();
                setState(() {});
              });
            },
            child: Container(
                margin: EdgeInsets.only(right: 40), child: Icon(Icons.restore)),
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                initialData();
                setState(() {});
              });
            },
            child: Container(
                margin: EdgeInsets.only(right: 20),
                child: Center(
                    child: Text(
                  "SAVE",
                  style: TextStyle(
                      fontSize: 20,
                      color: change ? Colors.black : Colors.black38),
                ))),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              child: SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Container(
                        height: 50,
                        child: Row(
                          children: [
                            Container(
                              width: 130,
                              padding: EdgeInsets.all(10),
                              child: Text(
                                  AppLocalizations.of(context)
                                          .translate("reg_no") +
                                      ":",
                                  style: TextStyle(fontSize: 22)),
                            ),
                            Expanded(
                              child: Container(
                                child: Text(
                                  (branch == 0 ? "A " : "B ") + '$regNo',
                                  style: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () async {
                                await changeRegNo();
                                print(regNo);
                                setState(() {});
                              },
                              child: Container(
                                padding: EdgeInsets.only(right: 20),
                                child: Icon(Icons.edit, color: Colors.amber),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 10),
                      Container(
                        height: 50,
                        decoration: BoxDecoration(
                          border: Border(
                              bottom:
                                  BorderSide(width: 1, color: Colors.purple)),
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 130,
                              padding: EdgeInsets.all(10),
                              child: Text("Return" + ":",
                                  style: TextStyle(fontSize: 22)),
                            ),
                            Expanded(
                                child: Text(showDate,
                                    style: TextStyle(fontSize: 20))),
                            Container(
                              padding: const EdgeInsets.all(0),
                              margin: EdgeInsets.only(right: 10),
                              width: 55,
                              child: Center(
                                child: RaisedButton(
                                    color: Colors.white,
                                    onPressed: () {
                                      _selectDate(context);
                                    },
                                    child: Icon(
                                      Icons.date_range,
                                      //color: Colors.amber,
                                    )),
                              ),
                            ),
                          ],
                        ),
                      ),
                      coatVal > 0
                          ? Container(
                              margin: EdgeInsets.only(top: 20),
                              padding: EdgeInsets.only(bottom: 10),
                              decoration: BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(
                                          width: 1, color: Colors.purple))),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      SvgPicture.asset(
                                        'assets/images/coat.svg',
                                        height: 25,
                                        width: 25,
                                        color: Colors.amber,
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Expanded(
                                        child: Text(
                                          "coat",
                                          style: TextStyle(
                                              fontSize: 25,
                                              color: Colors.amber),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 40,
                                      ),
                                      UpdateValueButton(
                                        icon: Icons.remove,
                                        perform: () {
                                          if (coatVal > 1) {
                                            coatVal--;
                                            coatList.removeLast();
                                            setState(() {});
                                          }
                                        },
                                      ),
                                      Text(
                                        coatVal.toString(),
                                        style: TextStyle(
                                            fontSize: 25, color: Colors.amber),
                                      ),
                                      UpdateValueButton(
                                        icon: Icons.add,
                                        perform: () {
                                          coatVal++;
                                          coatList.add('uncut');
                                          setState(() {});
                                          print(coatVal);
                                        },
                                      ),
                                      SizedBox(width: 30),
                                      GestureDetector(
                                        onTap: () {
                                          coatVal = 0;
                                          coatList.clear();
                                          setState(() {});
                                        },
                                        child: Icon(
                                          Icons.delete,
                                          color: Colors.red,
                                        ),
                                      ),
                                      SizedBox(width: 10),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  for (int i = 0; i < coatList.length; i++)
                                    Container(
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: Icon(Icons.arrow_right_alt),
                                          ),
                                          Container(
                                            width: 200,
                                            child: DropdownButton(
                                                isExpanded: true,
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    color: Colors.black),
                                                value: coatList[i],
                                                autofocus: true,
                                                focusColor: Colors.amber,
                                                items: <String>[
                                                  'uncut',
                                                  'cut',
                                                  'complete',
                                                ].map((String value) {
                                                  return new DropdownMenuItem<
                                                      String>(
                                                    value: value,
                                                    child: new Text(value),
                                                  );
                                                }).toList(),
                                                onChanged: (value) {
                                                  coatList[i] = value;
                                                  setState(() {});
                                                }),
                                          ),
                                        ],
                                      ),
                                    ),
                                ],
                              ),
                            )
                          : Container(
                              margin: EdgeInsets.only(top: 20),
                              padding: EdgeInsets.only(bottom: 10),
                              decoration: BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(
                                          width: 1, color: Colors.purple))),
                              child: Row(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      coatVal = 1;
                                      coatList = ['uncut'];
                                      setState(() {});
                                    },
                                    child: SvgPicture.asset(
                                      'assets/images/coat.svg',
                                      height: 25,
                                      width: 25,
                                      color: Colors.black38,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    child: Text(
                                      "coat",
                                      style: TextStyle(
                                          fontSize: 25, color: Colors.black38),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                      pentVal > 0
                          ? Container(
                              margin: EdgeInsets.only(top: 20),
                              padding: EdgeInsets.only(bottom: 10),
                              decoration: BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(
                                          width: 1, color: Colors.purple))),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      SvgPicture.asset(
                                        'assets/images/pent.svg',
                                        height: 25,
                                        width: 25,
                                        color: Colors.amber,
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Expanded(
                                        child: Text(
                                          "pent",
                                          style: TextStyle(
                                              fontSize: 25,
                                              color: Colors.amber),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 40,
                                      ),
                                      UpdateValueButton(
                                        icon: Icons.remove,
                                        perform: () {
                                          if (pentVal > 1) {
                                            pentVal--;
                                            pentList.removeLast();
                                            setState(() {});
                                          }
                                        },
                                      ),
                                      Text(
                                        pentVal.toString(),
                                        style: TextStyle(
                                            fontSize: 25, color: Colors.amber),
                                      ),
                                      UpdateValueButton(
                                        icon: Icons.add,
                                        perform: () {
                                          pentVal++;
                                          pentList.add('uncut');
                                          setState(() {});
                                        },
                                      ),
                                      SizedBox(width: 30),
                                      GestureDetector(
                                        onTap: () {
                                          pentVal = 0;
                                          pentList.clear();
                                          setState(() {});
                                        },
                                        child: Icon(
                                          Icons.delete,
                                          color: Colors.red,
                                        ),
                                      ),
                                      SizedBox(width: 10),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  for (int i = 0; i < pentList.length; i++)
                                    Container(
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: Icon(Icons.arrow_right_alt),
                                          ),
                                          Container(
                                            width: 200,
                                            child: DropdownButton(
                                                isExpanded: true,
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    color: Colors.black),
                                                value: pentList[i],
                                                autofocus: true,
                                                focusColor: Colors.amber,
                                                items: <String>[
                                                  'uncut',
                                                  'cut',
                                                  'complete',
                                                ].map((String value) {
                                                  return new DropdownMenuItem<
                                                      String>(
                                                    value: value,
                                                    child: new Text(value),
                                                  );
                                                }).toList(),
                                                onChanged: (value) {
                                                  pentList[i] = value;
                                                  setState(() {});
                                                }),
                                          ),
                                        ],
                                      ),
                                    ),
                                ],
                              ),
                            )
                          : Container(
                              margin: EdgeInsets.only(top: 20),
                              padding: EdgeInsets.only(bottom: 10),
                              decoration: BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(
                                          width: 1, color: Colors.purple))),
                              child: Row(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      pentVal = 1;
                                      pentList = ['uncut'];
                                      setState(() {});
                                    },
                                    child: SvgPicture.asset(
                                      'assets/images/pent.svg',
                                      height: 25,
                                      width: 25,
                                      color: Colors.black38,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    child: Text(
                                      "pent",
                                      style: TextStyle(
                                          fontSize: 25, color: Colors.black38),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                      shirtVal > 0
                          ? Container(
                              margin: EdgeInsets.only(top: 20),
                              padding: EdgeInsets.only(bottom: 10),
                              decoration: BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(
                                          width: 1, color: Colors.purple))),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      SvgPicture.asset(
                                        'assets/images/shirt.svg',
                                        height: 25,
                                        width: 25,
                                        color: Colors.amber,
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Expanded(
                                        child: Text(
                                          "shirt",
                                          style: TextStyle(
                                              fontSize: 25,
                                              color: Colors.amber),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 40,
                                      ),
                                      UpdateValueButton(
                                        icon: Icons.remove,
                                        perform: () {
                                          if (shirtVal > 1) {
                                            shirtVal--;
                                            shirtList.removeLast();
                                            setState(() {});
                                          }
                                        },
                                      ),
                                      Text(
                                        shirtVal.toString(),
                                        style: TextStyle(
                                            fontSize: 25, color: Colors.amber),
                                      ),
                                      UpdateValueButton(
                                        icon: Icons.add,
                                        perform: () {
                                          shirtVal++;
                                          shirtList.add('uncut');
                                          setState(() {});
                                        },
                                      ),
                                      SizedBox(width: 30),
                                      GestureDetector(
                                        onTap: () {
                                          shirtVal = 0;
                                          shirtList.clear();
                                          setState(() {});
                                        },
                                        child: Icon(
                                          Icons.delete,
                                          color: Colors.red,
                                        ),
                                      ),
                                      SizedBox(width: 10),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  for (int i = 0; i < shirtList.length; i++)
                                    Container(
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: Icon(Icons.arrow_right_alt),
                                          ),
                                          Container(
                                            width: 200,
                                            child: DropdownButton(
                                                isExpanded: true,
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    color: Colors.black),
                                                value: shirtList[i],
                                                autofocus: true,
                                                focusColor: Colors.amber,
                                                items: <String>[
                                                  'uncut',
                                                  'cut',
                                                  'complete',
                                                ].map((String value) {
                                                  return new DropdownMenuItem<
                                                      String>(
                                                    value: value,
                                                    child: new Text(value),
                                                  );
                                                }).toList(),
                                                onChanged: (value) {
                                                  shirtList[i] = value;
                                                  setState(() {});
                                                }),
                                          ),
                                        ],
                                      ),
                                    ),
                                ],
                              ),
                            )
                          : Container(
                              margin: EdgeInsets.only(top: 20),
                              padding: EdgeInsets.only(bottom: 10),
                              decoration: BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(
                                          width: 1, color: Colors.purple))),
                              child: Row(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      shirtVal = 1;
                                      shirtList = ['uncut'];
                                      setState(() {});
                                    },
                                    child: SvgPicture.asset(
                                      'assets/images/shirt.svg',
                                      height: 25,
                                      width: 25,
                                      color: Colors.black38,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    child: Text(
                                      "shirt",
                                      style: TextStyle(
                                          fontSize: 25, color: Colors.black38),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                      jacketVal > 0
                          ? Container(
                              margin: EdgeInsets.only(top: 20),
                              padding: EdgeInsets.only(bottom: 10),
                              decoration: BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(
                                          width: 1, color: Colors.purple))),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      SvgPicture.asset(
                                        'assets/images/jacket.svg',
                                        height: 25,
                                        width: 25,
                                        color: Colors.amber,
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Expanded(
                                        child: Text(
                                          "jacket",
                                          style: TextStyle(
                                              fontSize: 25,
                                              color: Colors.amber),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 40,
                                      ),
                                      UpdateValueButton(
                                        icon: Icons.remove,
                                        perform: () {
                                          if (jacketVal > 1) {
                                            jacketVal--;
                                            jacketList.removeLast();
                                            setState(() {});
                                          }
                                        },
                                      ),
                                      Text(
                                        jacketVal.toString(),
                                        style: TextStyle(
                                            fontSize: 25, color: Colors.amber),
                                      ),
                                      UpdateValueButton(
                                        icon: Icons.add,
                                        perform: () {
                                          jacketVal++;
                                          jacketList.add('uncut');
                                          setState(() {});
                                        },
                                      ),
                                      SizedBox(width: 30),
                                      GestureDetector(
                                        onTap: () {
                                          jacketVal = 0;
                                          jacketList.clear();
                                          setState(() {});
                                        },
                                        child: Icon(
                                          Icons.delete,
                                          color: Colors.red,
                                        ),
                                      ),
                                      SizedBox(width: 10),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  for (int i = 0; i < jacketList.length; i++)
                                    Container(
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: Icon(Icons.arrow_right_alt),
                                          ),
                                          Container(
                                            width: 200,
                                            child: DropdownButton(
                                                isExpanded: true,
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    color: Colors.black),
                                                value: jacketList[i],
                                                autofocus: true,
                                                focusColor: Colors.amber,
                                                items: <String>[
                                                  'uncut',
                                                  'cut',
                                                  'complete',
                                                ].map((String value) {
                                                  return new DropdownMenuItem<
                                                      String>(
                                                    value: value,
                                                    child: new Text(value),
                                                  );
                                                }).toList(),
                                                onChanged: (value) {
                                                  jacketList[i] = value;
                                                  setState(() {});
                                                }),
                                          ),
                                        ],
                                      ),
                                    ),
                                ],
                              ),
                            )
                          : Container(
                              margin: EdgeInsets.only(top: 20),
                              padding: EdgeInsets.only(bottom: 10),
                              decoration: BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(
                                          width: 1, color: Colors.purple))),
                              child: Row(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      jacketVal = 1;
                                      jacketList = ['uncut'];
                                      setState(() {});
                                    },
                                    child: SvgPicture.asset(
                                      'assets/images/jacket.svg',
                                      height: 25,
                                      width: 25,
                                      color: Colors.black38,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    child: Text(
                                      "jacket",
                                      style: TextStyle(
                                          fontSize: 25, color: Colors.black38),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                      kurtaVal > 0
                          ? Container(
                              margin: EdgeInsets.only(top: 20),
                              padding: EdgeInsets.only(bottom: 10),
                              decoration: BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(
                                          width: 1, color: Colors.purple))),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      SvgPicture.asset(
                                        'assets/images/kurta.svg',
                                        height: 25,
                                        width: 25,
                                        color: Colors.amber,
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Expanded(
                                        child: Text(
                                          "kurta",
                                          style: TextStyle(
                                              fontSize: 25,
                                              color: Colors.amber),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 40,
                                      ),
                                      UpdateValueButton(
                                        icon: Icons.remove,
                                        perform: () {
                                          if (kurtaVal > 1) {
                                            kurtaVal--;
                                            kurtaList.removeLast();
                                            setState(() {});
                                          }
                                        },
                                      ),
                                      Text(
                                        kurtaVal.toString(),
                                        style: TextStyle(
                                            fontSize: 25, color: Colors.amber),
                                      ),
                                      UpdateValueButton(
                                        icon: Icons.add,
                                        perform: () {
                                          kurtaVal++;
                                          kurtaList.add('uncut');
                                          setState(() {});
                                        },
                                      ),
                                      SizedBox(width: 30),
                                      GestureDetector(
                                        onTap: () {
                                          kurtaVal = 0;
                                          kurtaList.clear();
                                          setState(() {});
                                        },
                                        child: Icon(
                                          Icons.delete,
                                          color: Colors.red,
                                        ),
                                      ),
                                      SizedBox(width: 10),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  for (int i = 0; i < kurtaList.length; i++)
                                    Container(
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: Icon(Icons.arrow_right_alt),
                                          ),
                                          Container(
                                            width: 200,
                                            child: DropdownButton(
                                                isExpanded: true,
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    color: Colors.black),
                                                value: kurtaList[i],
                                                autofocus: true,
                                                focusColor: Colors.amber,
                                                items: <String>[
                                                  'uncut',
                                                  'cut',
                                                  'complete',
                                                ].map((String value) {
                                                  return new DropdownMenuItem<
                                                      String>(
                                                    value: value,
                                                    child: new Text(value),
                                                  );
                                                }).toList(),
                                                onChanged: (value) {
                                                  kurtaList[i] = value;
                                                  setState(() {});
                                                }),
                                          ),
                                        ],
                                      ),
                                    ),
                                ],
                              ),
                            )
                          : Container(
                              margin: EdgeInsets.only(top: 20),
                              padding: EdgeInsets.only(bottom: 10),
                              decoration: BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(
                                          width: 1, color: Colors.purple))),
                              child: Row(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      kurtaVal = 1;
                                      kurtaList = ['uncut'];
                                      change = true;
                                      setState(() {});
                                    },
                                    child: SvgPicture.asset(
                                      'assets/images/kurta.svg',
                                      height: 25,
                                      width: 25,
                                      color: Colors.black38,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    child: Text(
                                      "kurta",
                                      style: TextStyle(
                                          fontSize: 25, color: Colors.black38),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                      pajamaVal > 0
                          ? Container(
                              margin: EdgeInsets.only(top: 20),
                              padding: EdgeInsets.only(bottom: 10),
                              decoration: BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(
                                          width: 1, color: Colors.purple))),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      SvgPicture.asset(
                                        'assets/images/pajama.svg',
                                        height: 25,
                                        width: 25,
                                        color: Colors.amber,
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Expanded(
                                        child: Text(
                                          "pajama",
                                          style: TextStyle(
                                              fontSize: 25,
                                              color: Colors.amber),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 40,
                                      ),
                                      UpdateValueButton(
                                        icon: Icons.remove,
                                        perform: () {
                                          if (pajamaVal > 1) {
                                            pajamaVal--;
                                            pajamaList.removeLast();
                                            setState(() {});
                                          }
                                        },
                                      ),
                                      Text(
                                        coatVal.toString(),
                                        style: TextStyle(
                                            fontSize: 25, color: Colors.amber),
                                      ),
                                      UpdateValueButton(
                                        icon: Icons.add,
                                        perform: () {
                                          pajamaVal++;
                                          pajamaList.add('uncut');
                                          setState(() {});
                                          print(pajamaVal);
                                        },
                                      ),
                                      SizedBox(width: 30),
                                      GestureDetector(
                                        onTap: () {
                                          pajamaVal = 0;
                                          pajamaList.clear();
                                          setState(() {});
                                        },
                                        child: Icon(
                                          Icons.delete,
                                          color: Colors.red,
                                        ),
                                      ),
                                      SizedBox(width: 10),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  for (int i = 0; i < pajamaList.length; i++)
                                    Container(
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: Icon(Icons.arrow_right_alt),
                                          ),
                                          Container(
                                            width: 200,
                                            child: DropdownButton(
                                                isExpanded: true,
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    color: Colors.black),
                                                value: pajamaList[i],
                                                autofocus: true,
                                                focusColor: Colors.amber,
                                                items: <String>[
                                                  'uncut',
                                                  'cut',
                                                  'complete',
                                                ].map((String value) {
                                                  return new DropdownMenuItem<
                                                      String>(
                                                    value: value,
                                                    child: new Text(value),
                                                  );
                                                }).toList(),
                                                onChanged: (value) {
                                                  pajamaList[i] = value;
                                                  setState(() {});
                                                }),
                                          ),
                                        ],
                                      ),
                                    ),
                                ],
                              ),
                            )
                          : Container(
                              margin: EdgeInsets.only(top: 20),
                              padding: EdgeInsets.only(bottom: 10),
                              decoration: BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(
                                          width: 1, color: Colors.purple))),
                              child: Row(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      pajamaVal = 1;
                                      pajamaList = ['uncut'];
                                      change = false;
                                      setState(() {});
                                    },
                                    child: SvgPicture.asset(
                                      'assets/images/pajama.svg',
                                      height: 25,
                                      width: 25,
                                      color: Colors.black38,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    child: Text(
                                      "pajama",
                                      style: TextStyle(
                                          fontSize: 25, color: Colors.black38),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                      achkanVal > 0
                          ? Container(
                              margin: EdgeInsets.only(top: 20),
                              padding: EdgeInsets.only(bottom: 10),
                              decoration: BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(
                                          width: 1, color: Colors.purple))),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      SvgPicture.asset(
                                        'assets/images/achkan.svg',
                                        height: 25,
                                        width: 25,
                                        color: Colors.amber,
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Expanded(
                                        child: Text(
                                          "achkan",
                                          style: TextStyle(
                                              fontSize: 25,
                                              color: Colors.amber),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 40,
                                      ),
                                      UpdateValueButton(
                                        icon: Icons.remove,
                                        perform: () {
                                          if (achkanVal > 1) {
                                            achkanVal--;
                                            achkanList.removeLast();
                                            setState(() {});
                                          }
                                        },
                                      ),
                                      Text(
                                        coatVal.toString(),
                                        style: TextStyle(
                                            fontSize: 25, color: Colors.amber),
                                      ),
                                      UpdateValueButton(
                                        icon: Icons.add,
                                        perform: () {
                                          achkanVal++;
                                          achkanList.add('uncut');
                                          setState(() {});
                                        },
                                      ),
                                      SizedBox(width: 30),
                                      GestureDetector(
                                        onTap: () {
                                          achkanVal = 0;
                                          achkanList.clear();
                                          setState(() {});
                                        },
                                        child: Icon(
                                          Icons.delete,
                                          color: Colors.red,
                                        ),
                                      ),
                                      SizedBox(width: 10),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  for (int i = 0; i < achkanList.length; i++)
                                    Container(
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: Icon(Icons.arrow_right_alt),
                                          ),
                                          Container(
                                            width: 200,
                                            child: DropdownButton(
                                                isExpanded: true,
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    color: Colors.black),
                                                value: achkanList[i],
                                                autofocus: true,
                                                focusColor: Colors.amber,
                                                items: <String>[
                                                  'uncut',
                                                  'cut',
                                                  'complete',
                                                ].map((String value) {
                                                  return new DropdownMenuItem<
                                                      String>(
                                                    value: value,
                                                    child: new Text(value),
                                                  );
                                                }).toList(),
                                                onChanged: (value) {
                                                  achkanList[i] = value;
                                                  setState(() {});
                                                }),
                                          ),
                                        ],
                                      ),
                                    ),
                                ],
                              ),
                            )
                          : Container(
                              margin: EdgeInsets.only(top: 20),
                              padding: EdgeInsets.only(bottom: 10),
                              decoration: BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(
                                          width: 1, color: Colors.purple))),
                              child: Row(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      achkanVal = 1;
                                      achkanList = ['uncut'];
                                      setState(() {});
                                    },
                                    child: SvgPicture.asset(
                                      'assets/images/achkan.svg',
                                      height: 25,
                                      width: 25,
                                      color: Colors.black38,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    child: Text(
                                      "achkan",
                                      style: TextStyle(
                                          fontSize: 25, color: Colors.black38),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                      othersVal > 0
                          ? Container(
                              margin: EdgeInsets.only(top: 20),
                              padding: EdgeInsets.only(bottom: 10),
                              decoration: BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(
                                          width: 1, color: Colors.purple))),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      SvgPicture.asset(
                                        'assets/images/others.svg',
                                        height: 25,
                                        width: 25,
                                        color: Colors.amber,
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Expanded(
                                        child: Text(
                                          "others",
                                          style: TextStyle(
                                              fontSize: 25,
                                              color: Colors.amber),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 40,
                                      ),
                                      UpdateValueButton(
                                        icon: Icons.remove,
                                        perform: () {
                                          if (othersVal > 1) {
                                            othersVal--;
                                            othersList.removeLast();
                                            setState(() {});
                                          }
                                        },
                                      ),
                                      Text(
                                        othersVal.toString(),
                                        style: TextStyle(
                                            fontSize: 25, color: Colors.amber),
                                      ),
                                      UpdateValueButton(
                                        icon: Icons.add,
                                        perform: () {
                                          othersVal++;
                                          othersList.add('uncut');
                                          setState(() {});
                                        },
                                      ),
                                      SizedBox(width: 30),
                                      GestureDetector(
                                        onTap: () {
                                          othersVal = 0;
                                          othersList.clear();
                                          setState(() {});
                                        },
                                        child: Icon(
                                          Icons.delete,
                                          color: Colors.red,
                                        ),
                                      ),
                                      SizedBox(width: 10),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  for (int i = 0; i < othersList.length; i++)
                                    Container(
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: Icon(Icons.arrow_right_alt),
                                          ),
                                          Container(
                                            width: 200,
                                            child: DropdownButton(
                                                isExpanded: true,
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    color: Colors.black),
                                                value: othersList[i],
                                                autofocus: true,
                                                focusColor: Colors.amber,
                                                items: <String>[
                                                  'uncut',
                                                  'cut',
                                                  'complete',
                                                ].map((String value) {
                                                  return new DropdownMenuItem<
                                                      String>(
                                                    value: value,
                                                    child: new Text(value),
                                                  );
                                                }).toList(),
                                                onChanged: (value) {
                                                  othersList[i] = value;
                                                  setState(() {});
                                                }),
                                          ),
                                        ],
                                      ),
                                    ),
                                ],
                              ),
                            )
                          : Container(
                              margin: EdgeInsets.only(top: 20),
                              padding: EdgeInsets.only(bottom: 10),
                              decoration: BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(
                                          width: 1, color: Colors.purple))),
                              child: Row(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      othersVal = 1;
                                      othersList = ['uncut'];
                                      setState(() {});
                                    },
                                    child: SvgPicture.asset(
                                      'assets/images/others.svg',
                                      height: 25,
                                      width: 25,
                                      color: Colors.black38,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    child: Text(
                                      "others",
                                      style: TextStyle(
                                          fontSize: 25, color: Colors.black38),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Container(
            height: 35,
            color: Colors.black54,
            padding: EdgeInsets.only(left: 15, right: 15),
            child: Center(
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  if (coatVal > 0)
                    Container(
                      margin: EdgeInsets.only(right: 20),
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            'assets/images/coat.svg',
                            height: 25,
                            width: 25,
                            color: Colors.white,
                          ),
                          Text(
                            "$coatVal",
                            style: TextStyle(fontSize: 22, color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  if (pentVal > 0)
                    Container(
                      margin: EdgeInsets.only(right: 20),
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            'assets/images/pent.svg',
                            height: 25,
                            width: 25,
                            color: Colors.white,
                          ),
                          Text(
                            "$pentVal",
                            style: TextStyle(fontSize: 22, color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  if (shirtVal > 0)
                    Container(
                      margin: EdgeInsets.only(right: 20),
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            'assets/images/shirt.svg',
                            height: 25,
                            width: 25,
                            color: Colors.white,
                          ),
                          Text(
                            "$shirtVal",
                            style: TextStyle(fontSize: 22, color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  if (jacketVal > 0)
                    Container(
                      margin: EdgeInsets.only(right: 20),
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            'assets/images/jacket.svg',
                            height: 25,
                            width: 25,
                            color: Colors.white,
                          ),
                          Text(
                            "$jacketVal",
                            style: TextStyle(fontSize: 22, color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  if (kurtaVal > 0)
                    Container(
                      margin: EdgeInsets.only(right: 20),
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            'assets/images/kurta.svg',
                            height: 25,
                            width: 25,
                            color: Colors.white,
                          ),
                          Text(
                            "$kurtaVal",
                            style: TextStyle(fontSize: 22, color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  if (pajamaVal > 0)
                    Container(
                      margin: EdgeInsets.only(right: 20),
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            'assets/images/pajama.svg',
                            height: 25,
                            width: 25,
                            color: Colors.white,
                          ),
                          Text(
                            "$pajamaVal",
                            style: TextStyle(fontSize: 22, color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  if (achkanVal > 0)
                    Container(
                      margin: EdgeInsets.only(right: 20),
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            'assets/images/achkan.svg',
                            height: 25,
                            width: 25,
                            color: Colors.white,
                          ),
                          Text(
                            "$achkanVal",
                            style: TextStyle(fontSize: 22, color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  if (othersVal > 0)
                    Container(
                      margin: EdgeInsets.only(right: 20),
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            'assets/images/others.svg',
                            height: 25,
                            width: 25,
                            color: Colors.white,
                          ),
                          Text(
                            "$othersVal",
                            style: TextStyle(fontSize: 22, color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/*

TextFormField(
                          validator: (val) {
                            if (val.trim().isEmpty)
                              return AppLocalizations.of(context)
                                  .translate("must_not_empty");
                            else if (val.trim().length > 6)
                              return AppLocalizations.of(context)
                                  .translate("wrong_entry");
                            else
                              return null;
                          },
                          onChanged: (val) => () {},
                          initialValue: initialDetail['regNo'].toString(),
                          decoration: InputDecoration(
                            contentPadding:
                                EdgeInsets.only(left: 10, right: 10),
                            labelStyle: TextStyle(fontSize: 15.0),
                            hintText: AppLocalizations.of(context)
                                .translate("reg_no_full"),
                          ),
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          keyboardType: TextInputType.number,
                          style: TextStyle(fontSize: 25),
                        ),

*/
