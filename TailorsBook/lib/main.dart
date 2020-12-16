import 'package:TailorsBook/locale/localInfo.dart';
import 'package:TailorsBook/screens/homepage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:TailorsBook/signin.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:TailorsBook/locale/app_localization.dart';
import 'package:provider/provider.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:intl/intl.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  LocalInfo localData = LocalInfo();
  await localData.fetchLocale();

  await localData.fetchLogDetail();
  print(" XXXX " + localData.loggedIn.toString());
  runApp(MyApp(
    localData: localData,
    loggedIn: localData.loggedIn,
  ));
}

class MyApp extends StatelessWidget {
  final LocalInfo localData;
  final bool loggedIn;
  MyApp({this.localData, this.loggedIn});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<LocalInfo>(
      create: (_) => localData,
      child: Consumer<LocalInfo>(builder: (context, model, child) {
        return MaterialApp(
          locale: model.appLocal,
          debugShowCheckedModeBanner: false,
          supportedLocales: [
            Locale('en', ''),
            Locale('hi', ''),
          ],
          localizationsDelegates: [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
          title: 'Flutter Demo',
          theme: ThemeData(
              primarySwatch: Colors.amber,
              visualDensity: VisualDensity.adaptivePlatformDensity,
              accentColor: Colors.grey),
          home: loggedIn == false
              ? MyHomePage(
                  title:
                      "I AM TAILOR", //AppLocalizations.of(context).translate("welcom_aap_name"),
                )
              : HomePage(),
        );
      }),
    );
  }
}

// For Localization (Multiple Language)
// https://medium.com/flutter-community/flutter-internationalization-the-easy-way-using-provider-and-json-c47caa4212b2
