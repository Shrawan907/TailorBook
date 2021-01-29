import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';

FirebaseFirestore db = FirebaseFirestore.instance;
DateTime timestamp = DateTime.now();

Map info = {};
List todayData = [];
List oldData = [];
List tommData = [];
List overmData = [];
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
List jodJacketR = [];
List blazerR = [];
List safariR = [];
List othersR = [];
List assignedData = [];
List completedData = [];

// fetch data Date-wise
Future<List> fetchTodayData(DateTime date) async {
  List tempData = [[], []];
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
            'coat': temp['coat'] != null ? temp['coat'] : temp['blazer']
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
            'coat': temp['coat'] != null ? temp['coat'] : temp['blazer']
          }
        ]);
      }
    });
  });
  await Future.delayed(Duration(seconds: 2));
  return tempData;
}

// clear tommorow data
void clearTomData() {
  tommData.clear();
}

// clear overmorrow data
void clearOverData() {
  overmData.clear();
}

// clear today data
void clearTodayData() {
  todayData.clear();
}

// return today data
Future<List> todaydata() async {
  if (todayData.isEmpty || todayData == null) {
    todayData = [...(await fetchTodayData(timestamp))];
    return todayData;
  }
  return todayData;
}

// return tommorow data
Future<List> tommdata() async {
  if (tommData.isEmpty || tommData == null) {
    tommData = [...(await fetchTodayData(timestamp.add(Duration(days: 1))))];
    return tommData;
  }
  return tommData;
}

// return overmorrow data
Future<List> overmdata() async {
  if (overmData.isEmpty || overmData == null) {
    overmData = [...(await fetchTodayData(timestamp.add(Duration(days: 2))))];
    return overmData;
  }
  return overmData;
}

Future fetchOldData() async {
  List tempData = [[], []];
  db
      .collection("company/branchA/register")
      .orderBy("returnDate", descending: true)
      .snapshots()
      .listen((QuerySnapshot querySnapshot) {
    querySnapshot.docs.forEach((element) {
      Map temp = element.data();
      DateTime dt = temp["returnDate"].toDate();
      print(dt.difference(timestamp).inDays);
      if (dt.difference(timestamp).inDays < 0 &&
          temp != null &&
          temp.containsKey('isComplete') &&
          temp['isComplete'] == false) {
        tempData[0].addAll([
          {
            'regNo': temp['regNo'],
            'isComplete': temp['isComplete'],
            'returnDate': temp['returnDate'],
          }
        ]);
      }
    });
  });
  db
      .collection("company/branchB/register")
      .orderBy("returnDate", descending: true)
      .snapshots()
      .listen((QuerySnapshot querySnapshot) {
    querySnapshot.docs.forEach((element) {
      Map temp = element.data();
      DateTime dt = temp["returnDate"].toDate();
      if (dt.difference(timestamp).inDays < 0 &&
          temp.containsKey('isComplete') &&
          temp['isComplete'] == false) {
        tempData[1].addAll([
          {
            'regNo': temp['regNo'],
            'isComplete': temp['isComplete'],
            'returnDate': temp['returnDate'],
          }
        ]);
      }
    });
  });
  await Future.delayed(Duration(seconds: 2));
  return tempData;
}

void clearOldData() {
  oldData.clear();
}

Future getOldData() async {
  if (oldData == null || oldData.isEmpty) {
    oldData = [...(await fetchOldData())];
  }
  print(oldData);
  print('ok');
  return oldData;
}

// fetch data for register A or B
Future<List> fetchRegisterData(int branch) async {
  List tempData = [];
  String path =
      "company/" + (branch == 0 ? "branchA" : "branchB") + "/register";
  Map temp;
  db
      .collection(path)
      .orderBy("regNo", descending: true) // improve by arrangement
      .snapshots()
      .listen((QuerySnapshot querySnapshot) {
    querySnapshot.docs.forEach((element) {
      temp = element.data();
      print(temp);
      if (temp.containsKey('returnDate') &&
          ((timestamp).difference(temp['returnDate'].toDate()).inDays < 240))
        tempData.addAll([temp]);
    });
  });
  await Future.delayed(Duration(seconds: 2));
  return tempData;
}

// clean the register
void cleanRegister(int branch) {
  if (branch == 0) {
    registerAdata.clear();
  } else {
    registerBdata.clear();
  }
}

// return the register
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

// function to fetch the detail of item if exits ( support function for fetchDetail() )
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

