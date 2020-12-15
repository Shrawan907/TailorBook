import 'package:TailorsBook/locale/appLanguage.dart';
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
  AppLanguage appLanguage = AppLanguage();
  await appLanguage.fetchLocale();
  runApp(MyApp(appLanguage: appLanguage));
}

class MyApp extends StatelessWidget {
  final AppLanguage appLanguage;
  MyApp({this.appLanguage});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AppLanguage>(
      create: (_) => appLanguage,
      child: Consumer<AppLanguage>(builder: (context, model, child) {
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
              primarySwatch: Colors.deepPurple,
              visualDensity: VisualDensity.adaptivePlatformDensity,
              accentColor: Colors.teal),
          home: MyHomePage(
            title:
                "Welcome to Tailors Book", //AppLocalizations.of(context).translate("welcom_aap_name"),
          ),
        );
      }),
    );
  }
}

// For Localization (Multiple Language)
// https://medium.com/flutter-community/flutter-internationalization-the-easy-way-using-provider-and-json-c47caa4212b2
