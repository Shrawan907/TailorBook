import 'dart:async';
import 'package:TailorsBook/common/buttons.dart';
import 'package:TailorsBook/locale/app_localization.dart';
import 'package:TailorsBook/screens/signin.dart';
import 'package:TailorsBook/screens/updateData.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:TailorsBook/common/nav_drower.dart';
import 'package:TailorsBook/common/cardBox.dart';
import 'package:TailorsBook/handle_cloud/data_file.dart';
import 'package:TailorsBook/screens/register_new.dart';
import 'package:TailorsBook/screens/on_working.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:toast/toast.dart';

import '../locale/app_localization.dart';
import '../locale/app_localization.dart';
import '../locale/app_localization.dart';

DateTime bookingDate = DateTime.now();
DateTime returnDate = bookingDate;
FirebaseFirestore db = FirebaseFirestore.instance;

class UpdateData extends StatefulWidget {
  final Map initialDetail;
  UpdateData({this.initialDetail});
  @override
  _UpdateDataState createState() =>
      _UpdateDataState(initialDetail: this.initialDetail);
}

class _UpdateDataState extends State<UpdateData> {
  int branch = 0;
  int initialBranch = 0;
  Map initialDetail;
  String showDate = "Not Get Yet";
  bool change = false;
  int regNo = 0;
  int initialRegNo = 0;
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

  final _scaffoldKey = GlobalKey<ScaffoldState>();
  _UpdateDataState({this.initialDetail});
  @override
  void initState() {
    super.initState();
    initialData();
  }