// fetch the detail of giver register number
Future<Map> fetchDetail(int regNo, int branch) async {
  String path = "company/" + (branch == 0 ? "branchA" : "branchB");
  info = {};
  db
      .collection(path + "/register")
      .where("regNo", isEqualTo: regNo)
      .snapshots()
      .listen((QuerySnapshot querySnapshot) {
    var temp = querySnapshot.docs.first.data();
    print(temp);
    info["branch"] = branch;
    info["regNo"] = temp["regNo"];
    info["isComplete"] = temp["isComplete"];
    info["returnDate"] = temp["returnDate"].toDate();
    if (temp.containsKey('delivered')) {
      info["delivered"] = temp['delivered'];
    }
    see(path, temp, "coat", regNo);
    see(path, temp, "pent", regNo);
    see(path, temp, "shirt", regNo);
    see(path, temp, "jacket", regNo);
    see(path, temp, "kurta", regNo);
    see(path, temp, "pajama", regNo);
    see(path, temp, "achkan", regNo);
    see(path, temp, "jodJacket", regNo);
    see(path, temp, "blazer", regNo);
    see(path, temp, "safari", regNo);
    see(path, temp, "others", regNo);
  });
  await Future.delayed(Duration(seconds: 2));
  return info;
}

// fetch the requests if there any
Future<List> fetchRequestData() async {
  List tempData = [];
  var requestPath = db.collection("company/requests/requests");
  db.collection("company").doc("requests").get().then((element) => {
        if (element.data() != null &&
            element.data().containsKey("total") &&
            element.data()["total"] > 0)
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

// clear the request list
void clearRequestData() {
  requestData.clear();
  requestCount = -1;
}

// return the request list
Future<List> getRequestData() async {
  if (requestCount == -1) {
    requestData.clear();
    requestData = [...(await fetchRequestData())];
  }
  print(requestData);
  return requestData;
}

// return count of requests exists
int getRequestCount() {
  return requestCount;
}

// accept the request
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

// decline the request
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

// clean the members list
void cleanTeams() {
  teamA.clear();
  teamB.clear();
  teamC.clear();
}

// fetch members
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
            {
              "name": temp["name"],
              "profile": temp["profile"],
              "phoneNo": temp["phoneNo"]
            }
          ]);
        } else if (temp["profile"] == "PENT MAKER") {
          teamB.addAll([
            {
              "name": temp["name"],
              "profile": temp["profile"],
              "phoneNo": temp["phoneNo"]
            }
          ]);
        } else if (temp["profile"] == "SHIRT MAKER") {
          teamC.addAll([
            {
              "name": temp["name"],
              "profile": temp["profile"],
              "phoneNo": temp["phoneNo"]
            }
          ]);
        }
      }
    });
  });
  await Future.delayed(Duration(seconds: 2));
}

// return Coat team
Future<List> getTeamA() async {
  if (teamA == null || teamA.isEmpty) {
    await fetchMembers();
  }
  return teamA;
}

// return Pent team
Future<List> getTeamB() async {
  if (teamB == null || teamB.isEmpty) {
    await fetchMembers();
  }
  return teamB;
}

// return Shirt team
Future<List> getTeamC() async {
  if (teamC == null || teamC.isEmpty) {
    await fetchMembers();
  }
  return teamC;
}

// (currently) it is use for fetching COATs which are not complete
Future fetchItemRegister(String item) async {
  itemRegister = [];
  var itemPath = db.collection("company/branchA/products/products/$item");
  itemPath
      .orderBy('regNo', descending: true)
      .snapshots()
      .listen((QuerySnapshot querySnapshot) {
    querySnapshot.docs.forEach((element) {
      Map temp = element.data();
      if (temp.containsKey("isComplete") &&
          temp["isComplete"] == false &&
          temp.containsKey('status')) {
        int cnt = 0;
        for (int i = 0; i < temp['status'].length; i++) {
          if (temp['status'][i] == 'cut' || temp['status'][i] == 'uncut') cnt++;
        }
        if (cnt > 0) {
          itemRegister.addAll([
            {
              "regNo": temp["regNo"],
              "count": cnt,
              "branch": 0,
              "returnDate": temp["return"],
            }
          ]);
        }
      }
    });
  });
  itemPath = db.collection("company/branchB/products/products/$item");
  itemPath
      .orderBy('regNo', descending: true)
      .snapshots()
      .listen((QuerySnapshot querySnapshot) {
    querySnapshot.docs.forEach((element) {
      Map temp = element.data();
      if (temp.containsKey("isComplete") &&
          temp["isComplete"] == false &&
          temp.containsKey('status')) {
        int cnt = 0;
        for (int i = 0; i < temp['status'].length; i++) {
          if (temp['status'][i] == 'cut' || temp['status'][i] == 'uncut') cnt++;
        }
        if (cnt > 0) {
          itemRegister.addAll([
            {
              "regNo": temp["regNo"],
              "count": cnt,
              "branch": 1,
              "returnDate": temp["return"],
            }
          ]);
        }
      }
    });
  });

  await Future.delayed(Duration(seconds: 2));
}

