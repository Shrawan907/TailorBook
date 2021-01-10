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

List itemRegister = [];
List duplicateRegister = [];

class ItemBook extends StatefulWidget {
  final String item;
  ItemBook({this.item});
  @override
  _ItemBookState createState() => _ItemBookState(item: this.item);
}

class _ItemBookState extends State<ItemBook> {
  final String item;
  _ItemBookState({this.item});
  bool searchBar = false;
  TextEditingController editingController = TextEditingController();
  @override
  void initState() {
    super.initState();
    getInitalData();
  }

  void getInitalData() async {
    await getData();
    setState(() {});
  }

  Future getData() async {
    cleanItemRegister();
    itemRegister.clear();
    itemRegister = [...(await getItemRegister(item))];
    duplicateRegister.clear();
    duplicateRegister = [...itemRegister];
    searchBar = itemRegister.isNotEmpty;
  }

  void filterSearchResults(String query) {
    if (query.isNotEmpty) {
      List dummyListData = [];
      duplicateRegister.forEach((element) {
        if (element["regNo"].toString().contains(query)) {
          dummyListData.add(element);
        }
      });
      setState(() {
        print(duplicateRegister.length);
        itemRegister.clear();
        itemRegister.addAll(dummyListData);
      });
      return;
    } else {
      setState(() {
        print(duplicateRegister.length);
        itemRegister = [...duplicateRegister];
      });
    }
  }

  @override
  Widget build(BuildContext parentContext) {
    return Scaffold(
      backgroundColor: Colors.black54,
      appBar: AppBar(
        title: Text(item),
        actions: <Widget>[
          searchBar
              ? Container(
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
                      hintText:
                          AppLocalizations.of(context).translate("search"),
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
                )
              : Container(),
        ],
      ),
      body: Column(
        children: <Widget>[
          buildHeader("itemRegister", context),
          SizedBox(height: 20),
          Expanded(
            child: Container(
              child: //register.isNotEmpty ?
                  RefreshIndicator(
                onRefresh: () async {
                  try {
                    cleanItemRegister();
                    await getData();
                    setState(() {});
                  } catch (err) {
                    print("Refresh Bar Error: " + err);
                  }
                },
                child: Container(
                  child: ListView.builder(
                    itemCount: itemRegister.length,
                    // itemCount:
                    // itemRegister.isEmpty ? 0 : itemRegister[branch].length,     //solved error here length value error
                    itemBuilder: (context, index) {
                      return ItemCardBox(
                        regNo: itemRegister[index]['regNo'],
                        count: itemRegister[index]['count'],
                        branch: itemRegister[index]['branch'],
                        returnDate: itemRegister[index]['returnDate'] != null
                            ? itemRegister[index]['returnDate'].toDate()
                            : null,
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
