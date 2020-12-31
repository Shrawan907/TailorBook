import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';

import 'locale/app_localization.dart';

String _connectionStatus = 'Unknown';
final Connectivity _connectivity = Connectivity();
StreamSubscription<ConnectivityResult> _connectivitySubscription;
String connState = "";
final _key = "";

@override
void initState() {
  initConnectivity(_key);
}

@override
void dispose() {
  _connectivitySubscription.cancel();
}

// Platform messages are asynchronous, so we initialize in an async method.
Future<void> initConnectivity(final _key) async {
  ConnectivityResult result;
  // Platform messages may fail, so we use a try/catch PlatformException.
  try {
    result = await _connectivity.checkConnectivity();
  } on PlatformException catch (e) {
    print(e.toString());
  }

  // If the widget was removed from the tree while the asynchronous platform
  // message was in flight, we want to discard the reply rather than calling
  // setState to update our non-existent appearance.

  return _updateConnectionStatus(result, _key);
}

Future<void> _updateConnectionStatus(
    ConnectivityResult result, final _key) async {
  switch (result) {
    case ConnectivityResult.wifi:
    case ConnectivityResult.mobile:
    case ConnectivityResult.none:
      connState = result.toString();
      // print(connState);
      if (connState == "ConnectivityResult.none") {
        SnackBar snackBar = SnackBar(
          content: Text("No Internet Found!!!"),
        );
        _key.currentState.showSnackBar(snackBar);
      }
      break;
    default:
      SnackBar snackBar = SnackBar(
        content: Text("Failed to get connectivity."),
      );
      _key.currentState.showSnackBar(snackBar);
      break;
  }
}