// clean the item register
void cleanItemRegister() {
  itemRegister.clear();
}

// return the item register
Future getItemRegister(String item) async {
  if (itemRegister == null || itemRegister.isEmpty) {
    await fetchItemRegister(item);
  }
  return itemRegister;
}

// it fetch the items which are not cut yet
Future<List> fetchCuttingRegister(String item) async {
  List tempData = [];
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
  await Future.delayed(Duration(seconds: 2));
  tempData.sort((a, b) => (a['returnDate']).compareTo(b['returnDate']));
  return tempData;
}

// clean the cutting register
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
  else if (item == "jodJacket")
    jodJacketR.clear();
  else if (item == "blazer")
    blazerR.clear();
  else if (item == "safari")
    safariR.clear();
  else if (item == "others") othersR.clear();
}

// return the cutting register
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
  } else if (item == "jodJacket") {
    if (jodJacketR == null || jodJacketR.isEmpty) {
      jodJacketR.clear();
      jodJacketR = [...(await fetchCuttingRegister(item))];
    }
    return jodJacketR;
  } else if (item == "blazer") {
    if (blazerR == null || blazerR.isEmpty) {
      blazerR.clear();
      blazerR = [...(await fetchCuttingRegister(item))];
    }
    return blazerR;
  } else if (item == "safari") {
    if (safariR == null || safariR.isEmpty) {
      safariR.clear();
      safariR = [...(await fetchCuttingRegister(item))];
    }
    return safariR;
  } else if (item == "others") {
    if (othersR == null || othersR.isEmpty) {
      othersR.clear();
      othersR = [...(await fetchCuttingRegister(item))];
    }
    return othersR;
  }
}

