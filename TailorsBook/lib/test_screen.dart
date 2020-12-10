import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:TailorsBook/handle_cloud/login.dart';
import 'package:TailorsBook/handle_cloud/data_file.dart';

FirebaseFirestore db = FirebaseFirestore.instance;

DateTime timestamp = DateTime.now();
/*
  Use this link to better understand how to use database on firestore

  https://atul-sharma-94062.medium.com/how-to-use-cloud-firestore-with-flutter-e6f9e8821b27

*/

class TestScreen extends StatefulWidget {
  @override
  _TestScreenState createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  //  responsible for executing on saved as well as getting
  //  the current state of our form
  String username;

  submit() {
    fetchTodayData();

    // db
    //     .collection("companies/branchA/register")
    //     .snapshots()
    //     .listen((QuerySnapshot querySnapshot) {
    //   querySnapshot.docs.forEach((element) {
    //     print(element.id);
    //     for (var ele in element.data().entries) {
    //       if (ele.key == "return_date") {
    //         print(ele.key +
    //             " : " +
    //             DateTime.parse(ele.value.toDate().toString()).toString());
    //         print("Days Diffrence: " +
    //             ((DateTime.parse(ele.value.toDate().toString())
    //                                 .difference(timestamp) -
    //                             Duration(hours: ele.value.toDate().hour) +
    //                             Duration(hours: timestamp.hour))
    //                         .inHours /
    //                     24)
    //                 .round()
    //                 .toString());
    //       } else
    //         print(ele.key + " : " + ele.value.toString());
    //     }
    //   });
    // });
    // print("Today Date: " + timestamp.toString());
  }

  @override
  Widget build(BuildContext parentContext) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        centerTitle: true,
        title: Text("Tes Screen"),
      ),
      body: ListView(
        children: <Widget>[
          Container(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 25.0),
                  child: Center(
                    child: Text(
                      'Create a username',
                      style: TextStyle(fontSize: 25.0),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Container(
                    child: Form(
                      // here we associate a form key with our form with the help of key
                      key: _formKey,
                      autovalidate: true, // to immediate execute validator
                      // as soon as user typed
                      child: TextFormField(
                        validator: (val) {
                          if (val.trim().length < 3 || val.trim().isEmpty)
                            return "Username too short";
                          else if (val.trim().length > 12)
                            return "Username too short";
                          else
                            return null;
                        },
                        onChanged: (val) => username = val,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "Username",
                          labelStyle: TextStyle(fontSize: 15.0),
                          hintText: "Must be atleast 3 characters",
                        ),
                      ),
                    ),
                  ),
                ),
                RaisedButton(
                  onPressed: submit,
                  child: Text("submit"),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/*

// makeing new collection
  new_collection() async {
    // adding with specified id
    await db
        .collection("books")
        .doc("1")
        .set({'title': 'master ji', 'description': 'kuch bhi'});
    
    // adding with random id
    DocumentReference ref = await db
        .collection("books")
        .add({'title': 'master ki', 'description': 'kuch bhi ese'});
    print(ref.id);
  }

// read from documents
  read() {
    db
        .collection("companies/branchA/register")
        .snapshots()
        .listen((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((element) {
        print(element.id);
        print(element.data());
      });
    });
  }

// update database
  update() {
    try {
      db.collection('books').doc('1').update({'description': 'all is well'});
    } catch (err) {
      print('update data error: $err');
    }
  }

// delete collection
  delete_collection() {
    try {
      db.collection('books').doc('1').delete();
    } catch (err) {
      print("Error during deleting: $err");
    }
  }  

*/
