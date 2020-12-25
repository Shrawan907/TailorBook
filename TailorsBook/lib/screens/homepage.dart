import 'package:TailorsBook/handle_cloud/data_file.dart';
import 'package:TailorsBook/test_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:TailorsBook/screens/data_today.dart';
import 'package:TailorsBook/screens/day_data.dart';
import 'package:TailorsBook/screens/shortcuts.dart';
import 'package:TailorsBook/screens/teams.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  PageController pageController;
  int pageIndex = 0;
  bool loading = true;

  @override
  void initState() {
    super.initState();
    pageController = PageController();
    initalData();
  }

  void initalData() async {
    await todaydata();
    await tommdata();
    await overmdata();
    setState(() {
      loading = false;
    });
  }

  onPageChanged(int pageIndex) {
    setState(() {
      this.pageIndex = pageIndex;
    });
  }

  onTap(int pageIndex) {
    pageController.animateToPage(pageIndex,
        duration: Duration(milliseconds: 250), curve: Curves.easeInOut);
  }

  @override
  Widget build(BuildContext parentContext) {
    return loading
        ? Scaffold(
            body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SpinKitThreeBounce(
                color: Colors.blueAccent,
                size: 25,
              ),
              Text("Check all cases at one place",
                  style: TextStyle(color: Colors.blue)),
            ],
          ))
        : Scaffold(
            body: PageView(
              children: <Widget>[
                DataToday(),
                DayData(),
                ShortCuts(),
                TeamMembers(),
                TestScreen(),
              ],
              controller: pageController,
              onPageChanged: onPageChanged,
              physics: NeverScrollableScrollPhysics(),
            ),
            bottomNavigationBar: Container(
              height: 50,
              child: CupertinoApp(
                debugShowCheckedModeBanner: false,
                home: CupertinoTabBar(
                  backgroundColor: Colors.amber,
                  currentIndex: pageIndex,
                  onTap: onTap,
                  activeColor: Colors.black,
                  items: [
                    BottomNavigationBarItem(
                      icon: Icon(Icons.whatshot),
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.date_range),
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.description),
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.group),
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.group),
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}
