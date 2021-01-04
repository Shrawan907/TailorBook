import 'package:TailorsBook/common/buttons.dart';
import 'package:TailorsBook/locale/app_localization.dart';
import 'package:TailorsBook/screens/profile.dart';
import 'package:TailorsBook/screens/search_result.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:TailorsBook/handle_cloud/data_file.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CardBox extends StatelessWidget {
  final int regNo;
  final bool isComplete;
  final int coat;
  final int branch;

  const CardBox({this.regNo, this.isComplete, this.coat, this.branch});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey[100], // lightGreenAccent
      child: GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => SearchResult(
                        regNo: this.regNo,
                        branch: this.branch,
                      )));
        },
        child: Container(
          height: 40,
          margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Expanded(
                child: Text(
                  '$regNo',
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 30,
                      color: this.branch == 0
                          ? Colors.deepPurple
                          : Colors.red[700]),
                ),
              ),
              Expanded(
                child: Text(
                  coat == null ? " " : "    $coat",
                  style: TextStyle(fontSize: 22),
                ),
              ),
              Expanded(
                child: isComplete
                    ? Icon(
                        Icons.check,
                        color: Colors.green,
                      )
                    : Icon(
                        Icons.close,
                        color: Colors.red,
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DayCardBox extends StatelessWidget {
  final int regNo;
  final bool isComplete;
  final int coat;
  final int branch;

  const DayCardBox({this.regNo, this.isComplete, this.coat, this.branch});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.blue[50], // lightGreenAccent
      child: GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => SearchResult(
                        regNo: this.regNo,
                        branch: this.branch,
                      )));
        },
        child: Container(
          height: 40,
          margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Expanded(
                child: Text(
                  '$regNo',
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 30,
                      color: this.branch == 0
                          ? Colors.deepPurple
                          : Colors.red[700]),
                ),
              ),
              Expanded(
                child: Text(
                  coat == null ? " " : "    $coat",
                  style: TextStyle(fontSize: 22),
                ),
              ),
              Expanded(
                child: isComplete
                    ? Icon(
                        Icons.check,
                        color: Colors.green,
                      )
                    : Text(""),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class RegisterCard extends StatelessWidget {
  final String regNo;
  final bool delivered;
  final String coat;

  const RegisterCard({this.regNo, this.delivered, this.coat});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.amber[50], // lightGreenAccent
      child: Container(
        height: 40,
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Expanded(
              child: Text(
                '$regNo',
                style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 30,
                    color: delivered ? Colors.black : Colors.deepPurple),
              ),
            ),
            Expanded(
              child: Text(
                coat == '0' ? " " : "    " + coat,
                style: TextStyle(fontSize: 22),
              ),
            ),
            Expanded(
              child: delivered
                  ? Icon(
                      Icons.check,
                      color: Colors.black,
                    )
                  : Text(""),
            ),
          ],
        ),
      ),
    );
  }
}

class PersonInfo extends StatelessWidget {
  final String name;
  final ImageProvider image;
  final Color color;
  final Function onPressed;
  final String profile;
  final String phoneNo;

