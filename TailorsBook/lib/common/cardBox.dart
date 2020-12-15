import 'package:TailorsBook/locale/app_localization.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class CardBox extends StatelessWidget {
  final String reg_no;
  final bool is_complete;
  final String coat;

  const CardBox({this.reg_no, this.is_complete, this.coat});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.blue[50], // lightGreenAccent
      child: Container(
        height: 40,
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Expanded(
              child: Text(
                '$reg_no',
                style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 30,
                    color: Colors.deepPurple),
              ),
            ),
            Expanded(
              child: Text(
                coat == '0' ? " " : "    " + coat,
                style: TextStyle(fontSize: 22),
              ),
            ),
            Expanded(
              child: is_complete
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
    );
  }
}

class DayCardBox extends StatelessWidget {
  final String reg_no;
  final bool is_complete;
  final String coat;

  const DayCardBox({this.reg_no, this.is_complete, this.coat});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.blue[50], // lightGreenAccent
      child: Container(
        height: 40,
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Expanded(
              child: Text(
                '$reg_no',
                style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 30,
                    color: Colors.deepPurple),
              ),
            ),
            Expanded(
              child: Text(
                coat == '0' ? " " : "    " + coat,
                style: TextStyle(fontSize: 22),
              ),
            ),
            Expanded(
              child: is_complete
                  ? Icon(
                      Icons.check,
                      color: Colors.green,
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
  final Widget image;
  final Color color;
  final Function onPressed;

  PersonInfo({this.name, this.image, this.onPressed, this.color});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, right: 10),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: this.color, width: 2),
          color: Colors.transparent,
        ),
        height: 150,
        width: 150,
        child: RaisedButton(
          color: Colors.tealAccent,
          padding: EdgeInsets.only(left: 0),
          onPressed: this.onPressed,
          child: Column(
            children: [
              Expanded(
                  child: Container(
                child: this.image,
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
  final String regNo;
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
              child: type == "safari"
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
              child: type == "shirt"
                  ? Icon(
                      Icons.check,
                      color: Colors.grey,
                    )
                  : Text(""),
            ),
            Expanded(
              child: this.isComplete
                  ? Icon(
                      Icons.check,
                      color: Colors.green,
                    )
                  : Text(""),
            ),
          ],
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
          color: Colors.cyan,
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
  } else if (headerType == "Shirt Maker") {
    return Card(
      child: Container(
        height: 20,
        decoration: BoxDecoration(
          color: Colors.cyan,
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
              AppLocalizations.of(context).translate("safari"),
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
              "   " + AppLocalizations.of(context).translate("shirt"),
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  color: Colors.white),
            )),
            Expanded(
                child: Text(
              AppLocalizations.of(context).translate("complete"),
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  color: Colors.white),
            ))
          ],
        ),
      ),
    );
  } else {
    return Card();
  }
}
