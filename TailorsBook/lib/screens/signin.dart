import 'dart:async';

import 'package:TailorsBook/locale/app_localization.dart';
import 'package:TailorsBook/locale/localInfo.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:TailorsBook/handle_cloud/login.dart';
import 'package:TailorsBook/common/nav_drower.dart';
import 'package:TailorsBook/test_screen.dart';
import 'package:TailorsBook/screens/homepage.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

final GoogleSignIn googleSignIn = GoogleSignIn();

class MyHomePage extends StatefulWidget {
  final String title;
  MyHomePage({this.title});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  User currentUser;
  bool isAuth = false;
  Authenticate _authenticate = Authenticate();
  String verId;
  String phoneNo;
  String smsCode;
  String verificationId;
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    googleSignIn.onCurrentUserChanged.listen((account) async {
      currentUser = await _authenticate.handleSignIn(account, context);
      setState(() {
        if (currentUser == null)
          isAuth = false;
        else
          isAuth = true;
      });
    }, onError: (err) {
      print("Error signing in: $err");
    });

    print("\n Current User $currentUser \n");
  }

  Future mustDoBeforeSignin(LocalInfo log) async {
    log.savePhoneNo(this.phoneNo);
    // await saveUserInfo(phoneNo);
    // await Future.delayed(Duration(seconds: 1));
    // await getLocalDetails(log);
    log.changeStatustoLogin();
    log.fetchLocalDetail();
  }

  Future<void> veifyPhone() async {
    print("///////////////okayokayokay///////////////");
    final PhoneCodeAutoRetrievalTimeout autoRetriveal = (String verId) {
      this.verificationId = verId;
    };
    final smsCodeSent = (String verId, [int forceCodeResend]) {
      this.verificationId = verId;
      smsCodeDialog(context).then((value) {});
    };

    final PhoneVerificationCompleted verifiedSuccess =
        (AuthCredential credential) async {
      print("verified\n");
      // UserCredential result =
      // await FirebaseAuth.instance.signInWithCredential(credential);
      // User user = result.user;
      // if (user != null) {
      //   LocalInfo log = Provider.of<LocalInfo>(context, listen: false);
      //   await mustDoBeforeSignin(log);
      //   Navigator.push(context,
      //       MaterialPageRoute(builder: (context) => HomePage()));
      // } else {
      //   print("Error ho gay bhai!");
      // }
    };
    final PhoneVerificationFailed veriFailed =
        (FirebaseAuthException exception) {
      print("phone verification failed!");
      print("${exception.message}");
    };

    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: this.phoneNo,
      codeAutoRetrievalTimeout: autoRetriveal,
      timeout: const Duration(seconds: 5),
      codeSent: smsCodeSent,
      verificationCompleted: verifiedSuccess,
      verificationFailed: veriFailed,
    );
  }

  Future<bool> smsCodeDialog(BuildContext context) {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return new AlertDialog(
            title: Text('Enter Code: '),
            content: TextField(
              onChanged: (value) {
                this.smsCode = value;
              },
            ),
            contentPadding: EdgeInsets.all(10.0),
            actions: <Widget>[
              new FlatButton(
                child: Text('Submit'),
                onPressed: () async {
                  smsCode = this.smsCode.trim();
                  try {
                    AuthCredential credential = PhoneAuthProvider.credential(
                        verificationId: verificationId, smsCode: smsCode);
                    UserCredential result = await FirebaseAuth.instance
                        .signInWithCredential(credential);
                    User user = result.user;
                    print(user);
                    if (user != null) {
                      var log = Provider.of<LocalInfo>(context, listen: false);
                      await mustDoBeforeSignin(log);
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => HomePage()));
                    } else {
                      print("\n ho gayi error yha\n");
                      Navigator.pop(context);
                    }
                  } catch (err) {
                    print(err);
                    Toast.show("Wrong OTP !", context,
                        duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
                  }
                },
              )
            ],
          );
        });
  }

  Scaffold buildUnAuthScreen(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(AppLocalizations.of(context).translate("welcom_aap_name")),
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
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  _authenticate.login(context);
                },
                child: Container(
                  width: 260.0,
                  height: 60.0,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image:
                      AssetImage('assets/images/google_signin_button.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              const Divider(
                color: Colors.amber,
                height: 60,
                thickness: 3,
                indent: 20,
                endIndent: 20,
              ),
              // SizedBox(
              //   height: 48.0,
              // ),
              Container(
                margin: EdgeInsets.only(left: 40, right: 40),
                width: 400,
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        keyboardType: TextInputType.phone,
                        textAlign: TextAlign.center,
                        onChanged: (value) {
                          // this.phoneNo="";
                          this.phoneNo = value;
                        },
                        style: TextStyle(fontSize: 22),
                        decoration: InputDecoration(
                          hintText: 'Phone Number',
                          prefixIcon: Text(
                            "+91",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 25, height: 1.5),
                          ),
                          hintStyle: TextStyle(fontSize: 15),
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 20.0),
                          border: OutlineInputBorder(
                            borderRadius:
                            BorderRadius.all(Radius.circular(32.0)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                            BorderSide(color: Colors.black, width: 2.0),
                            borderRadius:
                            BorderRadius.all(Radius.circular(32.0)),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 24.0,
              ),
              Container(
                //margin: EdgeInsets.only(left: 50, right: 50),
                width: 150,
                child: RaisedButton(
                  color: Colors.amber,
                  child: Text(
                    'Log In',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  onPressed: () {
                    print("OKAYYY");
                    // print(phoneNo.length);
                    print(phoneNo);
                    print("OKAYYY");
                    if (this.phoneNo==null || this.phoneNo.length != 10) {
                      Toast.show("Phone Number is Invalid!", context,
                          duration: Toast.LENGTH_LONG, gravity: Toast.CENTER);
                    }
                    else {
                      // print(phoneNo+"/////////////");
                      String temp = this.phoneNo;
                      this.phoneNo = ("+91" + this.phoneNo).trim();
                      // print(this.phoneNo = ("+91" + this.phoneNo).trim()+"/////////////");
                      print(phoneNo+"/////////////");
                      veifyPhone();
                      this.phoneNo = temp;
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Scaffold buildAuthScreen(BuildContext context) {
    return Scaffold(
      drawer: NavDrawer(),
      appBar: AppBar(
        title: Text(
            AppLocalizations.of(context).translate("t_create_join_company")),
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
        child: Center(
          child: SizedBox(
            width: 180,
            height: 50,
            child: RaisedButton(
              onPressed: () {
                // Navigator.push(context,
                //     MaterialPageRoute(builder: (context) => TestScreen()));
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => HomePage()));
              },
              child: Text(
                AppLocalizations.of(context).translate("join_company"),
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0),
                side: BorderSide(color: Colors.white),
              ),
              color: Colors.redAccent[100],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return isAuth ? buildAuthScreen(context) : buildUnAuthScreen(context);
  }
}