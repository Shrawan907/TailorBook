import 'dart:async';
import 'dart:collection';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:TailorsBook/handle_cloud/login.dart';

FirebaseFirestore db = FirebaseFirestore.instance;

DateTime timestamp = DateTime.now();

List todayData = [];

Future<List> fetchTodayData() async {
  todayData = [];
  db
      .collection("companies/branchA/register")
      .snapshots()
      .listen((QuerySnapshot querySnapshot) {
    querySnapshot.docs.forEach((element) {
      Map temp = element.data();
      print("Today data fetch : $temp");
      int dif = (((DateTime.parse(temp['return_date'].toDate().toString())
                          .difference(timestamp) -
                      Duration(hours: temp['return_date'].toDate().hour) +
                      Duration(hours: timestamp.hour))
                  .inHours /
              24)
          .round());
      print("Difference: " + dif.toString());
      if (dif == 6) {
        todayData.addAll([
          {
            'reg_no': temp['reg_no'].toString(),
            'is_complete': temp['is_complete'],
            'coat': temp['coat'].toString()
          }
        ]);
      }
    });
  });
  return todayData;
}
