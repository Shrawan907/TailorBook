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
void initState(BuildContext ctx) {
  initConnectivity(_key,ctx);
}

@override
void dispose() {
  _connectivitySubscription.cancel();
}

// Platform messages are asynchronous, so we initialize in an async method.
Future<void> initConnectivity(final _key, BuildContext ctx) async {
  ConnectivityResult result;
  // Platform messages may fail, so we use a try/catch PlatformException.
  try {
    result = await _connectivity.checkConnectivity();
  } on PlatformException catch (e) {
    print(e.toString());
  }

  return _updateConnectionStatus(result, _key,ctx);
}

Future<void> _updateConnectionStatus(
    ConnectivityResult result, final _key, BuildContext ctx) async {
  switch (result) {
    case ConnectivityResult.wifi:
    case ConnectivityResult.mobile:
    case ConnectivityResult.none:
      connState = result.toString();
      // print(connState);
      if (connState == "ConnectivityResult.none") {
        SnackBar snackBar = SnackBar(
          content: Text(
              AppLocalizations.of(ctx).translate("no_internet"),
          ),
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
