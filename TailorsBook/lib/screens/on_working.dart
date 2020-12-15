import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class OnWork extends StatefulWidget {
  @override
  _OnWorkState createState() => _OnWorkState();
}

class _OnWorkState extends State<OnWork> {
  @override
  Widget build(BuildContext parentContext) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Oops!!"),
      ),
      body: Center(
        child: Text(
            "Sorry! This page is on maintaining process.\nTry after few days! "),
      ),
    );
  }
}