  PersonInfo({this.name, this.image, this.onPressed, this.color, this.profile, this.phoneNo});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, right: 10),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Profile(
                name: this.name,
                profile: this.profile,
                phoneNo: this.phoneNo,
              ),
            ),
          );
        },
        child: Container(
          height: 150,
          width: 150,
          decoration: BoxDecoration(
            border: Border.all(color: this.color, width: 2),
            color: Colors.transparent,
          ),
          child: RaisedButton(
            color: Colors.amber[50],
            padding: EdgeInsets.only(left: 0),
            onPressed: this.onPressed,
            child: Column(
              children: [
                Expanded(
                    //this.image,
                    child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: image,
                      fit: BoxFit.cover,
                    ),
                  ),
                )),
                Container(
                  color: this.color,
                  height: 40,
                  width: 150,
                  //width: double.infinity,
                  child: Center(
                    child: Text(
                      this.name,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class InfoCard extends StatelessWidget {
  final ImageProvider image;
  final String name;
  final String phone;
  final String profile;
  InfoCard({this.name, this.profile, this.phone, this.image});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        height: 150,
        color: Colors.black12,
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                width: 135,
                height: 140,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black, width: 4),
                  borderRadius: BorderRadius.circular(100),
                ),
                child: CircleAvatar(
                  radius: 20,
                  backgroundImage: image,
                  backgroundColor: Colors.transparent,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 10, top: 15, bottom: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Container(
                        child: Text(
                          name,
                          style: TextStyle(
                              fontSize: 25, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(
                        profile,
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        Icon(Icons.phone),
                        Text(
                          " " + phone,
                          style:
                              TextStyle(fontSize: 20, color: Colors.blue[700]),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ShirtCardBox extends StatelessWidget {
  final int regNo;
  final bool isComplete;
  final String type;
  final bool isColor;

  const ShirtCardBox({this.regNo, this.isComplete, this.type, this.isColor});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: isColor ? Colors.grey[200] : null,
      borderOnForeground: true,
      child: Container(
        height: 25,
        margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Expanded(
              child: Text(
                '$regNo',
                style: TextStyle(
                    //fontWeight: FontWeight.bold,
                    fontSize: 25,
                    color: isComplete ? Colors.black : Colors.blue),
              ),
            ),
            Expanded(
              child: type == "shirt"
                  ? Icon(
                      Icons.check,
                      color: Colors.grey,
                    )
                  : Text(""),
            ),
            Expanded(
              child: type == "kurta"
                  ? Icon(
                      Icons.check,
                      color: Colors.grey,
                    )
                  : Text(""),
            ),
            Expanded(
              child: type == "pajama"
                  ? Icon(
                      Icons.check,
                      color: Colors.grey,
                    )
                  : Text(""),
            ),
            Expanded(
              child: type == "safari"
                  ? Icon(
                      Icons.check,
                      color: Colors.grey,
                    )
                  : Text(""),
            ),
            Expanded(
              child: type == "other"
                  ? Icon(
                      Icons.check,
                      color: Colors.grey,
                    )
                  : Text(""),
            ),
          ],
        ),
      ),
    );
  }
}

// class PantCardBox extends StatelessWidget {
//   final String regNo;
//   final bool isComplete;
//   final String type;
//   final bool isColor;
//
//   const ShirtCardBox({this.regNo, this.isComplete, this.type, this.isColor});
//
//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       color: isColor ? Colors.grey[200] : null,
//       borderOnForeground: true,
//       child: Container(
//         height: 25,
//         margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
//         child: Row(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           mainAxisAlignment: MainAxisAlignment.spaceAround,
//           children: <Widget>[
//             Expanded(
//               child: Text(
//                 '$regNo',
//                 style: TextStyle(
//                   //fontWeight: FontWeight.bold,
//                     fontSize: 25,
//                     color: isComplete ? Colors.black : Colors.blue),
//               ),
//             ),
//             Expanded(
//               child: type == "safari"
//                   ? Icon(
//                 Icons.check,
//                 color: Colors.grey,
//               )
//                   : Text(""),
//             ),
//             Expanded(
//               child: type == "kurta"
//                   ? Icon(
//                 Icons.check,
//                 color: Colors.grey,
//               )
//                   : Text(""),
//             ),
//             Expanded(
//               child: type == "pajama"
//                   ? Icon(
//                 Icons.check,
//                 color: Colors.grey,
//               )
//                   : Text(""),
//             ),
//             Expanded(
//               child: type == "shirt"
//                   ? Icon(
//                 Icons.check,
//                 color: Colors.grey,
//               )
//                   : Text(""),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class CoatCardBox extends StatelessWidget {
//   final String regNo;
//   final bool isComplete;
//   final String type;
//   final bool isColor;
//
//   const ShirtCardBox({this.regNo, this.isComplete, this.type, this.isColor});
//
//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       color: isColor ? Colors.grey[200] : null,
//       borderOnForeground: true,
//       child: Container(
//         height: 25,
//         margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
//         child: Row(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           mainAxisAlignment: MainAxisAlignment.spaceAround,
//           children: <Widget>[
//             Expanded(
//               child: Text(
//                 '$regNo',
//                 style: TextStyle(
//                   //fontWeight: FontWeight.bold,
//                     fontSize: 25,
//                     color: isComplete ? Colors.black : Colors.blue),
//               ),
//             ),
//             Expanded(
//               child: type == "safari"
//                   ? Icon(
//                 Icons.check,
//                 color: Colors.grey,
//               )
//                   : Text(""),
//             ),
//             Expanded(
//               child: type == "kurta"
//                   ? Icon(
//                 Icons.check,
//                 color: Colors.grey,
//               )
//                   : Text(""),
//             ),
//             Expanded(
//               child: type == "pajama"
//                   ? Icon(
//                 Icons.check,
//                 color: Colors.grey,
//               )
//                   : Text(""),
//             ),
//             Expanded(
//               child: type == "shirt"
//                   ? Icon(
//                 Icons.check,
//                 color: Colors.grey,
//               )
//                   : Text(""),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

class RegCardBox extends StatelessWidget {
  final int regNo;
  final bool isComplete;
  final DateTime date;
  final int branch;
  const RegCardBox({this.regNo, this.isComplete, this.date, this.branch});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => SearchResult(
                      regNo: regNo,
                      branch: branch,
                    )));
      },
      child: Container(
        height: 40,
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        padding: EdgeInsets.only(bottom: 10, left: 10),
        decoration: BoxDecoration(
          border: Border(bottom: BorderSide(width: 1, color: Colors.amber)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Expanded(
              child: Text(
                '$regNo',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                    color: branch == 0 ? Colors.blue : Colors.blue[200]),
              ),
            ),
            Expanded(
              child: isComplete ? Icon(Icons.check) : Container(),
            ),
            Expanded(
              child: Text(
                "${date.day}-${date.month}-${date.year}",
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class RequestCard extends StatelessWidget {
  final String phoneNo;
  final String profile;
  final String name;
  final Function function;

  const RequestCard({this.name, this.phoneNo, this.profile, this.function});

  acceptRequest(BuildContext context) async {
    await requestAccept(this.phoneNo);
    function();
    Navigator.pop(context);
  }

  declineRequest(BuildContext context) async {
    await requestDecline(this.phoneNo);
    function();
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 130,
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(width: 2, color: Colors.amber),
      ),
      child: GestureDetector(
        onTap: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  content: Container(
                    height: 300,
                    width: 200,
                    padding: EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          child: RaisedButton(
                              onPressed: () {
                                acceptRequest(context);
                              },
                              child: Row(
                                children: [
                                  Text(
                                    "Accept  ",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Icon(
                                    Icons.check,
                                    color: Colors.white,
                                    size: 25,
                                  )
                                ],
                              ),
                              color: Colors.deepPurple),
                        ),
                        Container(
                          child: RaisedButton(
                              onPressed: () {
                                declineRequest(context);
                              },
                              child: Row(
                                children: [
                                  Text(
                                    "Decline  ",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Icon(
                                    Icons.close,
                                    color: Colors.white,
                                    size: 25,
                                  )
                                ],
                              ),
                              color: Colors.red),
                        ),
                        Container(
                          child: RaisedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text(
                              "Back",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                            color: Colors.amber,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              });
        },
        child: Column(
          children: [
            Expanded(
                child: Container(
              child: Row(
                children: [
                  Container(
                      width: 100,
                      child: Text(
                        "Name",
                        style: TextStyle(fontSize: 20),
                      )),
                  Expanded(
                    child: Container(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Text(
                          name,
                          style:
                              TextStyle(fontSize: 20, color: Colors.deepPurple),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            )),
            Expanded(
                child: Container(
              child: Row(
                children: [
                  Container(
                      width: 100,
                      child: Text(
                        "Phone",
                        style: TextStyle(fontSize: 20),
                      )),
                  Expanded(
                      child: Container(
                          child: Text(
                    phoneNo,
                    style: TextStyle(fontSize: 20, color: Colors.deepPurple),
                  )))
                ],
              ),
            )),
            Expanded(
                child: Container(
              child: Row(
                children: [
                  Container(
                      width: 100,
                      child: Text(
                        "Profile",
                        style: TextStyle(fontSize: 20),
                      )),
                  Expanded(
                      child: Container(
                          child: Text(
                    profile,
                    style: TextStyle(fontSize: 20, color: Colors.deepPurple),
                  )))
                ],
              ),
            )),
          ],
        ),
      ),
    );
  }
}

class ItemCardBox extends StatelessWidget {
  final int regNo;
  final int count;
  final int branch;
  final DateTime returnDate;
  const ItemCardBox({this.regNo, this.count, this.branch, this.returnDate});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => SearchResult(
                      regNo: regNo,
                      branch: branch,
                    )));
      },
      child: Container(
        height: 40,
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        padding: EdgeInsets.only(bottom: 10, left: 10),
        decoration: BoxDecoration(
          border: Border(bottom: BorderSide(width: 1, color: Colors.amber)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Expanded(
              child: Text(
                "$regNo",
                style: TextStyle(
                    fontSize: 30,
                    color: branch == 0 ? Colors.blue : Colors.blue[100]),
              ),
            ),
            Expanded(
              child: Text(
                '$count',
                style: TextStyle(fontSize: 25, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CuttingCardBox extends StatelessWidget {
  final int regNo;
  final int count;
  final int branch;
  final DateTime returnDate;
  final String item;
  final Function function;
  const CuttingCardBox(
      {this.regNo,
        this.count,
        this.branch,
        this.returnDate,
        this.item,
        this.function});
  Future onTap(BuildContext context) async {
    int value = count;
    bool loading = false;
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              content: Container(
                height: 380,
                width: 300,
                padding: EdgeInsets.all(20),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        width: 150,
                        decoration: BoxDecoration(
                          border: Border(bottom: BorderSide(width: 2)),
                        ),
                        child: Center(
                          child: Text(
                            (branch == 0 ? "A " : "B ") + "$regNo",
                            style: TextStyle(
                                fontSize: 40,
                                color: branch == 0
                                    ? Colors.deepPurple
                                    : Colors.red[800]),
                          ),
                        ),
                      ),
                      SizedBox(height: 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 35,
                            child: SvgPicture.asset(
                              'assets/images/${this.item}.svg',
                              height: 20,
                              width: 20,
                              color: Colors.black54,
                            ),
                          ),
                          Text(
                            "$item",
                            style: TextStyle(color: Colors.black54),
                          ),
                        ],
                      ),
                      SizedBox(height: 50),
                      Text("Total: $count ", style: TextStyle(fontSize: 20)),
                      SizedBox(height: 10),
                      Container(
                        padding: EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          border: Border.all(width: 1),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            UpdateValueButton(
                              icon: Icons.remove,
                              perform: () {
                                setState(() {
                                  if (value > 1) value--;
                                });
                              },
                            ),
                            Container(
                              height: 30,
                              width: 40,
                              child: Center(
                                child: Text(
                                  value.toString(),
                                  style: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                            UpdateValueButton(
                              icon: Icons.add,
                              perform: () {
                                setState(() {
                                  if (value < count) value++;
                                  print(value);
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 10),
                      loading == true
                          ? SpinKitThreeBounce(
                        color: Colors.blueAccent,
                        size: 15,
                      )
                          : SizedBox(height: 10),
                      SizedBox(height: 30),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: RaisedButton(
                              elevation: 5.0,
                              color: Colors.red[200],
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Container(
                                  height: 60,
                                  width: 60,
                                  child: Icon(
                                    Icons.arrow_back,
                                    color: Colors.white,
                                    size: 30,
                                  )),
                              shape: CircleBorder(),
                            ),
                          ),
                          Expanded(
                            child: RaisedButton(
                              elevation: 5.0,
                              color: Colors.blue[200],
                              onPressed: () async {
                                setState(() {
                                  loading = true;
                                });
                                await cutItem(regNo, item, branch, value);
                                await function();
                                Navigator.pop(context);
                              },
                              child: Container(
                                  height: 60,
                                  width: 60,
                                  child: Icon(
                                    Icons.content_cut,
                                    color: Colors.white,
                                    size: 30,
                                  )),
                              shape: CircleBorder(),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          });
        });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        // await Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //         builder: (context) => UpdateCut(
        //               regNo: this.regNo,
        //               count: this.count,
        //               branch: this.branch,
        //               returnDate: this.returnDate,
        //               item: this.item,
        //             )));
        await onTap(context);
      },
      child: Card(
        color: Colors.red[50],
        child: Container(
          height: 40,
          margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: Text(
                  "$regNo",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                      color: branch == 0 ? Colors.deepPurple : Colors.red[800]),
                ),
              ),
              Expanded(
                child: Text(
                  '$count',
                  style: TextStyle(fontSize: 25),
                ),
              ),
              Expanded(
                child: Text(
                  '${returnDate.day} - ${returnDate.month}',
                  style: TextStyle(fontSize: 25),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Card buildHeader(String headerType, BuildContext context) {
  if (headerType == "dailyInfo") {
    return Card(
      child: Container(
        height: 20,
        decoration: BoxDecoration(
          color: Colors.black54,
          border: Border(
            bottom: BorderSide(
              color: Colors.white,
              width: 1.0,
            ),
          ),
        ),
        padding: EdgeInsets.only(left: 30, right: 0),
        child: Container(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                  child: Text(
                AppLocalizations.of(context).translate("reg_no"),
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: Colors.white),
              )),
              Expanded(
                  child: Text(
                AppLocalizations.of(context).translate("coat"),
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: Colors.white),
              )),
              Expanded(
                  child: Text(
                "     " + AppLocalizations.of(context).translate("complete"),
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: Colors.white),
              ))
            ],
          ),
        ),
      ),
    );
  } else if (headerType == "SHIRT MAKER") {
    return Card(
      child: Container(
        height: 20,
        decoration: BoxDecoration(
          color: Colors.black54,
        ),
        padding: EdgeInsets.only(left: 15, right: 15),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
                child: Text(
              AppLocalizations.of(context).translate("reg_no"),
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  color: Colors.white),
            )),
            SizedBox(
              width: 20,
            ),
            Expanded(
                child: Text(
              AppLocalizations.of(context).translate("shirt"),
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  color: Colors.white),
            )),
            Expanded(
                child: Text(
              AppLocalizations.of(context).translate("kurta"),
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  color: Colors.white),
            )),
            Expanded(
                child: Text(
              AppLocalizations.of(context).translate("pajama"),
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  color: Colors.white),
            )),
            Expanded(
                child: Text(
              "   " + AppLocalizations.of(context).translate("safari"),
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  color: Colors.white),
            )),
            Expanded(
                child: Text(
              "   " + AppLocalizations.of(context).translate("other"),
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  color: Colors.white),
            )),
          ],
        ),
      ),
    );
  } else if (headerType == "COAT MAKER") {
    return Card(
      child: Container(
        height: 20,
        decoration: BoxDecoration(
          color: Colors.black54,
        ),
        padding: EdgeInsets.only(left: 15, right: 15),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
                child: Text(
              AppLocalizations.of(context).translate("reg_no"),
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  color: Colors.white),
            )),
            SizedBox(
              width: 20,
            ),
            Expanded(
                child: Text(
              AppLocalizations.of(context).translate("coat"),
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  color: Colors.white),
            )),
            Expanded(
                child: Text(
              AppLocalizations.of(context).translate("jacket"),
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  color: Colors.white),
            )),
            Expanded(
                child: Text(
              AppLocalizations.of(context).translate("achkan"),
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  color: Colors.white),
            )),
            Expanded(
                child: Text(
              "   " + AppLocalizations.of(context).translate("other"),
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  color: Colors.white),
            )),
          ],
        ),
      ),
    );
  } else if (headerType == "PENT MAKER") {
    return Card(
      child: Container(
        height: 20,
        decoration: BoxDecoration(
          color: Colors.black54,
        ),
        padding: EdgeInsets.only(left: 15, right: 15),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
                child: Text(
              AppLocalizations.of(context).translate("reg_no"),
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  color: Colors.white),
            )),
            SizedBox(
              width: 20,
            ),
            Expanded(
                child: Text(
              AppLocalizations.of(context).translate("pent"),
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  color: Colors.white),
            )),
            Expanded(
                child: Text(
              AppLocalizations.of(context).translate("pajama"),
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  color: Colors.white),
            )),
            Expanded(
                child: Text(
              "   " + AppLocalizations.of(context).translate("other"),
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  color: Colors.white),
            )),
          ],
        ),
      ),
    );
  } else if (headerType == "add_shirt") {
    return Card(
      child: Container(
        height: 20,
        decoration: BoxDecoration(
          color: Colors.black54,
          border: Border(
            bottom: BorderSide(
              color: Colors.white,
              width: 1.0,
            ),
          ),
        ),
        //padding: EdgeInsets.only(left: 30, right: 0),
        child: Container(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                  child: Center(
                child: Text(
                  AppLocalizations.of(context).translate("reg_no"),
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      color: Colors.white),
                ),
              )),
              Expanded(
                  child: Center(
                child: Text(
                  AppLocalizations.of(context).translate("count"),
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      color: Colors.white),
                ),
              )),
              Expanded(
                  child: Center(
                child: Text(
                  AppLocalizations.of(context).translate("type"),
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      color: Colors.white),
                ),
              ))
            ],
          ),
        ),
      ),
    );
  } else if (headerType == "register") {
    return Card(
      child: Container(
        height: 20,
        decoration: BoxDecoration(
          color: Colors.black54,
          border: Border(
            bottom: BorderSide(
              color: Colors.white,
              width: 1.0,
            ),
          ),
        ),
        padding: EdgeInsets.only(left: 30, right: 0),
        child: Container(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                  child: Text(
                AppLocalizations.of(context).translate("reg_no"),
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: Colors.white),
              )),
              Expanded(
                  child: Text(
                AppLocalizations.of(context).translate("complete"),
                //AppLocalizations.of(context).translate(""),
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: Colors.white),
              )),
              Expanded(
                  child: Center(
                child: Text(
                  AppLocalizations.of(context).translate("date"),
                  //AppLocalizations.of(context).translate(""),
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      color: Colors.white),
                ),
              )),
            ],
          ),
        ),
      ),
    );
  } else if (headerType == "itemRegister") {
    return Card(
      child: Container(
        height: 20,
        decoration: BoxDecoration(
          color: Colors.black54,
          border: Border(
            bottom: BorderSide(
              color: Colors.white,
              width: 1.0,
            ),
          ),
        ),
        padding: EdgeInsets.only(left: 30, right: 0),
        child: Container(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                  child: Text(
                AppLocalizations.of(context).translate("reg_no"),
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: Colors.white),
              )),
              Expanded(
                  child: Text(
                "COUNT",
                //AppLocalizations.of(context).translate(""),
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: Colors.white),
              )),
            ],
          ),
        ),
      ),
    );
  } else if (headerType == "cuttingRegister") {
    return Card(
      child: Container(
        height: 20,
        decoration: BoxDecoration(
          color: Colors.black54,
          border: Border(
            bottom: BorderSide(
              color: Colors.white,
              width: 1.0,
            ),
          ),
        ),
        padding: EdgeInsets.only(left: 30, right: 0),
        child: Container(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                  child: Text(
                AppLocalizations.of(context).translate("reg_no"),
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: Colors.white),
              )),
              Expanded(
                  child: Text(
                "COUNT",
                //AppLocalizations.of(context).translate(""),
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: Colors.white),
              )),
              Expanded(
                  child: Text(
                "RETURN",
                //AppLocalizations.of(context).translate(""),
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: Colors.white),
              )),
            ],
          ),
        ),
      ),
    );
  } else {
    return Card();
  }
}