  void initialData() {
    change = false;
    if (initialDetail.containsKey("branch")) {
      initialBranch = initialDetail["branch"];
      branch = initialBranch;
    }
    if (initialDetail.containsKey('regNo')) {
      initialRegNo = initialDetail['regNo'];
      regNo = initialRegNo;
    }
    if (initialDetail.containsKey("returnDate") &&
        initialDetail['returnDate'] != null) {
      returnDate = initialDetail['returnDate'];
      showDate = "${returnDate.day}-${returnDate.month}-${returnDate.year}";
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
    if (picked != null) {
      if (picked.day != returnDate.day ||
          picked.month != returnDate.month ||
          picked.year != returnDate.month) change = true;
      returnDate = picked;
      showDate = "${returnDate.day}-${returnDate.month}-${returnDate.year}";
      setState(() {});
    }
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
                    Text(AppLocalizations.of(context).translate("notice_change_reg")),
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
                                child: Text(AppLocalizations.of(context).translate("back")),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.all(10),
                            child: RaisedButton(
                              onPressed: () {
                                if (regNo != tempRegNo ||
                                    branch != tempbranch) {
                                  change = true;
                                }
                                regNo = tempRegNo;
                                branch = tempbranch;
                                Navigator.pop(context);
                              },
                              child: Center(
                                child: Text(AppLocalizations.of(context).translate("save")),
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

  addProduct(bool newRegNo, var path, int count, List statusList) {
    if ((newRegNo == true && count > 0) || (newRegNo == false)) {
      path.doc("$regNo").get().then((snapShot) => {
            if (snapShot.exists)
              {
                if (newRegNo == false)
                  {
                    if (count > 0)
                      {
                        path.doc("$regNo").update({
                          "regNo": regNo,
                          "count": count,
                          "isComplete": false,
                          "return": returnDate,
                          "status": statusList,
                        }),
                      }
                    else
                      {
                        path.doc('$regNo').delete(),
                      }
                  }
                else
                  {
                    print('This Register Number already Exists!'),
                  }
              }
            else
              {
                if (count > 0)
                  {
                    path.doc("$regNo").set({
                      "regNo": regNo,
                      "count": count,
                      "isComplete": false,
                      "return": returnDate,
                      "status": statusList,
                    }),
                  }
              }
          });
    }
  }

  Future onSave() async {
    bool newRegNo = false;
    if (regNo == null ||
        regNo <= 0 ||
        regNo > 100000 ||
        (coatVal == 0 &&
            pentVal == 0 &&
            shirtVal == 0 &&
            jacketVal == 0 &&
            kurtaVal == 0 &&
            pajamaVal == 0 &&
            achkanVal == 0 &&
            othersVal == 0)) {
      SnackBar snackBar = SnackBar(
        content: Text("Entry format is not correct!"),
      );
      _scaffoldKey.currentState.showSnackBar(snackBar);
      Timer(Duration(seconds: 1), () {});
      return;
    }

    if (initialRegNo != regNo || initialBranch != branch) {
      await deleteDataOf(initialRegNo, initialBranch);
      print('yes it new reg No.');
      newRegNo = true;
    }

    var regPath = db
        .collection("company")
        .doc(branch == 0 ? "branchA" : "branchB")
        .collection("register");
    var products = db
        .collection("company")
        .doc(branch == 0 ? "branchA" : "branchB")
        .collection("products")
        .doc("products");
    var coatPath = products.collection("coat");
    var pentPath = products.collection("pent");
    var shirtPath = products.collection("shirt");
    var achkanPath = products.collection("achkan");
    var jacketPath = products.collection("jacket");
    var kurtaPath = products.collection("kurta");
    var pajamaPath = products.collection("pajama");
    var otherPath = products.collection("others");
    int check = 0; //to check duplicity of register number
    await regPath.doc("$regNo").get().then((snapShot) => {
          if (snapShot.exists)
            {
              if (newRegNo == true)
                {
                  check++,
                  print("doc already exists"),
                }
              else
                {
                  regPath.doc("$regNo").update({
                    "regNo": regNo,
                    "returnDate": returnDate,
                    if (coatVal > 0) "coat": coatVal,
                    if (pentVal > 0) "pent": pentVal,
                    if (shirtVal > 0) "shirt": shirtVal,
                    if (jacketVal > 0) "jacket": jacketVal,
                    if (kurtaVal > 0) "kurta": kurtaVal,
                    if (pajamaVal > 0) "pajama": pajamaVal,
                    if (achkanVal > 0) "achkan": achkanVal,
                    if (othersVal > 0) "others": othersVal,
                    "isComplete": false
                  }),
                }
            }
          else
            {
              regPath.doc("$regNo").set({
                "regNo": regNo,
                "bookingDate": bookingDate,
                "returnDate": returnDate,
                if (coatVal > 0) "coat": coatVal,
                if (pentVal > 0) "pent": pentVal,
                if (shirtVal > 0) "shirt": shirtVal,
                if (jacketVal > 0) "jacket": jacketVal,
                if (kurtaVal > 0) "kurta": kurtaVal,
                if (pajamaVal > 0) "pajama": pajamaVal,
                if (achkanVal > 0) "achkan": achkanVal,
                if (othersVal > 0) "others": othersVal,
                "isComplete": false
              })
            },
          if (snapShot.exists == false || newRegNo == false)
            {
              addProduct(newRegNo, coatPath, coatVal, coatList),
              addProduct(newRegNo, pentPath, pentVal, pentList),
              addProduct(newRegNo, shirtPath, shirtVal, shirtList),
              addProduct(newRegNo, jacketPath, jacketVal, jacketList),
              addProduct(newRegNo, kurtaPath, kurtaVal, kurtaList),
              addProduct(newRegNo, pajamaPath, pajamaVal, pajamaList),
              addProduct(newRegNo, achkanPath, achkanVal, achkanList),
              addProduct(newRegNo, otherPath, othersVal, othersList),
            },
          print("done")
        });
    if (check == 0) {
      SnackBar snackBar = SnackBar(
        content: Text(AppLocalizations.of(context).translate("save_detail_of") +
            " ${regNo.toString()}"),
      );
      _scaffoldKey.currentState.showSnackBar(snackBar);
      Timer(Duration(seconds: 1), () {
        Navigator.pop(context, regNo.toString());
      });
    } else {
      Toast.show(AppLocalizations.of(context).translate("regNo_exist"), context,
          duration: Toast.LENGTH_SHORT, gravity: Toast.CENTER);
    }
    await Future.delayed(Duration(seconds: 2));
  }

  @override
  Widget build(BuildContext parentContext) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context).translate("update"),
        ),
        actions: [
          GestureDetector(
            onTap: () async {
              bool deleted = false;
              await showDialog(
                  context: context,
                  child: AlertDialog(
                    content: Container(
                      height: 200,
                      width: 300,
                      child: ListView(
                        children: [
                          Text(AppLocalizations.of(context).translate("notice_delete_warn")),
                          Text(
                            (branch == 0 ? "A" : "B") + ' $regNo ',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 20),
                          Text(AppLocalizations.of(context).translate("notice_delete")),
                          SizedBox(height: 20),
                          Row(
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10, right: 10),
                                  child: RaisedButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text(AppLocalizations.of(context).translate("back")),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10, right: 10),
                                  child: RaisedButton(
                                    onPressed: () async {
                                      await deleteDataOf(regNo, branch);
                                      deleted = true;
                                      Navigator.pop(context);
                                    },
                                    child: Text(AppLocalizations.of(context).translate("delete")),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ));
              if (deleted == true) {
                Navigator.pop(context);           //$$$issue here$$$ When it is deleted it need to go back to Day Data page but it is not going over there
                                                  //$$$issue here2$$$ If we change reg no in edit for x to x+1 and on the same page just by changing value
                                                  // on the same page then it delete the data of x+1 reg no.
              }
            },
            child: Container(
                margin: EdgeInsets.only(right: 40),
                child: Icon(Icons.delete_forever)),
          ),
          GestureDetector(
            onTap: () {
              initialData();
              setState(() {});
            },
            child: Container(
                margin: EdgeInsets.only(right: 40), child: Icon(Icons.restore)),
          ),
          GestureDetector(
            onTap: () async {
              await onSave();
            },
            child: Container(
                margin: EdgeInsets.only(right: 20),
                child: Center(
                    child: Text(
                      AppLocalizations.of(context).translate("save"),
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
                              child: Text(AppLocalizations.of(context).translate("return_date") + ":",
                                  style: TextStyle(fontSize: 18)),
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
                                      buildSvgPicture('coat', Colors.amber),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Expanded(
                                        child: Text(
                                          AppLocalizations.of(context).translate("coat"),
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
                                            change = true;
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
                                          change = true;
                                          coatVal++;
                                          coatList.add('uncut');
                                          setState(() {});
                                          print(coatVal);
                                        },
                                      ),
                                      SizedBox(width: 30),
                                      GestureDetector(
                                        onTap: () {
                                          change = true;
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
                                                    child: new Text(AppLocalizations.of(context).translate(value)),
                                                  );
                                                }).toList(),
                                                onChanged: (value) {
                                                  if (coatList[i] != value) {
                                                    change = true;
                                                    coatList[i] = value;
                                                    setState(() {});
                                                  }
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
                                      change = true;
                                      coatVal = 1;
                                      coatList = ['uncut'];
                                      setState(() {});
                                    },
                                    child:
                                        buildSvgPicture('coat', Colors.black38),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    child: Text(
                                      AppLocalizations.of(context).translate("coat"),
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
                                      buildSvgPicture('pent', Colors.amber),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Expanded(
                                        child: Text(
                                          AppLocalizations.of(context).translate("pent"),
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
                                            change = true;
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
                                          change = true;
                                          pentVal++;
                                          pentList.add('uncut');
                                          setState(() {});
                                        },
                                      ),
                                      SizedBox(width: 30),
                                      GestureDetector(
                                        onTap: () {
                                          change = true;
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
                                                    child: new Text(AppLocalizations.of(context).translate(value)),
                                                  );
                                                }).toList(),
                                                onChanged: (value) {
                                                  if (pentList[i] != value) {
                                                    change = true;
                                                    pentList[i] = value;
                                                    setState(() {});
                                                  }
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
                                      change = true;
                                      pentVal = 1;
                                      pentList = ['uncut'];
                                      setState(() {});
                                    },
                                    child:
                                        buildSvgPicture('pent', Colors.black38),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    child: Text(
                                      AppLocalizations.of(context).translate("pent"),
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
                                      buildSvgPicture('shirt', Colors.amber),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Expanded(
                                        child: Text(
                                          AppLocalizations.of(context).translate("shirt"),
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
                                            change = true;
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
                                          change = true;
                                          shirtVal++;
                                          shirtList.add('uncut');
                                          setState(() {});
                                        },
                                      ),
                                      SizedBox(width: 30),
                                      GestureDetector(
                                        onTap: () {
                                          change = true;
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
                                                    child: new Text(AppLocalizations.of(context).translate(value)),
                                                  );
                                                }).toList(),
                                                onChanged: (value) {
                                                  if (shirtList[i] != value) {
                                                    change = true;
                                                    shirtList[i] = value;
                                                    setState(() {});
                                                  }
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
                                      change = true;
                                      shirtVal = 1;
                                      shirtList = ['uncut'];
                                      setState(() {});
                                    },
                                    child: buildSvgPicture(
                                        'shirt', Colors.black38),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    child: Text(
                                      AppLocalizations.of(context).translate("shirt"),
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
                                      buildSvgPicture('jacket', Colors.amber),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Expanded(
                                        child: Text(
                                          AppLocalizations.of(context).translate("jacket"),
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
                                            change = true;
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
                                          change = true;
                                          jacketVal++;
                                          jacketList.add('uncut');
                                          setState(() {});
                                        },
                                      ),
                                      SizedBox(width: 30),
                                      GestureDetector(
                                        onTap: () {
                                          change = true;
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
                                                    child: new Text(AppLocalizations.of(context).translate(value)),
                                                  );
                                                }).toList(),
                                                onChanged: (value) {
                                                  if (jacketList[i] != value) {
                                                    change = true;
                                                    jacketList[i] = value;
                                                    setState(() {});
                                                  }
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
                                      change = true;
                                      jacketVal = 1;
                                      jacketList = ['uncut'];
                                      setState(() {});
                                    },
                                    child: buildSvgPicture(
                                        'jacket', Colors.black38),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    child: Text(
                                      AppLocalizations.of(context).translate("jacket"),
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
                                      buildSvgPicture('kurta', Colors.amber),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Expanded(
                                        child: Text(
                                          AppLocalizations.of(context).translate("kurta"),
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
                                            change = true;
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
                                          change = true;
                                          kurtaVal++;
                                          kurtaList.add('uncut');
                                          setState(() {});
                                        },
                                      ),
                                      SizedBox(width: 30),
                                      GestureDetector(
                                        onTap: () {
                                          change = true;
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
                                                    child: new Text(AppLocalizations.of(context).translate(value)),
                                                  );
                                                }).toList(),
                                                onChanged: (value) {
                                                  if (kurtaList[i] != value) {
                                                    change = true;
                                                    kurtaList[i] = value;
                                                    setState(() {});
                                                  }
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
                                      change = true;
                                      kurtaVal = 1;
                                      kurtaList = ['uncut'];
                                      change = true;
                                      setState(() {});
                                    },
                                    child: buildSvgPicture(
                                        'kurta', Colors.black38),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    child: Text(
                                      AppLocalizations.of(context).translate("kurta"),
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
                                      buildSvgPicture('pajama', Colors.amber),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Expanded(
                                        child: Text(
                                          AppLocalizations.of(context).translate("pajama"),
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
                                            change = true;
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
                                          change = true;
                                          pajamaVal++;
                                          pajamaList.add('uncut');
                                          setState(() {});
                                          print(pajamaVal);
                                        },
                                      ),
                                      SizedBox(width: 30),
                                      GestureDetector(
                                        onTap: () {
                                          change = true;
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
                                                    child: new Text(AppLocalizations.of(context).translate(value)),
                                                  );
                                                }).toList(),
                                                onChanged: (value) {
                                                  if (pajamaList[i] != value) {
                                                    change = true;
                                                    pajamaList[i] = value;
                                                    setState(() {});
                                                  }
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
                                      change = true;
                                      pajamaVal = 1;
                                      pajamaList = ['uncut'];
                                      change = false;
                                      setState(() {});
                                    },
                                    child: buildSvgPicture(
                                        'pajama', Colors.black38),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    child: Text(
                                      AppLocalizations.of(context).translate("pajama"),
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
                                      buildSvgPicture('achkan', Colors.amber),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Expanded(
                                        child: Text(
                                          AppLocalizations.of(context).translate("achkan"),
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
                                            change = true;
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
                                          change = true;
                                          achkanVal++;
                                          achkanList.add('uncut');
                                          setState(() {});
                                        },
                                      ),
                                      SizedBox(width: 30),
                                      GestureDetector(
                                        onTap: () {
                                          change = true;
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
                                                    child: new Text(AppLocalizations.of(context).translate(value)),
                                                  );
                                                }).toList(),
                                                onChanged: (value) {
                                                  if (achkanList[i] != value) {
                                                    change = true;
                                                    achkanList[i] = value;
                                                    setState(() {});
                                                  }
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
                                      change = true;
                                      achkanVal = 1;
                                      achkanList = ['uncut'];
                                      setState(() {});
                                    },
                                    child: buildSvgPicture(
                                        'achkan', Colors.black38),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    child: Text(
                                      AppLocalizations.of(context).translate("achkan"),
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
                                      buildSvgPicture('others', Colors.amber),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Expanded(
                                        child: Text(
                                          AppLocalizations.of(context).translate("others"),
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
                                            change = true;
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
                                          change = true;
                                          othersVal++;
                                          othersList.add('uncut');
                                          setState(() {});
                                        },
                                      ),
                                      SizedBox(width: 30),
                                      GestureDetector(
                                        onTap: () {
                                          change = true;
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
                                                    child: new Text(AppLocalizations.of(context).translate(value)),
                                                  );
                                                }).toList(),
                                                onChanged: (value) {
                                                  if (othersList[i] != value)
                                                    change = true;
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
                                      change = true;
                                      othersVal = 1;
                                      othersList = ['uncut'];
                                      setState(() {});
                                    },
                                    child: buildSvgPicture(
                                        'others', Colors.black38),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    child: Text(
                                      AppLocalizations.of(context).translate("others"),
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
                  if (coatVal > 0) buildBottomItemBar('coat', coatVal),
                  if (pentVal > 0) buildBottomItemBar('pent', pentVal),
                  if (shirtVal > 0) buildBottomItemBar('shirt', shirtVal),
                  if (jacketVal > 0) buildBottomItemBar('jacket', jacketVal),
                  if (kurtaVal > 0) buildBottomItemBar('kurta', kurtaVal),
                  if (pajamaVal > 0) buildBottomItemBar('pajama', pajamaVal),
                  if (achkanVal > 0) buildBottomItemBar('achkan', achkanVal),
                  if (othersVal > 0) buildBottomItemBar('others', othersVal),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Container buildBottomItemBar(String item, int value) {
    return Container(
      margin: EdgeInsets.only(right: 20),
      child: Row(
        children: [
          buildSvgPicture(item, Colors.white),
          Text(
            "$value",
            style: TextStyle(fontSize: 22, color: Colors.white),
          ),
        ],
      ),
    );
  }

  SvgPicture buildSvgPicture(String item, Color color) {
    return SvgPicture.asset(
      'assets/images/$item.svg',
      height: 25,
      width: 25,
      color: color,
    );
  }
}
