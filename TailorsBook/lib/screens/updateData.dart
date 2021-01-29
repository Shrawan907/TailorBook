import 'dart:async';
import 'package:TailorsBook/common/buttons.dart';
import 'package:TailorsBook/locale/app_localization.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:TailorsBook/handle_cloud/data_file.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:toast/toast.dart';

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
  bool delivered = false;
  bool initialDelivered = false;
  int coatVal = 0,
      pentVal = 0,
      shirtVal = 0,
      jacketVal = 0,
      kurtaVal = 0,
      pajamaVal = 0,
      achkanVal = 0,
      othersVal = 0,
      blazerVal = 0,
      jodJacketVal = 0,
      safariVal = 0;

  List coatList = [],
      pentList = [],
      shirtList = [],
      jacketList = [],
      kurtaList = [],
      pajamaList = [],
      achkanList = [],
      blazerList = [],
      jodJacketList = [],
      safariList = [],
      othersList = [];

  final _controller = TextEditingController();
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
    if (initialDetail.containsKey("delivered")) {
      delivered = initialDetail['delivered'];
      initialDelivered = delivered;
    } else {
      delivered = false;
      initialDelivered = delivered;
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
    if (initialDetail.containsKey('jodJacket')) {
      jodJacketVal = initialDetail['jodJacket']['count'];
      jodJacketList = [...(initialDetail['jodJacket']['status'])];
    } else {
      jodJacketVal = 0;
      jodJacketList.clear();
    }
    if (initialDetail.containsKey('blazer')) {
      blazerVal = initialDetail['blazer']['count'];
      blazerList = [...(initialDetail['blazer']['status'])];
    } else {
      blazerVal = 0;
      blazerList.clear();
    }
    if (initialDetail.containsKey('safari')) {
      safariVal = initialDetail['safari']['count'];
      safariList = [...(initialDetail['safari']['status'])];
    } else {
      safariVal = 0;
      safariList.clear();
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
    _controller.text = regNo.toString();
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
                    Text(AppLocalizations.of(context)
                        .translate("notice_change_reg")),
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
                                controller: _controller,
                                onChanged: (value) {
                                  tempRegNo = int.parse(value);
                                },
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
                                child: Text(AppLocalizations.of(context)
                                    .translate("back")),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.all(10),
                            child: RaisedButton(
                              onPressed: () {
                                if (_controller.text.isNotEmpty) {
                                  print(tempRegNo);
                                  if (regNo != tempRegNo ||
                                      branch != tempbranch) {
                                    change = true;
                                  }
                                  regNo = tempRegNo;
                                  branch = tempbranch;
                                }
                                Navigator.pop(context);
                              },
                              child: Center(
                                child: Text(AppLocalizations.of(context)
                                    .translate("save")),
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
      bool isComplete = true;
      if (delivered == false)
        for (String value in statusList) {
          if (value == 'uncut' ||
              value == 'cut' ||
              (value != 'complete' && value.startsWith('#') == false)) {
            isComplete = false;
            break;
          }
        }
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
                          "isComplete": isComplete,
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
                      "isComplete": isComplete,
                      "return": returnDate,
                      "status": statusList,
                    }),
                  }
              }
          });
    }
  }

  int checkCompleteCount(int itemVal, itemList) {
    int count = 0;
    if (itemVal > 0) {
      for (var value in itemList)
        if (value != "uncut" && value != "cut") count++;
    }
    return count;
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
            othersVal == 0 &&
            jodJacketVal == 0 &&
            blazerVal == 0 &&
            safariVal == 0)) {
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
    var jodJacketPath = products.collection("jodJacket");
    var blazerPath = products.collection("blazer");
    var safariPath = products.collection("safari");
    var otherPath = products.collection("others");
    int check = 0; //to check duplicity of register number
    int completeCount = 0;
    completeCount += checkCompleteCount(coatVal, coatList);
    completeCount += checkCompleteCount(pentVal, pentList);
    completeCount += checkCompleteCount(shirtVal, shirtList);
    completeCount += checkCompleteCount(jacketVal, jacketList);
    completeCount += checkCompleteCount(kurtaVal, kurtaList);
    completeCount += checkCompleteCount(pajamaVal, pajamaList);
    completeCount += checkCompleteCount(achkanVal, achkanList);
    completeCount += checkCompleteCount(jodJacketVal, jodJacketList);
    completeCount += checkCompleteCount(blazerVal, blazerList);
    completeCount += checkCompleteCount(safariVal, safariList);
    completeCount += checkCompleteCount(othersVal, othersList);
    Map temp;
    await regPath.doc("$regNo").get().then((snapShot) => {
          if (snapShot.exists)
            {
              temp = snapShot.data(),
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
                    if (jodJacketVal > 0) "jodJacket": jodJacketVal,
                    if (blazerVal > 0) "blazer": blazerVal,
                    if (safariVal > 0) "safari": safariVal,
                    if (othersVal > 0) "others": othersVal,
                    if (coatVal <= 0 && temp.containsKey('coat'))
                      "coat": FieldValue.delete(),
                    if (pentVal <= 0 && temp.containsKey('pent'))
                      "pent": FieldValue.delete(),
                    if (shirtVal <= 0 && temp.containsKey('shirt'))
                      "shirt": FieldValue.delete(),
                    if (jacketVal <= 0 && temp.containsKey('jacket'))
                      "jacket": FieldValue.delete(),
                    if (kurtaVal <= 0 && temp.containsKey('kurta'))
                      "kurta": FieldValue.delete(),
                    if (pajamaVal <= 0 && temp.containsKey('pajama'))
                      "pajama": FieldValue.delete(),
                    if (achkanVal <= 0 && temp.containsKey('achkan'))
                      "achkan": FieldValue.delete(),
                    if (jodJacketVal <= 0 && temp.containsKey('jodJacket'))
                      "others": FieldValue.delete(),
                    if (blazerVal <= 0 && temp.containsKey('blazer'))
                      "others": FieldValue.delete(),
                    if (safariVal <= 0 && temp.containsKey('safari'))
                      "others": FieldValue.delete(),
                    if (othersVal <= 0 && temp.containsKey('others'))
                      "others": FieldValue.delete(),
                    "notCompleteItemCount": coatVal +
                        pentVal +
                        shirtVal +
                        jacketVal +
                        kurtaVal +
                        pajamaVal +
                        achkanVal +
                        jodJacketVal +
                        blazerVal +
                        safariVal +
                        othersVal -
                        completeCount,
                    "isComplete": delivered ||
                        (coatVal +
                                pentVal +
                                shirtVal +
                                jacketVal +
                                kurtaVal +
                                pajamaVal +
                                achkanVal +
                                jodJacketVal +
                                blazerVal +
                                safariVal +
                                othersVal -
                                completeCount) ==
                            0,
                    "delivered": delivered
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
                if (jodJacketVal > 0) "jodJacket": jodJacketVal,
                if (blazerVal > 0) "blazer": blazerVal,
                if (safariVal > 0) "safari": safariVal,
                if (othersVal > 0) "others": othersVal,
                "notCompleteItemCount": coatVal +
                    pentVal +
                    shirtVal +
                    jacketVal +
                    kurtaVal +
                    pajamaVal +
                    achkanVal +
                    jodJacketVal +
                    blazerVal +
                    safariVal +
                    othersVal -
                    completeCount,
                "isComplete": delivered ||
                    (coatVal +
                            pentVal +
                            shirtVal +
                            jacketVal +
                            kurtaVal +
                            pajamaVal +
                            achkanVal +
                            jodJacketVal +
                            blazerVal +
                            safariVal +
                            othersVal -
                            completeCount) ==
                        0,
                "delivered": delivered
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
              addProduct(newRegNo, jodJacketPath, jodJacketVal, jodJacketList),
              addProduct(newRegNo, blazerPath, blazerVal, blazerList),
              addProduct(newRegNo, safariPath, safariVal, safariList),
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
          if (initialRegNo == regNo)
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
                            Text(AppLocalizations.of(context)
                                .translate("notice_delete_warn")),
                            Text(
                              (branch == 0 ? "A" : "B") + ' $regNo ',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 20),
                            Text(AppLocalizations.of(context)
                                .translate("notice_delete")),
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
                                      child: Text(AppLocalizations.of(context)
                                          .translate("back")),
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
                                      child: Text(AppLocalizations.of(context)
                                          .translate("delete")),
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
                  Navigator.pop(context);
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
                                    fontWeight: FontWeight.bold,
                                    color: branch == 0
                                        ? Colors.deepPurple
                                        : Colors.red[800],
                                  ),
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
                              child: Text(
                                  AppLocalizations.of(context)
                                          .translate("return_date") +
                                      ":",
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
                            Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: Checkbox(
                                value: delivered,
                                activeColor: branch == 0
                                    ? Colors.deepPurple
                                    : Colors.red[800],
                                onChanged: (bool value) {
                                  change = true;
                                  setState(() {
                                    if (this.delivered == false) {
                                      this.delivered = true;
                                    } else {
                                      this.delivered = false;
                                    }
                                  });
                                },
                              ),
                            ),
                            Expanded(
                              child: Container(
                                padding: EdgeInsets.all(10),
                                child: Text(
                                    AppLocalizations.of(context).translate(
                                        delivered
                                            ? "delivered"
                                            : "notDelivered"),
                                    style: TextStyle(fontSize: 18)),
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
                                          AppLocalizations.of(context)
                                              .translate("coat"),
                                          style: TextStyle(
                                              fontSize: 23,
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
                                          buildMark(coatList[i]),
                                          Container(
                                            width: 200,
                                            child: DropdownButton(
                                                isExpanded: true,
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    color: Colors.black),
                                                value:
                                                    dropDownValue(coatList[i]),
                                                autofocus: true,
                                                focusColor: Colors.amber,
                                                items: <String>[
                                                  'uncut',
                                                  'cut',
                                                  'assigned',
                                                  'complete',
                                                ].map((String value) {
                                                  return new DropdownMenuItem<
                                                      String>(
                                                    value: value,
                                                    child: new Text(
                                                        AppLocalizations.of(
                                                                context)
                                                            .translate(value)),
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
                                      AppLocalizations.of(context)
                                          .translate("coat"),
                                      style: TextStyle(
                                          fontSize: 23, color: Colors.black38),
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
                                          AppLocalizations.of(context)
                                              .translate("pent"),
                                          style: TextStyle(
                                              fontSize: 23,
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
                                          buildMark(pentList[i]),
                                          Container(
                                            width: 200,
                                            child: DropdownButton(
                                                isExpanded: true,
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    color: Colors.black),
                                                value:
                                                    dropDownValue(pentList[i]),
                                                autofocus: true,
                                                focusColor: Colors.amber,
                                                items: <String>[
                                                  'uncut',
                                                  'cut',
                                                  'assigned',
                                                  'complete',
                                                ].map((String value) {
                                                  return new DropdownMenuItem<
                                                      String>(
                                                    value: value,
                                                    child: new Text(
                                                        AppLocalizations.of(
                                                                context)
                                                            .translate(value)),
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
                                      AppLocalizations.of(context)
                                          .translate("pent"),
                                      style: TextStyle(
                                          fontSize: 23, color: Colors.black38),
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
                                          AppLocalizations.of(context)
                                              .translate("shirt"),
                                          style: TextStyle(
                                              fontSize: 23,
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
                                          buildMark(shirtList[i]),
                                          Container(
                                            width: 200,
                                            child: DropdownButton(
                                                isExpanded: true,
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    color: Colors.black),
                                                value:
                                                    dropDownValue(shirtList[i]),
                                                autofocus: true,
                                                focusColor: Colors.amber,
                                                items: <String>[
                                                  'uncut',
                                                  'cut',
                                                  'assigned',
                                                  'complete',
                                                ].map((String value) {
                                                  return new DropdownMenuItem<
                                                      String>(
                                                    value: value,
                                                    child: new Text(
                                                        AppLocalizations.of(
                                                                context)
                                                            .translate(value)),
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
                                      AppLocalizations.of(context)
                                          .translate("shirt"),
                                      style: TextStyle(
                                          fontSize: 23, color: Colors.black38),
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
                                          AppLocalizations.of(context)
                                              .translate("jacket"),
                                          style: TextStyle(
                                              fontSize: 23,
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
                                          buildMark(jacketList[i]),
                                          Container(
                                            width: 200,
                                            child: DropdownButton(
                                                isExpanded: true,
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    color: Colors.black),
                                                value: dropDownValue(
                                                    jacketList[i]),
                                                autofocus: true,
                                                focusColor: Colors.amber,
                                                items: <String>[
                                                  'uncut',
                                                  'cut',
                                                  'assigned',
                                                  'complete',
                                                ].map((String value) {
                                                  return new DropdownMenuItem<
                                                      String>(
                                                    value: value,
                                                    child: new Text(
                                                        AppLocalizations.of(
                                                                context)
                                                            .translate(value)),
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
                                      AppLocalizations.of(context)
                                          .translate("jacket"),
                                      style: TextStyle(
                                          fontSize: 23, color: Colors.black38),
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
                                          AppLocalizations.of(context)
                                              .translate("kurta"),
                                          style: TextStyle(
                                              fontSize: 23,
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
                                          buildMark(kurtaList[i]),
                                          Container(
                                            width: 200,
                                            child: DropdownButton(
                                                isExpanded: true,
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    color: Colors.black),
                                                value:
                                                    dropDownValue(kurtaList[i]),
                                                autofocus: true,
                                                focusColor: Colors.amber,
                                                items: <String>[
                                                  'uncut',
                                                  'cut',
                                                  'assigned',
                                                  'complete',
                                                ].map((String value) {
                                                  return new DropdownMenuItem<
                                                      String>(
                                                    value: value,
                                                    child: new Text(
                                                        AppLocalizations.of(
                                                                context)
                                                            .translate(value)),
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
                                      AppLocalizations.of(context)
                                          .translate("kurta"),
                                      style: TextStyle(
                                          fontSize: 23, color: Colors.black38),
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
                                          AppLocalizations.of(context)
                                              .translate("pajama"),
                                          style: TextStyle(
                                              fontSize: 23,
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
                                          buildMark(pajamaList[i]),
                                          Container(
                                            width: 200,
                                            child: DropdownButton(
                                                isExpanded: true,
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    color: Colors.black),
                                                value: dropDownValue(
                                                    pajamaList[i]),
                                                autofocus: true,
                                                focusColor: Colors.amber,
                                                items: <String>[
                                                  'uncut',
                                                  'cut',
                                                  'assigned',
                                                  'complete',
                                                ].map((String value) {
                                                  return new DropdownMenuItem<
                                                      String>(
                                                    value: value,
                                                    child: new Text(
                                                        AppLocalizations.of(
                                                                context)
                                                            .translate(value)),
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
                                      AppLocalizations.of(context)
                                          .translate("pajama"),
                                      style: TextStyle(
                                          fontSize: 23, color: Colors.black38),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                      jodJacketVal > 0
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
                                      buildSvgPicture(
                                          'jodJacket', Colors.amber),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Expanded(
                                        child: Text(
                                          AppLocalizations.of(context)
                                              .translate("jodJacket"),
                                          style: TextStyle(
                                              fontSize: 23,
                                              color: Colors.amber),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 40,
                                      ),
                                      UpdateValueButton(
                                        icon: Icons.remove,
                                        perform: () {
                                          if (jodJacketVal > 1) {
                                            change = true;
                                            jodJacketVal--;
                                            jodJacketList.removeLast();
                                            setState(() {});
                                          }
                                        },
                                      ),
                                      Text(
                                        jodJacketVal.toString(),
                                        style: TextStyle(
                                            fontSize: 25, color: Colors.amber),
                                      ),
                                      UpdateValueButton(
                                        icon: Icons.add,
                                        perform: () {
                                          change = true;
                                          jodJacketVal++;
                                          jodJacketList.add('uncut');
                                          setState(() {});
                                        },
                                      ),
                                      SizedBox(width: 30),
                                      GestureDetector(
                                        onTap: () {
                                          change = true;
                                          jodJacketVal = 0;
                                          jodJacketList.clear();
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
                                  for (int i = 0; i < jodJacketList.length; i++)
                                    Container(
                                      child: Row(
                                        children: [
                                          buildMark(jodJacketList[i]),
                                          Container(
                                            width: 200,
                                            child: DropdownButton(
                                                isExpanded: true,
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    color: Colors.black),
                                                value: dropDownValue(
                                                    jodJacketList[i]),
                                                autofocus: true,
                                                focusColor: Colors.amber,
                                                items: <String>[
                                                  'uncut',
                                                  'cut',
                                                  'assigned',
                                                  'complete',
                                                ].map((String value) {
                                                  return new DropdownMenuItem<
                                                      String>(
                                                    value: value,
                                                    child: new Text(
                                                        AppLocalizations.of(
                                                                context)
                                                            .translate(value)),
                                                  );
                                                }).toList(),
                                                onChanged: (value) {
                                                  if (jodJacketList[i] != value)
                                                    change = true;
                                                  jodJacketList[i] = value;
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
                                      jodJacketVal = 1;
                                      jodJacketList = ['uncut'];
                                      setState(() {});
                                    },
                                    child: buildSvgPicture(
                                        'jodJacket', Colors.black38),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    child: Text(
                                      AppLocalizations.of(context)
                                          .translate("jodJacket"),
                                      style: TextStyle(
                                          fontSize: 23, color: Colors.black38),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                      blazerVal > 0
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
                                      buildSvgPicture('blazer', Colors.amber),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Expanded(
                                        child: Text(
                                          AppLocalizations.of(context)
                                              .translate("blazer"),
                                          style: TextStyle(
                                              fontSize: 23,
                                              color: Colors.amber),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 40,
                                      ),
                                      UpdateValueButton(
                                        icon: Icons.remove,
                                        perform: () {
                                          if (blazerVal > 1) {
                                            change = true;
                                            blazerVal--;
                                            blazerList.removeLast();
                                            setState(() {});
                                          }
                                        },
                                      ),
                                      Text(
                                        blazerVal.toString(),
                                        style: TextStyle(
                                            fontSize: 25, color: Colors.amber),
                                      ),
                                      UpdateValueButton(
                                        icon: Icons.add,
                                        perform: () {
                                          change = true;
                                          blazerVal++;
                                          blazerList.add('uncut');
                                          setState(() {});
                                        },
                                      ),
                                      SizedBox(width: 30),
                                      GestureDetector(
                                        onTap: () {
                                          change = true;
                                          blazerVal = 0;
                                          blazerList.clear();
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
                                  for (int i = 0; i < blazerList.length; i++)
                                    Container(
                                      child: Row(
                                        children: [
                                          buildMark(blazerList[i]),
                                          Container(
                                            width: 200,
                                            child: DropdownButton(
                                                isExpanded: true,
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    color: Colors.black),
                                                value: dropDownValue(
                                                    blazerList[i]),
                                                autofocus: true,
                                                focusColor: Colors.amber,
                                                items: <String>[
                                                  'uncut',
                                                  'cut',
                                                  'assigned',
                                                  'complete',
                                                ].map((String value) {
                                                  return new DropdownMenuItem<
                                                      String>(
                                                    value: value,
                                                    child: new Text(
                                                        AppLocalizations.of(
                                                                context)
                                                            .translate(value)),
                                                  );
                                                }).toList(),
                                                onChanged: (value) {
                                                  if (blazerList[i] != value)
                                                    change = true;
                                                  blazerList[i] = value;
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
                                      blazerVal = 1;
                                      blazerList = ['uncut'];
                                      setState(() {});
                                    },
                                    child: buildSvgPicture(
                                        'blazer', Colors.black38),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    child: Text(
                                      AppLocalizations.of(context)
                                          .translate("blazer"),
                                      style: TextStyle(
                                          fontSize: 23, color: Colors.black38),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                      safariVal > 0
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
                                      buildSvgPicture('safari', Colors.amber),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Expanded(
                                        child: Text(
                                          AppLocalizations.of(context)
                                              .translate("safari"),
                                          style: TextStyle(
                                              fontSize: 23,
                                              color: Colors.amber),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 40,
                                      ),
                                      UpdateValueButton(
                                        icon: Icons.remove,
                                        perform: () {
                                          if (safariVal > 1) {
                                            change = true;
                                            safariVal--;
                                            safariList.removeLast();
                                            setState(() {});
                                          }
                                        },
                                      ),
                                      Text(
                                        safariVal.toString(),
                                        style: TextStyle(
                                            fontSize: 25, color: Colors.amber),
                                      ),
                                      UpdateValueButton(
                                        icon: Icons.add,
                                        perform: () {
                                          change = true;
                                          safariVal++;
                                          safariList.add('uncut');
                                          setState(() {});
                                        },
                                      ),
                                      SizedBox(width: 30),
                                      GestureDetector(
                                        onTap: () {
                                          change = true;
                                          safariVal = 0;
                                          safariList.clear();
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
                                  for (int i = 0; i < safariList.length; i++)
                                    Container(
                                      child: Row(
                                        children: [
                                          buildMark(safariList[i]),
                                          Container(
                                            width: 200,
                                            child: DropdownButton(
                                                isExpanded: true,
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    color: Colors.black),
                                                value: dropDownValue(
                                                    safariList[i]),
                                                autofocus: true,
                                                focusColor: Colors.amber,
                                                items: <String>[
                                                  'uncut',
                                                  'cut',
                                                  'assigned',
                                                  'complete',
                                                ].map((String value) {
                                                  return new DropdownMenuItem<
                                                      String>(
                                                    value: value,
                                                    child: new Text(
                                                        AppLocalizations.of(
                                                                context)
                                                            .translate(value)),
                                                  );
                                                }).toList(),
                                                onChanged: (value) {
                                                  if (safariList[i] != value)
                                                    change = true;
                                                  safariList[i] = value;
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
                                      safariVal = 1;
                                      safariList = ['uncut'];
                                      setState(() {});
                                    },
                                    child: buildSvgPicture(
                                        'safari', Colors.black38),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    child: Text(
                                      AppLocalizations.of(context)
                                          .translate("safari"),
                                      style: TextStyle(
                                          fontSize: 23, color: Colors.black38),
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
                                          AppLocalizations.of(context)
                                              .translate("achkan"),
                                          style: TextStyle(
                                              fontSize: 23,
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
                                          buildMark(achkanList[i]),
                                          Container(
                                            width: 200,
                                            child: DropdownButton(
                                                isExpanded: true,
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    color: Colors.black),
                                                value: dropDownValue(
                                                    achkanList[i]),
                                                autofocus: true,
                                                focusColor: Colors.amber,
                                                items: <String>[
                                                  'uncut',
                                                  'cut',
                                                  'assigned',
                                                  'complete',
                                                ].map((String value) {
                                                  return new DropdownMenuItem<
                                                      String>(
                                                    value: value,
                                                    child: new Text(
                                                        AppLocalizations.of(
                                                                context)
                                                            .translate(value)),
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
                                      AppLocalizations.of(context)
                                          .translate("achkan"),
                                      style: TextStyle(
                                          fontSize: 23, color: Colors.black38),
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
                                          AppLocalizations.of(context)
                                              .translate("others"),
                                          style: TextStyle(
                                              fontSize: 23,
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
                                          buildMark(othersList[i]),
                                          Container(
                                            width: 200,
                                            child: DropdownButton(
                                                isExpanded: true,
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    color: Colors.black),
                                                value: dropDownValue(
                                                    othersList[i]),
                                                autofocus: true,
                                                focusColor: Colors.amber,
                                                items: <String>[
                                                  'uncut',
                                                  'cut',
                                                  'assigned',
                                                  'complete',
                                                ].map((String value) {
                                                  return new DropdownMenuItem<
                                                      String>(
                                                    value: value,
                                                    child: new Text(
                                                        AppLocalizations.of(
                                                                context)
                                                            .translate(value)),
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
                                      AppLocalizations.of(context)
                                          .translate("others"),
                                      style: TextStyle(
                                          fontSize: 23, color: Colors.black38),
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
                  if (jodJacketVal > 0)
                    buildBottomItemBar('jodJacket', jodJacketVal),
                  if (blazerVal > 0) buildBottomItemBar('blazer', blazerVal),
                  if (safariVal > 0) buildBottomItemBar('safari', safariVal),
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

  String dropDownValue(String value) {
    if (value == 'cut' ||
        value == 'uncut' ||
        value == 'complete' ||
        value == 'assigned')
      return value;
    else if (value.startsWith('#'))
      return 'complete';
    else
      return 'assigned';
  }

  Widget buildMark(String value) {
    if (value != 'cut' &&
        value != 'uncut' &&
        value != 'complete' &&
        value != 'assigned')
      return Expanded(
        child: Container(
          child: Center(
            child: Text(
              value,
              style: TextStyle(color: Colors.blue),
            ),
          ),
        ),
      );
    return Expanded(
      child: Icon(Icons.arrow_right_alt),
    );
  }
}
