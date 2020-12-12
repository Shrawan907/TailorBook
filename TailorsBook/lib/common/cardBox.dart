import 'package:flutter/material.dart';

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
