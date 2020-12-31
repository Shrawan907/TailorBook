import 'dart:async';
import 'dart:collection';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:TailorsBook/handle_cloud/login.dart';
import 'package:easy_localization/easy_localization.dart';

FirebaseFirestore db = FirebaseFirestore.instance;
DateTime timestamp = DateTime.now();

Map info = {};
List todayData = [];
List tommData = [];
List overmData = [];
List tempData = [];
List registerAdata = [];
List registerBdata = [];
List requestData = [];
int requestCount = -1;

Future<List> fetchTodayData(DateTime date) async {
  tempData.clear();
  tempData = [[], []];
  db
      .collection("company/branchA/register")
      .snapshots()
      .listen((QuerySnapshot querySnapshot) {
    querySnapshot.docs.forEach((element) {
      Map temp = element.data();
      DateTime dt = temp["return_date"].toDate();
      if (date.day == dt.day &&
          date.month == dt.month &&
          date.year == dt.year) {
        print(temp);
        tempData[0].addAll([
          {
            'reg_no': temp['reg_no'],
            'is_complete': temp['is_complete'],
            'coat': temp['coat']
          }
        ]);
      }
    });
  });
  db
      .collection("company/branchB/register")
      .snapshots()
      .listen((QuerySnapshot querySnapshot) {
    querySnapshot.docs.forEach((element) {
      Map temp = element.data();
      DateTime dt = temp["return_date"].toDate();
      if (date.day == dt.day &&
          date.month == dt.month &&
          date.year == dt.year) {
        tempData[1].addAll([
          {
            'reg_no': temp['reg_no'],
            'is_complete': temp['is_complete'],
            'coat': temp['coat']
          }
        ]);
      }
    });
  });
  await Future.delayed(Duration(seconds: 2));
  return tempData;
}

void clearTomData() {
  tommData.clear();
}

void clearOverData() {
  overmData.clear();
}

void clearTodayData() {
  todayData.clear();
}

Future<List> todaydata() async {
  if (todayData.isEmpty || todayData == null) {
    todayData.clear();
    print("empty");
    todayData = [...(await fetchTodayData(timestamp))];
    return todayData;
  }
  return todayData;
}

Future<List> tommdata() async {
  if (tommData.isEmpty || tommData == null) {
    tommData.clear();
    print("empty");
    tommData = [...(await fetchTodayData(timestamp.add(Duration(days: 1))))];
    return tommData;
  }
  print(tommData);
  print(tommData.isEmpty);
  print(tommData.length);
  return tommData;
}

Future<List> overmdata() async {
  if (overmData.isEmpty || overmData == null) {
    overmData.clear();
    print("empty");
    overmData = [...(await fetchTodayData(timestamp.add(Duration(days: 2))))];
    return overmData;
  }
  return overmData;
}

Future<List> fetchRegisterData(int branch) async {
  tempData.clear();
  tempData = [];
  String path =
      "company/" + (branch == 0 ? "branchA" : "branchB") + "/register";
  Map temp;
  db.collection(path).snapshots().listen((QuerySnapshot querySnapshot) {
    querySnapshot.docs.forEach((element) {
      temp = element.data();
      print(temp);
      tempData.addAll([temp]);
    });
  });
  await Future.delayed(Duration(seconds: 2));
  return tempData;
}

Future<List> getRegister(int branch) async {
  if (branch == 0) {
    if (registerAdata.isEmpty || registerAdata == null) {
      print("Empty register");
      registerAdata = [...(await fetchRegisterData(branch))];
      return registerAdata;
    }
    return registerAdata;
  } else {
    if (registerBdata.isEmpty || registerBdata == null) {
      print("Empty register");
      registerBdata = [...(await fetchRegisterData(branch))];
      return registerBdata;
    }
    return registerBdata;
  }
}

see(String path, var temp, String key, int regNo) {
  if (temp.containsKey("$key")) {
    db
        .collection(path + "/products/products/$key")
        .where("reg_no", isEqualTo: regNo)
        .snapshots()
        .listen((QuerySnapshot querySnapshot) {
      var tmp = querySnapshot.docs.first.data();
      //print(temp);
      info["$key"] = {
        "count": tmp["count"],
        "is_complete": tmp["is_complete"],
        "status": tmp["status"]
      };
    });
  }
}