// use by cutItem function
void updateCuttingRegister(int regNo, String item, int branch, int count) {
  if (item == "coat") {
    var pk = coatR.where((element) => element['regNo'] == regNo).first;
    if (pk['count'] == count) {
      print(pk);
      coatR.remove(pk);
    } else {
      print(pk);
      (coatR.where((element) => element['regNo'] == regNo).first)['count'] =
          pk['count'] - count;
      print(coatR.where((element) => element['regNo'] == regNo).first);
    }
  } else if (item == "pent") {
    var pk = pentR.where((element) => element['regNo'] == regNo).first;
    if (pk['count'] == count) {
      print(pk);
      pentR.remove(pk);
    } else {
      print(pk);
      (pentR.where((element) => element['regNo'] == regNo).first)['count'] =
          pk['count'] - count;
      print(pentR.where((element) => element['regNo'] == regNo).first);
    }
  } else if (item == "shirt") {
    var pk = shirtR.where((element) => element['regNo'] == regNo).first;
    if (pk['count'] == count) {
      print(pk);
      shirtR.remove(pk);
    } else {
      print(pk);
      (shirtR.where((element) => element['regNo'] == regNo).first)['count'] =
          pk['count'] - count;
      print(shirtR.where((element) => element['regNo'] == regNo).first);
    }
  } else if (item == "jacket") {
    var pk = jacketR.where((element) => element['regNo'] == regNo).first;
    if (pk['count'] == count) {
      print(pk);
      jacketR.remove(pk);
    } else {
      print(pk);
      (jacketR.where((element) => element['regNo'] == regNo).first)['count'] =
          pk['count'] - count;
      print(jacketR.where((element) => element['regNo'] == regNo).first);
    }
  } else if (item == "kurta") {
    var pk = kurtaR.where((element) => element['regNo'] == regNo).first;
    if (pk['count'] == count) {
      print(pk);
      kurtaR.remove(pk);
    } else {
      print(pk);
      (kurtaR.where((element) => element['regNo'] == regNo).first)['count'] =
          pk['count'] - count;
      print(kurtaR.where((element) => element['regNo'] == regNo).first);
    }
  } else if (item == "pajama") {
    var pk = pajamaR.where((element) => element['regNo'] == regNo).first;
    if (pk['count'] == count) {
      print(pk);
      pajamaR.remove(pk);
    } else {
      print(pk);
      (pajamaR.where((element) => element['regNo'] == regNo).first)['count'] =
          pk['count'] - count;
      print(pajamaR.where((element) => element['regNo'] == regNo).first);
    }
  } else if (item == "achkan") {
    var pk = achkanR.where((element) => element['regNo'] == regNo).first;
    if (pk['count'] == count) {
      print(pk);
      achkanR.remove(pk);
    } else {
      print(pk);
      (achkanR.where((element) => element['regNo'] == regNo).first)['count'] =
          pk['count'] - count;
      print(achkanR.where((element) => element['regNo'] == regNo).first);
    }
  } else if (item == "jodJacket") {
    var pk = jodJacketR.where((element) => element['regNo'] == regNo).first;
    if (pk['count'] == count) {
      print(pk);
      jodJacketR.remove(pk);
    } else {
      print(pk);
      (jodJacketR
          .where((element) => element['regNo'] == regNo)
          .first)['count'] = pk['count'] - count;
      print(jodJacketR.where((element) => element['regNo'] == regNo).first);
    }
  } else if (item == "blazer") {
    var pk = blazerR.where((element) => element['regNo'] == regNo).first;
    if (pk['count'] == count) {
      print(pk);
      blazerR.remove(pk);
    } else {
      print(pk);
      (blazerR.where((element) => element['regNo'] == regNo).first)['count'] =
          pk['count'] - count;
      print(blazerR.where((element) => element['regNo'] == regNo).first);
    }
  } else if (item == "safari") {
    var pk = safariR.where((element) => element['regNo'] == regNo).first;
    if (pk['count'] == count) {
      print(pk);
      safariR.remove(pk);
    } else {
      print(pk);
      (safariR.where((element) => element['regNo'] == regNo).first)['count'] =
          pk['count'] - count;
      print(safariR.where((element) => element['regNo'] == regNo).first);
    }
  } else if (item == "others") {
    var pk = othersR.where((element) => element['regNo'] == regNo).first;
    if (pk['count'] == count) {
      print(pk);
      othersR.remove(pk);
    } else {
      print(pk);
      (othersR.where((element) => element['regNo'] == regNo).first)['count'] =
          pk['count'] - count;
      print(othersR.where((element) => element['regNo'] == regNo).first);
    }
  }
}

// to update cutting detail of item
Future cutItem(int regNo, String item, int branch, int count) async {
  var temp;
  var itemPath = db
      .collection("company")
      .doc(branch == 0 ? "branchA" : "branchB")
      .collection("products/products/$item");
  itemPath.doc("$regNo").get().then((snapShot) => {
        if (snapShot.exists)
          {
            temp = snapShot.data()['status'],
            updateCuttingRegister(regNo, item, branch, count),
          }
      });

  await Future.delayed(Duration(seconds: 2));
  print(temp);
  if (temp != null) {
    int r = 0;
    for (int i = 0; i < temp.length && r < count; i++) {
      if (temp[i] == 'uncut') {
        temp[i] = 'cut';
        r++;
      }
    }
    itemPath.doc("$regNo").update({"status": temp});
  }
}

// delete all the data of given Register Number
Future deleteDataOf(int regNo, int branch) async {
  var registerPath = db
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
  var othersPath = products.collection("others");

  coatPath.doc('$regNo').get().then((snapShot) => {
        if (snapShot.exists) {coatPath.doc('$regNo').delete()}
      });
  pentPath.doc('$regNo').get().then((snapShot) => {
        if (snapShot.exists) {pentPath.doc('$regNo').delete()}
      });
  shirtPath.doc('$regNo').get().then((snapShot) => {
        if (snapShot.exists) {shirtPath.doc('$regNo').delete()}
      });
  jacketPath.doc('$regNo').get().then((snapShot) => {
        if (snapShot.exists) {jacketPath.doc('$regNo').delete()}
      });
  kurtaPath.doc('$regNo').get().then((snapShot) => {
        if (snapShot.exists) {kurtaPath.doc('$regNo').delete()}
      });
  pajamaPath.doc('$regNo').get().then((snapShot) => {
        if (snapShot.exists) {pajamaPath.doc('$regNo').delete()}
      });
  achkanPath.doc('$regNo').get().then((snapShot) => {
        if (snapShot.exists) {achkanPath.doc('$regNo').delete()}
      });
  jodJacketPath.doc('$regNo').get().then((snapShot) => {
        if (snapShot.exists) {jodJacketPath.doc('$regNo').delete()}
      });
  blazerPath.doc('$regNo').get().then((snapShot) => {
        if (snapShot.exists) {blazerPath.doc('$regNo').delete()}
      });
  safariPath.doc('$regNo').get().then((snapShot) => {
        if (snapShot.exists) {safariPath.doc('$regNo').delete()}
      });
  othersPath.doc('$regNo').get().then((snapShot) => {
        if (snapShot.exists) {othersPath.doc('$regNo').delete()}
      });
  registerPath.doc('$regNo').get().then((snapShot) => {
        if (snapShot.exists) {registerPath.doc('$regNo').delete()}
      });
}

