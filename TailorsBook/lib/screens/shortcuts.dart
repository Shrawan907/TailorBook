import 'dart:async';
import 'package:TailorsBook/signin.dart';
import 'package:flutter/material.dart';
import 'package:TailorsBook/common/nav_drower.dart';
import 'package:TailorsBook/common/cardBox.dart';
import 'package:TailorsBook/handle_cloud/data_file.dart';
import 'package:TailorsBook/screens/register_new.dart';
import 'package:flutter/services.dart';
import 'package:TailorsBook/screens/on_working.dart';

List todayData = [];

class ShortCuts extends StatefulWidget {
  @override
  _ShortCutsState createState() => _ShortCutsState();
}

class _ShortCutsState extends State<ShortCuts> {
  int branch = 0;
  int reg_no;
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext parentContext) {
    return Scaffold(
      backgroundColor: Colors.blue,
      appBar: AppBar(
        title: Text("Shortcuts"),
      ),
      body: ListView(
        children: [
          Container(
            height: 100,
            //decoration: BoxDecoration(color: Colors.yellow),
            child: Row(
              children: [
                Container(
                  child: RaisedButton(
                      child: Container(
                        margin: EdgeInsets.all(9.0),
                        child: Text(
                          branch == 0 ? "A" : "B",
                          style: TextStyle(
                              fontSize: 35,
                              fontWeight: FontWeight.w500,
                              color:
                                  branch == 0 ? Colors.blue : Colors.blueGrey),
                        ),
                      ),
                      onPressed: () {
                        setState(() {
                          if (branch == 0) {
                            branch = 1;
                          } else {
                            branch = 0;
                          }
                        });
                      },
                      shape: CircleBorder(
                        side: BorderSide(color: Colors.black),
                      ),
                      color: Colors.white),
                ),
                Expanded(
                  child: Container(
                    height: 70,
                    margin: EdgeInsets.only(right: 10),
                    child: Form(
                      // here we associate a form key with our form with the help of key
                      key: _formKey,
                      autovalidate: true, // to immediate execute validator
                      // as soon as user typed
                      child: TextFormField(
                        validator: (val) {
                          if (val.trim().isEmpty)
                            return "Must Not Empty";
                          else if (val.trim().length > 6)
                            return "Wrong Entry";
                          else
                            return null;
                        },
                        onChanged: (val) => reg_no = int.parse(val),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(),
                          //labelText: "Reg. Number",
                          labelStyle: TextStyle(fontSize: 15.0),
                          hintText: "Number",
                        ),
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        keyboardType: TextInputType.number,
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.w400),
                      ),
                    ),
                  ),
                ),
                Container(
                  width: 100,
                  margin: EdgeInsets.only(right: 10),
                  child: RaisedButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => OnWork()));
                    },
                    child: Container(
                      height: 65,
                      child: Center(
                          child: Icon(
                        Icons.find_in_page,
                        size: 40,
                        color: Colors.white,
                      )),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      side: BorderSide(color: Colors.deepPurple),
                    ),
                    color: Colors.blueGrey,
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => OnWork()));
            },
            child: Card(
              color: Colors.blue[100], // lightGreenAccent
              child: Container(
                height: 100,
                child: Center(
                  child: Text(
                    "Register A",
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
                  ),
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => OnWork()));
            },
            child: Card(
              color: Colors.blue[100], // lightGreenAccent
              child: Container(
                height: 100,
                child: Center(
                  child: Text(
                    "Register B",
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
                  ),
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => OnWork()));
            },
            child: Card(
              color: Colors.blue[100], // lightGreenAccent
              child: Container(
                height: 100,
                child: Center(
                  child: Text(
                    "Coat",
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
                  ),
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => OnWork()));
            },
            child: Card(
              color: Colors.blue[100], // lightGreenAccent
              child: Container(
                height: 100,
                child: Center(
                  child: Text(
                    "Jacket",
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
