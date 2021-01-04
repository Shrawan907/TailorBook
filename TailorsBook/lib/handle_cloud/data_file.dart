import 'dart:async';
import 'dart:collection';
import 'dart:io';

import 'package:TailorsBook/screens/data_today.dart';
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
List itemRegister = [];
int requestCount = -1;
List teamA = []; // Coat Maker
List teamB = []; // Pent Maker
List teamC = []; // Shirt Maker
List coatR = [];
List pentR = [];
List shirtR = [];
List jacketR = [];
List kurtaR = [];
List pajamaR = [];
List achkanR = [];
List othersR = [];
List assignedData = [];

Future<List> fetchTodayData(DateTime date) async {
  tempData.clear();
  tempData = [[], []];
  db
      .collection("company/branchA/register")
      .orderBy("regNo", descending: true)
      .snapshots()
      .listen((QuerySnapshot querySnapshot) {
    querySnapshot.docs.forEach((element) {
      Map temp = element.data();
      DateTime dt = temp["returnDate"].toDate();
      if (date.day == dt.day &&
          date.month == dt.month &&
          date.year == dt.year) {
        print(temp);
        tempData[0].addAll([
          {
            'regNo': temp['regNo'],
            'isComplete': temp['isComplete'],
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
      DateTime dt = temp["returnDate"].toDate();
      if (date.day == dt.day &&
          date.month == dt.month &&
          date.year == dt.year) {
        tempData[1].addAll([
          {
            'regNo': temp['regNo'],
            'isComplete': temp['isComplete'],
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
  db
      .collection(path)
      .orderBy("regNo", descending: true)                   // improve by arrangement
      .snapshots()
      .listen((QuerySnapshot querySnapshot) {
    querySnapshot.docs.forEach((element) {
      temp = element.data();
      print(temp);
      tempData.addAll([temp]);
    });
  });
  await Future.delayed(Duration(seconds: 2));
  return tempData;
}

void cleanRegister(int branch) {
  if (branch == 0) {
    registerAdata.clear();
  } else {
    registerBdata.clear();
  }
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
        .where("regNo", isEqualTo: regNo)
        .snapshots()
        .listen((QuerySnapshot querySnapshot) {
      var tmp = querySnapshot.docs.first.data();
      //print(temp);
      info["$key"] = {
        "count": tmp["count"],
        "isComplete": tmp["isComplete"],
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
      .where("regNo", isEqualTo: regNo)
      .snapshots()
      .listen((QuerySnapshot querySnapshot) {
    var temp = querySnapshot.docs.first.data();
    //print(temp);
    info["regNo"] = temp["regNo"];
    info["isComplete"] = temp["isComplete"];
    DateTime date = temp["returnDate"].toDate();
    info["returnDate"] = "${date.day}-${date.month}-${date.year}";
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

void cleanTeams() {
  teamA.clear();
  teamB.clear();
  teamC.clear();
}

Future fetchMembers() async {
  teamA.clear();
  teamB.clear();
  teamC.clear();

  var membersPath = db.collection("company/team/members");
  membersPath.snapshots().listen((QuerySnapshot querySnapshot) {
    querySnapshot.docs.forEach((element) {
      Map temp = element.data();
      print(temp);
      if (temp.containsKey("requestAccepted") &&
          temp["requestAccepted"] &&
          temp.containsKey("profile")) {
        if (temp["profile"] == "COAT MAKER") {
          teamA.addAll([
            {"name": temp["name"], "profile": temp["profile"], "phoneNo": temp["phoneNo"]}
          ]);
        } else if (temp["profile"] == "PENT MAKER") {
          teamB.addAll([
            {"name": temp["name"], "profile": temp["profile"], "phoneNo": temp["phoneNo"]}
          ]);
        } else if (temp["profile"] == "SHIRT MAKER") {
          teamC.addAll([
            {"name": temp["name"], "profile": temp["profile"], "phoneNo": temp["phoneNo"]}
          ]);
        }
      }
    });
  });

  await Future.delayed(Duration(seconds: 2));
}

Future<List> getTeamA() async {
  if (teamA == null || teamA.isEmpty) {
    await fetchMembers();
  }
  return teamA;
}

Future<List> getTeamB() async {
  if (teamB == null || teamB.isEmpty) {
    await fetchMembers();
  }
  return teamB;
}

Future<List> getTeamC() async {
  if (teamC == null || teamC.isEmpty) {
    await fetchMembers();
  }
  return teamC;
}

Future fetchItemRegister(String item) async {
  itemRegister = [];
  var itemPath = db.collection("company/branchA/products/products/$item");
  itemPath
      .orderBy("regNo", descending: true)
      .snapshots()
      .listen((QuerySnapshot querySnapshot) {
    querySnapshot.docs.forEach((element) {
      Map temp = element.data();
      if (temp.containsKey("isComplete") && temp["isComplete"] == false) {
        itemRegister.addAll([
          {
            "regNo": temp["regNo"],
            "count": temp["count"],
            "branch": 0,
            "returnDate": temp["return"]
          }
        ]);
      }
    });
  });
  itemPath = db.collection("company/branchB/products/products/$item");
  itemPath
      .orderBy("regNo", descending: true)
      .snapshots()
      .listen((QuerySnapshot querySnapshot) {
    querySnapshot.docs.forEach((element) {
      Map temp = element.data();
      if (temp.containsKey("isComplete") && temp["isComplete"] == false) {
        itemRegister.addAll([
          {
            "regNo": temp["regNo"],
            "count": temp["count"],
            "branch": 1,
            "returnDate": temp["return"]
          }
        ]);
      }
    });
  });

  await Future.delayed(Duration(seconds: 2));
  print(itemRegister);
}

void cleanItemRegister() {
  itemRegister.clear();
}

Future getItemRegister(String item) async {
  if (itemRegister == null || itemRegister.isEmpty) {
    await fetchItemRegister(item);
  }
  return itemRegister;
}

Future<List> fetchCuttingRegister(String item) async {
  tempData.clear();
  tempData = [];
  int cnt = 0;
  var itemPath = db.collection("company/branchA/products/products/$item");
  itemPath.snapshots().listen((QuerySnapshot querySnapshot) {
    querySnapshot.docs.forEach((element) {
      Map temp = element.data();
      if (temp.containsKey("isComplete") && temp['isComplete'] == false) {
        cnt = 0;
        for (int i = 0; i < temp['count']; i++) {
          if (temp['status'][i] == 'uncut') {
            cnt++;
          }
        }
        if (cnt > 0) {
          tempData.addAll([
            {
              "regNo": temp["regNo"],
              "count": cnt,
              "returnDate": temp['return'],
              "branch": 0,
            }
          ]);
        }
      }
    });
  });
  itemPath = db.collection("company/branchB/products/products/$item");
  itemPath.snapshots().listen((QuerySnapshot querySnapshot) {
    querySnapshot.docs.forEach((element) {
      Map temp = element.data();
      if (temp.containsKey("isComplete") && temp['isComplete'] == false) {
        cnt = 0;
        for (int i = 0; i < temp['count']; i++) {
          if (temp['status'][i] == 'uncut') {
            cnt++;
          }
        }
        if (cnt > 0) {
          tempData.addAll([
            {
              "regNo": temp["regNo"],
              "count": cnt,
              "returnDate": temp['return'],
              "branch": 1,
            }
          ]);
        }
      }
    });
  });

  tempData.sort((a, b) => (a['returnDate']).compareTo(b['returnDate']));

  await Future.delayed(Duration(seconds: 2));
  print(tempData);
  return tempData;
}

void cleanCuttingRegister(String item) {
  if (item == "coat")
    coatR.clear();
  else if (item == "pent")
    pentR.clear();
  else if (item == "shirt")
    shirtR.clear();
  else if (item == "jacket")
    jacketR.clear();
  else if (item == "kurta")
    kurtaR.clear();
  else if (item == "pajama")
    pajamaR.clear();
  else if (item == "achkan")
    achkanR.clear();
  else if (item == "others") othersR.clear();
}

Future getCuttingRegister(String item) async {
  if (item == "coat") {
    if (coatR == null || coatR.isEmpty) {
      coatR.clear();
      coatR = [...(await fetchCuttingRegister(item))];
    }
    print(coatR);
    return coatR;
  } else if (item == "pent") {
    if (pentR == null || pentR.isEmpty) {
      pentR.clear();
      pentR = [...(await fetchCuttingRegister(item))];
    }
    return pentR;
  } else if (item == "shirt") {
    if (shirtR == null || shirtR.isEmpty) {
      shirtR.clear();
      shirtR = [...(await fetchCuttingRegister(item))];
    }
    return shirtR;
  } else if (item == "jacket") {
    if (jacketR == null || jacketR.isEmpty) {
      jacketR.clear();
      jacketR = [...(await fetchCuttingRegister(item))];
    }
    return jacketR;
  } else if (item == "kurta") {
    if (kurtaR == null || kurtaR.isEmpty) {
      kurtaR.clear();
      kurtaR = [...(await fetchCuttingRegister(item))];
    }
    return kurtaR;
  } else if (item == "pajama") {
    if (pajamaR == null || pajamaR.isEmpty) {
      pajamaR.clear();
      pajamaR = [...(await fetchCuttingRegister(item))];
    }
    return pajamaR;
  } else if (item == "achkan") {
    if (achkanR == null || achkanR.isEmpty) {
      achkanR.clear();
      achkanR = [...(await fetchCuttingRegister(item))];
    }
    return achkanR;
  } else if (item == "others") {
    if (othersR == null || othersR.isEmpty) {
      othersR.clear();
      othersR = [...(await fetchCuttingRegister(item))];
    }
    return othersR;
  }
}

Future<List> fetchData(String phoneNo) async {
  tempData.clear();
  // tempData = [[], []];
  var dataPath = db.collection("company/team/members/$phoneNo/assigned");
  // print(phoneNo);
  dataPath.snapshots().listen((QuerySnapshot querySnapshot) {
    querySnapshot.docs.forEach((element) {
      Map temp = element.data();
      print(temp);
      // if (temp["isComplete"]) {
        tempData.addAll([
          {
            'regNo': temp["reg_no"],
            'type': temp["type"],
            'count': temp["count"],
            'isComplete': temp["isComplete"]
          }
        ]);
      // } else {
    //     tempData[0].addAll([
    //       {
    //         'regNo': temp["reg_no"],
    //         'type': temp["type"],
    //         'count': temp["count"]
    //       }
    //     ]);
    //   }
    });
  });
  await Future.delayed(Duration(seconds: 2));
  return tempData;
}

void clearData() {
  assignedData.clear();
}

Future<List> getAssignedData(String phoneNo) async {
  clearData();
  if (assignedData == null || assignedData.isEmpty) {
    assignedData.clear();
    assignedData = [...(await fetchData(phoneNo))];
    return assignedData;
  } else {
    return assignedData;
  }
// return assignedData;
}