//to fetch team members data
Future<List> fetchAssignedData(String phoneNo) async {
  List tempData = [];
  var dataPath = db.collection("company/team/members/$phoneNo/assigned");
  // print(phoneNo);
  dataPath.snapshots().listen((QuerySnapshot querySnapshot) {
    querySnapshot.docs.forEach((element) {
      Map temp = element.data();
      print(temp);
      // if (temp["isComplete"]) {
      tempData.addAll([
        {
          'branch': temp["branch"],
          'regNo': temp["regNo"],
          'type': temp["type"],
          'count': temp["count"],
        }
      ]);
    });
  });
  await Future.delayed(Duration(seconds: 2));
  return tempData;
}

void clearAssignedData() {
  assignedData.clear();
}

Future<List> getAssignedData(String phoneNo) async {
  if (assignedData == null || assignedData.isEmpty) {
    assignedData = [...(await fetchAssignedData(phoneNo))];
    return assignedData;
  } else {
    return assignedData;
  }
// return assignedData;
}

Future<List> fetchCompletedData(String phoneNo) async {
  List tempData = [];
  var dataPath = db.collection("company/team/members/$phoneNo/completed");
  dataPath.snapshots().listen((QuerySnapshot querySnapshot) {
    querySnapshot.docs.forEach((element) {
      Map temp = element.data();
      print(temp);
      // if (temp["isComplete"]) {
      tempData.addAll([
        {
          'branch': temp["branch"],
          'regNo': temp["regNo"],
          'type': temp["type"],
          'count': temp["count"],
        }
      ]);
    });
  });
  await Future.delayed(Duration(seconds: 2));
  return tempData;
}

void clearCompletedData() {
  completedData.clear();
}

Future<List> getCompletedData(String phoneNo) async {
  if (completedData == null || completedData.isEmpty) {
    completedData = [...(await fetchCompletedData(phoneNo))];
    return completedData;
  } else {
    return completedData;
  }
}

Future<bool> getCheck(int branch, int regNo, String item, int count) async {
  print(item);
  bool proceed = false;
  int cnt = 0;
  Map temp;
  var path = db
      .collection('company')
      .doc(branch == 0 ? "branchA" : "branchB")
      .collection('products/products/$item');
  path.doc('$regNo').get().then((element) => {
        temp = element.data(),
        if (temp != null &&
            temp.containsKey('isComplete') &&
            temp['isComplete'] == false &&
            temp.containsKey('status'))
          {
            for (int i = 0; i < temp['status'].length; i++)
              {
                print(temp['status'][i]),
                if (temp['status'][i] == 'cut' || temp['status'][i] == 'uncut')
                  cnt++,
              },
          }
        else
          {
            print(temp),
            print(temp.containsKey('isComplete')),
            print(temp.containsKey('status')),
          }
      }); //
  await Future.delayed(Duration(seconds: 1, milliseconds: 250));
  print(cnt);
  print(count);
  if (count > 0 && count <= cnt) proceed = true;
  print('hello');
  print(proceed);
  return proceed;
}

