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
