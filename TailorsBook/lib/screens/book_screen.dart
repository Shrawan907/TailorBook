import 'dart:async';
import 'package:TailorsBook/locale/app_localization.dart';
import 'package:TailorsBook/screens/signin.dart';
import 'package:flutter/material.dart';
import 'package:TailorsBook/common/nav_drower.dart';
import 'package:TailorsBook/common/cardBox.dart';
import 'package:TailorsBook/handle_cloud/data_file.dart';
import 'package:TailorsBook/screens/register_new.dart';
import 'package:TailorsBook/screens/on_working.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/services.dart';

List register = [];
List duplicateRegister = [];

class BookScreen extends StatefulWidget {
  final int branch;
  BookScreen({this.branch});
  @override
  _BookScreenState createState() => _BookScreenState(branch: this.branch);
}

class _BookScreenState extends State<BookScreen> {
  final int branch;
  _BookScreenState({this.branch});
  TextEditingController editingController = TextEditingController();
  @override
  void initState() {
    super.initState();
    fetchInitalData();
  }

  void fetchInitalData() async {
    await fetchData();
    setState(() {});
  }

  Future fetchData() async {
    register.clear();
    register = [...(await getRegister(this.branch))];
    duplicateRegister.clear();
    duplicateRegister = [...register];
  }

  void filterSearchResults(String query) {
    if (query.isNotEmpty) {
      List dummyListData = [];
      duplicateRegister.forEach((item) {
        if (item["reg_no"].toString().contains(query)) {
          dummyListData.add(item);
        }
      });
      setState(() {
        print(duplicateRegister.length);
        register.clear();
        register.addAll(dummyListData);
      });
      return;
    } else {
      setState(() {
        print(duplicateRegister.length);
        register = [...duplicateRegister];
      });
    }
  }

  @override
  Widget build(BuildContext parentContext) {
    return Scaffold(
      backgroundColor: Colors.black54,
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).translate("t_register") +
            " " +
            (this.branch == 0
                ? "A"
                : "B")), //Text(AppLocalizations.of(context).translate("t_return_today")),
        actions: <Widget>[
          Container(
            width: 150,
            height: 20,
            margin: EdgeInsets.only(right: 50, bottom: 5, top: 5),
            decoration: BoxDecoration(
              border: Border(bottom: BorderSide(width: 2)),
            ),
            child: TextField(
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              onChanged: (value) {
                filterSearchResults(value);
                print(value);
              },
              controller: editingController,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: AppLocalizations.of(context).translate("search"),
                hintStyle: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                    fontWeight: FontWeight.normal),
                prefixIcon: Icon(
                  Icons.search,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          buildHeader("register", context),
          RaisedButton(onPressed: () {
            setState(() {
              duplicateRegister = [...register];
            });
          }),
          Expanded(
            child: Container(
              child: //register.isNotEmpty ?
                  RefreshIndicator(
                onRefresh: () async {
                  print("/////////////////////////////////////register.length");
                  print(register.length);
                  try {
                    setState(() async {
                      register = await fetchRegisterData(this.branch);
                      register.forEach((element) {
                        duplicateRegister.add(element);
                      });
                    });
                    print(register.isEmpty);
                  } catch (err) {
                    print("Refresh Bar Error: " + err);
                  }
                },
                child: Container(
                  child: ListView.builder(
                    itemCount: register.length,
                    // itemCount:
                        // register.isEmpty ? 0 : register[branch].length,     //solved error here length value error
                    itemBuilder: (context, index) {
                      return RegCardBox(
                        regNo: register[index]['reg_no'],
                        isComplete: register[index]['is_complete'],
                        date: register[index]['return_date'].toDate(),
                        branch: this.branch,
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