Future assignWork(List items, String phoneNo) async {
  var path = db.collection('company/team/members');
  var subPath = path.doc(phoneNo).collection('assigned');
  var itemPath;
  int tempCount = 0;
  path.doc(phoneNo).get().then((snapShot) => {
        if (snapShot.exists)
          {
            items.forEach((data) => {
                  tempCount = 0,
                  print("${data['branch']}_${data['regNo']}_${data['type']}"),
                  db
                      .collection('company')
                      .doc(data['branch'] == 0 ? 'branchA' : 'branchB')
                      .collection('products/products')
                      .doc('${data["type"]}')
                      .get()
                      .then((snapShot) => {
                            if (snapShot.exists)
                              {
                                if (snapShot.data().containsKey('status'))
                                  {
                                    snapShot.data().update('status',
                                        (elements) => {elements.forEach})
                                  }
                              }
                          }),
                  subPath
                      .doc("${data['branch']}_${data['regNo']}_${data['type']}")
                      .get()
                      .then((snapShot) => {
                            if (snapShot.exists)
                              {
                                subPath
                                    .doc(
                                        "${data['branch']}_${data['regNo']}_${data['type']}")
                                    .update({
                                  'count': FieldValue.increment(data['count'])
                                }),
                              }
                            else
                              {
                                subPath
                                    .doc(
                                        "${data['branch']}_${data['regNo']}_${data['type']}")
                                    .set({
                                  'branch': data['branch'],
                                  'regNo': data['regNo'],
                                  'type': data['type'],
                                  'count': data['count']
                                })
                              }
                          }),
                }),
          }
        else
          {
            print('No user with phoneNo: {$phoneNo} Exists'),
          }
      });
}

//to update completed work by team member
Future completeWork(int regNo, String phone, String item, int branch, int count,
    int totalCount) async {
  var path = db.collection('company/team/members');
  var subPath = path.doc(phone).collection('completed');
  var subPath2 = path.doc(phone).collection('assigned');
  var regPath = db
      .collection('company')
      .doc(branch == 0 ? "branchA" : "branchB")
      .collection('register');
  var temp;
  var itemPath = db
      .collection("company")
      .doc(branch == 0 ? "branchA" : "branchB")
      .collection("products/products/$item");
  String name = "";

  // delete from assigned and update in completed data of team member
  path.doc(phone).get().then((snapShot) => {
        if (snapShot.exists)
          {
            if (snapShot != null && snapShot.data().containsKey('name'))
              name = (snapShot.data())['name'],
            // make change in assigned part
            if (count == totalCount)
              {
                subPath2
                    .doc("$branch" + "_" + "$regNo" + "_" + "$item")
                    .delete(),
              }
            else if (count < totalCount)
              {
                subPath2
                    .doc("$branch" + "_" + "$regNo" + "_" + "$item")
                    .update({'count': totalCount - count}),
              }
            else
              print("Okay lets check completeWork code again...."),

            // make change in completed part
            subPath
                .doc("$branch" + "_" + "$regNo" + "_" + "$item")
                .get()
                .then((snapShot) => {
                      if (snapShot.exists)
                        {
                          subPath
                              .doc("$branch" + "_" + "$regNo" + "_" + "$item")
                              .update({'count': FieldValue.increment(count)}),
                        }
                      else
                        {
                          subPath
                              .doc("$branch" + "_" + "$regNo" + "_" + "$item")
                              .set({
                            'branch': branch,
                            'regNo': regNo,
                            'type': item,
                            'count': count
                          })
                        }
                    }),
          }
        else
          {print("snapShot doesn't exists!")}
      });

  //update work completed to the register
  itemPath.doc("$regNo").get().then((snapShot) => {
        if (snapShot.exists)
          {
            temp = snapShot.data()['status'],
            // update notCompleteItemCount
            regPath.doc('$regNo').update({
              'notCompleteItemCount': FieldValue.increment(-count),
            }),
          }
      });

  await Future.delayed(Duration(seconds: 2));

  // check and update complete status of register Number
  regPath.doc('$regNo').get().then((element) => {
        if (element.data() != null &&
            element.data().containsKey('notCompleteItemCount') &&
            (element.data())['notCompleteItemCount'] == 0)
          {
            regPath.doc('$regNo').update({'isComplete': true}),
          }
      });

  // update items in products folder
  if (temp != null) {
    int r = 0;
    for (int i = 0; i < temp.length && r < count; i++) {
      if (temp[i] == name) {
        temp[i] = '#' +
            name; // # shows that this item is complete , followed by name who made this item
        r++;
      }
    }
    for (int i = 0; i < temp.length && r < count; i++) {
      if (temp[i] == 'cut') {
        temp[i] = '#' +
            name; // # shows that this item is complete , followed by name who made this item
        r++;
      }
    }
    for (int i = 0; i < temp.length && r < count; i++) {
      if (temp[i] == 'uncut') {
        temp[i] = '#' +
            name; // # shows that this item is complete , followed by name who made this item
        r++;
      }
    }
    itemPath.doc("$regNo").update({"status": temp});
  }
}
