import 'dart:async';
import 'package:TailorsBook/locale/app_localization.dart';
import 'package:TailorsBook/screens/cut_home.dart';
import 'package:TailorsBook/screens/signin.dart';
import 'package:flutter/material.dart';
import 'package:TailorsBook/common/nav_drower.dart';
import 'package:TailorsBook/common/cardBox.dart';
import 'package:TailorsBook/handle_cloud/data_file.dart';
import 'package:TailorsBook/screens/register_new.dart';
import 'package:flutter/services.dart';
import 'package:TailorsBook/screens/on_working.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:TailorsBook/screens/profile.dart';
import 'package:easy_localization/easy_localization.dart';

List teamA = []; // Cutter
List teamB = []; // Coat Maker
List teamC = []; // Pent Maker
List teamD = []; // Shirt Maker

class TeamMembers extends StatefulWidget {
  @override
  _TeamMembersState createState() => _TeamMembersState();
}

class _TeamMembersState extends State<TeamMembers> {
  @override
  void initState() {
    super.initState();
    initialData();
  }

  void initialData() async {
    await getData();
    setState(() {});
  }

  Future getData() async {
    teamA.clear();
    teamB.clear();
    teamC.clear();
    teamA = [...(await getTeamA())];
    teamB = [...(await getTeamB())];
    teamC = [...(await getTeamC())];
  }

  @override
  Widget build(BuildContext parentContext) {
    return Scaffold(
      backgroundColor: Colors.black12,
      drawer: NavDrawer(),
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).translate("t_team_members")),
        centerTitle: true,
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          try {
            cleanTeams();
            await getData();
            setState(() {});
          } catch (err) {
            print("Error occure while refreshing: " + err);
          }
        },
        child: ListView(
          children: [
            Padding(
              padding: EdgeInsets.only(left: 20, top: 30, bottom: 10),
              child: RichText(
                text: TextSpan(children: [
                  WidgetSpan(
                      child: SvgPicture.asset(
                    "assets/images/coat.svg",
                    height: 30,
                  )),
                  TextSpan(
                      text: "  " +
                          AppLocalizations.of(context).translate("coat_maker"),
                      style: TextStyle(fontSize: 25, color: Colors.black)),
                ]),
              ),
            ),
            Container(
              height: 150,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: teamB.length,
                  itemBuilder: (context, index) {
                    return PersonInfo(
                      name: teamA[index]['name'],
                      image: AssetImage("assets/images/person.png"),
                      profile: teamA[index]['profile'],
                      phoneNo: teamA[index]['phoneNo'],
                      color: Colors.purple[200],
                    );
                  }),
            ),
            Padding(
              padding: EdgeInsets.only(left: 20, top: 30, bottom: 10),
              child: RichText(
                text: TextSpan(children: [
                  WidgetSpan(
                      child: SvgPicture.asset(
                    "assets/images/pent.svg",
                    height: 30,
                  )),
                  TextSpan(
                      text: "  " +
                          AppLocalizations.of(context).translate("pent_maker"),
                      style: TextStyle(fontSize: 25, color: Colors.black)),
                ]),
              ),
            ),
            Container(
              height: 150,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: teamB.length,
                  itemBuilder: (context, index) {
                    return PersonInfo(
                      name: teamB[index]['name'],
                      image: AssetImage("assets/images/person.png"),
                      profile: teamB[index]['profile'],
                      phoneNo: teamB[index]['phoneNo'],
                      color: Colors.purple[300],
                    );
                  }),
            ),
            Padding(
              padding: EdgeInsets.only(left: 20, top: 30, bottom: 10),
              child: RichText(
                text: TextSpan(children: [
                  WidgetSpan(
                      child: SvgPicture.asset(
                    "assets/images/shirt.svg",
                    height: 30,
                  )),
                  TextSpan(
                      text: "  " +
                          AppLocalizations.of(context).translate("shirt_maker"),
                      style: TextStyle(fontSize: 25, color: Colors.black)),
                ]),
              ),
            ),
            Container(
              height: 150,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: teamC.length,
                  itemBuilder: (context, index) {
                    return PersonInfo(
                      name: teamC[index]['name'],
                      image: AssetImage("assets/images/person.png"),
                      profile: teamC[index]['profile'],
                      phoneNo: teamC[index]['phoneNo'],
                      color: Colors.purple[400],
                    );
                  }),
            ),
            SizedBox(
              height: 30,
            )
          ],
        ),
      ),
    );
  }
}
