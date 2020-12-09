import 'dart:async';
import 'package:flutter/material.dart';

class CreateCompany extends StatefulWidget {
  @override
  _CreateCompanyState createState() => _CreateCompanyState();
}

class _CreateCompanyState extends State<CreateCompany> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  //  responsible for executing on saved as well as getting
  //  the current state of our form
  final controller = TextEditingController(text: null);
  String username;
  String _passWord;
  bool user_can_make_company = false;

  @override
  void initState() {
    super.initState();
    setState(() {
      user_can_make_company = false;
      print("\n $user_can_make_company \n");
    });
  }

  submit() {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      SnackBar snackBar = SnackBar(
        content: Text("Welcome $username!"),
      );
      _scaffoldKey.currentState.showSnackBar(snackBar);
      Timer(Duration(seconds: 2), () {
        Navigator.pop(context, username);
      });
    } else
      print("\n makeCompanyScreen, form is not valid.");
  }

  Scaffold makeCompanyScreen(BuildContext parentContext) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        centerTitle: true,
        title: Text("Create Account"),
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
                        controller: TextEditingController(text: null),
                        validator: (val) {
                          if (val.trim().length < 3 || val.trim().isEmpty)
                            return "Username too short";
                          else if (val.trim().length > 12)
                            return "Username too short";
                          else
                            return null;
                        },
                        onSaved: (val) => username = val,
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
                GestureDetector(
                  onTap: () {}, //submit,
                  child: Container(
                    height: 40.0,
                    width: 250.0,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Center(
                      child: Text(
                        "Submit",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Scaffold passwordScreen(BuildContext parentContext) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        centerTitle: true,
        title: Text("Admin Page"),
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
                      'Enter Password',
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
                        obscureText: true,
                        controller: controller,
                        validator: (String val) {
                          if (val.trim().isEmpty) {
                            return "Password is required";
                          }
                          return null;
                        },
                        onChanged: (val) => _passWord = val,
                        //onSaved: (val) => _passWord = val,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "Password",
                          labelStyle: TextStyle(fontSize: 15.0),
                        ),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    if (_passWord == "shrawan98") {
                      _passWord = null;
                      setState(() {
                        user_can_make_company = true;
                      });
                    }
                  }, //submit,
                  child: Container(
                    height: 40.0,
                    width: 250.0,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Center(
                      child: Text(
                        "Submit",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext parentContext) {
    return user_can_make_company
        ? makeCompanyScreen(parentContext)
        : passwordScreen(parentContext);
  }
}
