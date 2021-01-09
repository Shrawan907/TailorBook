import 'package:TailorsBook/handle_cloud/data_file.dart';
import 'package:TailorsBook/locale/localInfo.dart';
import 'package:TailorsBook/screens/requestPage.dart';
import 'package:TailorsBook/screens/signin.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:TailorsBook/handle_cloud/login.dart';
import 'package:TailorsBook/screens/create_company.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:provider/provider.dart';
import 'package:TailorsBook/locale/app_localization.dart';

import '../locale/app_localization.dart';

int reqCount = 0;

class NavDrawer extends StatefulWidget {
  @override
  _NavDrawerState createState() => _NavDrawerState();
}

class _NavDrawerState extends State<NavDrawer> {
  Authenticate _authenticate = Authenticate();
  bool _isVisible = false;
  int _radioValue;

  @override
  void initState() {
    super.initState();
    initialData();
  }

  void initialData() {
    reqCount = getRequestCount();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var localData = Provider.of<LocalInfo>(context);
    _radioValue = localData.appLocal.languageCode == "en" ? 0 : 1;
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Text(
              AppLocalizations.of(context).translate("n_menu"),
              style: TextStyle(color: Colors.white, fontSize: 25),
            ),
            decoration: BoxDecoration(color: Colors.amber
                // image: DecorationImage(
                //     fit: BoxFit.fill,
                //     image: AssetImage('assets/images/cover.jpg'))
                ),
          ),
          ListTile(
            leading: Icon(Icons.input),
            title:
                Text(AppLocalizations.of(context).translate("n_make_company")),
            onTap: () => {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CreateCompany(),
                ),
              )
            },
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                  leading: Icon(Icons.language),
                  title: Text(
                    AppLocalizations.of(context).translate('ch_lang'),
                  ),
                  onTap: () {
                    setState(() {
                      if (_isVisible == false)
                        _isVisible = true;
                      else
                        _isVisible = false;
                    });
                  }),
              Visibility(
                visible: _isVisible,
                child: Container(
                  width: double.infinity,
                  color: Colors.white70,
                  padding: const EdgeInsets.only(left: 40.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ListTile(
                        leading: Radio(
                          value: 0,
                          groupValue: _radioValue,
                          activeColor: Colors.amber,
                          onChanged: (value) {
                            setState(() {
                              _radioValue = value;
                              localData.changeLanguage(Locale("en"));
                            });
                          },
                        ),
                        title: Text(
                          "English",
                        ),
                      ),
                      ListTile(
                        leading: Radio(
                            value: 1,
                            groupValue: _radioValue,
                            activeColor: Colors.amber,
                            onChanged: (value) {
                              setState(() {
                                _radioValue = value;
                                localData.changeLanguage(Locale("hi"));
                              });
                            }),
                        title: Text(
                          AppLocalizations.of(context).translate("hindi"),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          ListTile(
            leading: Icon(Icons.verified_user),
            title: Text(AppLocalizations.of(context).translate("n_profile")),
            onTap: () => {Navigator.of(context).pop()},
          ),
          // ListTile(
          //   leading: Icon(Icons.settings),
          //   title: Text('Settings'),
          //   onTap: () => {Navigator.of(context).pop()},
          // ),
          ListTile(
            leading: Icon(Icons.group_add),
            title: Row(
              children: [
                Text(AppLocalizations.of(context).translate("requests")),
                SizedBox(width: 5),
                if (reqCount > 0)
                  Text(
                    "$reqCount",
                    style: TextStyle(
                        color: Colors.amber, fontWeight: FontWeight.bold),
                  )
              ],
            ),
            onTap: () => {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => RequestPage())),
              initialData(),
            },
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text(AppLocalizations.of(context).translate("n_logout")),
            onTap: () {
              _authenticate.logout(context);
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => MyHomePage()),
                  (route) => false);
            },
          ),
        ],
      ),
    );
  }
}
