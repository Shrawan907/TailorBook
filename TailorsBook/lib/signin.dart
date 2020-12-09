import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:TailorsBook/handle_cloud/login.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  User currentUser;
  bool isAuth = false;
  Authenticate _authenticate = Authenticate();

  @override
  void initState() {
    super.initState();

    googleSignIn.onCurrentUserChanged.listen((account) async {
      currentUser = await _authenticate.handleSignIn(account);
      setState(() {
        if (currentUser == null)
          isAuth = false;
        else
          isAuth = true;
      });
    }, onError: (err) {
      print("Error signing in: $err");
    });

    googleSignIn.signInSilently(suppressErrors: false).then((account) async {
      currentUser = await _authenticate.handleSignIn(account);

      setState(() {
        if (currentUser == null)
          isAuth = false;
        else
          isAuth = true;
      });
    }).catchError((err) {
      print("Error signing in silently: $err");
    });

    print("\n Current User $currentUser \n");
  }

  Scaffold buildUnAuthScreen(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Welcome to Tailor Book"),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Theme.of(context).accentColor,
              Theme.of(context).primaryColor
            ],
          ),
        ),
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            GestureDetector(
              onTap: _authenticate.login,
              child: Container(
                width: 260.0,
                height: 60.0,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/google_signin_button.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Scaffold buildAuthScreen(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Welcom! You are signed in."),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return isAuth ? buildAuthScreen(context) : buildUnAuthScreen(context);
  }
}