Future<Map> fetchDetail(int regNo, int branch) async {
  String path = "company/" + (branch == 0 ? "branchA" : "branchB");
  info = {};
  db
      .collection(path + "/register")
      .where("reg_no", isEqualTo: regNo)
      .snapshots()
      .listen((QuerySnapshot querySnapshot) {
    var temp = querySnapshot.docs.first.data();
    //print(temp);
    info["reg_no"] = temp["reg_no"];
    info["is_complete"] = temp["is_complete"];
    DateTime date = temp["return_date"].toDate();
    info["return_date"] = "${date.day}-${date.month}-${date.year}";
    see(path, temp, "coat", regNo);
    see(path, temp, "pent", regNo);
    see(path, temp, "shirt", regNo);
    see(path, temp, "jacket", regNo);
    see(path, temp, "kurta", regNo);
    see(path, temp, "pajama", regNo);
    see(path, temp, "achkan", regNo);
    see(path, temp, "others", regNo);
  });
  await Future.delayed(Duration(seconds: 2));
  if (info.isEmpty) {
    info["no_detail"] = true;
  }
  return info;
}

Future<List> fetchRequestData() async {
  tempData.clear();
  var requestPath = db.collection("company/requests/requests");
  db.collection("company").doc("requests").get().then((element) => {
        if (element.data().containsKey("total") && element.data()["total"] > 0)
          {
            requestCount = element.data()["total"],
            requestPath.snapshots().listen((QuerySnapshot querySnapshot) {
              querySnapshot.docs.forEach((element) {
                Map temp = element.data();
                tempData.addAll([
                  {
                    "phoneNo": temp["phoneNo"],
                    "username": temp["username"],
                    "requestProfile": temp["requestProfile"]
                  }
                ]);
              });
            }),
          }
      });
  await Future.delayed(Duration(seconds: 2));
  return tempData;
}

void clearRequestData() {
  requestData.clear();
  requestCount = -1;
}

Future<List> getRequestData() async {
  if (requestCount == -1) {
    requestData.clear();
    requestData = [...(await fetchRequestData())];
  }
  print(requestData);
  return requestData;
}

int getRequestCount() {
  return requestCount;
}

Future requestAccept(String phone) async {
  print(phone);
  var requestPath = db.collection("company/requests/requests");
  var userPath = db.collection("company/team/members");
  requestPath.doc(phone).get().then((snapShot) => {
        if (snapShot.exists)
          {
            requestPath.doc(phone).delete(),
            requestData.remove(requestData
                .where((element) => element["phoneNo"] == phone)
                .first),
            db.collection("company").doc("requests").update(
              {"total": FieldValue.increment(-1)},
            ),
          }
        else
          {print("snapShot doesn't exists!")}
      });
  userPath.doc(phone).get().then((snapShot) => {
        if (snapShot.exists)
          {
            userPath.doc(phone).update({
              "requestAccepted": true,
            })
          }
        else
          {
            print(
                "Check Needed, no user saved on cloud but request is deleted"),
          }
      });
  await Future.delayed(Duration(seconds: 1));
}

Future requestDecline(String phone) async {
  print(phone);
  var requestPath = db.collection("company/requests/requests");
  var userPath = db.collection("company/team/members");
  requestPath.doc("phone").get().then((snapShot) => {
        if (snapShot.exists)
          {
            requestPath.doc(phone).delete(),
            requestData.remove(requestData
                .where((element) => element["phoneNo"] == phone)
                .first),
            db.collection("company").doc("requests").update(
              {"total": FieldValue.increment(-1)},
            ),
          }
      });
  userPath.doc(phone).get().then((snapShot) => {
        if (snapShot.exists)
          {
            userPath.doc(phone).update({
              "name": "",
              "profile": "",
              "requestMade": false,
            })
          }
        else
          {
            print(
                "Check Needed, no user saved on cloud but request is deleted"),
          }
      });
  await Future.delayed(Duration(seconds: 1));
}
