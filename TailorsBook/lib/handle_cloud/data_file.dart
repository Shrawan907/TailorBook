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
List data = [[], []];
List registerAdata = [];
List registerBdata = [];

Future<List> fetchTodayData(DateTime date) async {
  data.clear();
  data = [[], []];
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
        data[0].addAll([
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
        data[1].addAll([
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
  return data;
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
  branch == 0 ? registerAdata = [] : registerBdata = [];
  String path =
      "company/" + (branch == 0 ? "branchA" : "branchB") + "/register";
  Map temp;
  db.collection(path).snapshots().listen((QuerySnapshot querySnapshot) {
    querySnapshot.docs.forEach((element) {
      temp = element.data();
      print(temp);
      branch == 0 ? registerAdata.addAll([temp]) : registerBdata.addAll([temp]);
    });
  });
  return branch == 0 ? registerAdata : registerBdata;
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
  Future.delayed(Duration(seconds: 2));
  return info;
}
