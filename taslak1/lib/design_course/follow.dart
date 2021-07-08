import 'package:flutter/material.dart';
import 'package:taslak1/Services/MyFollowApi.dart';
import 'package:taslak1/Services/searh_api.dart';
import 'package:taslak1/custom_drawer/yanmenu.dart';
import 'package:taslak1/design_course/models/MyFollow.dart';

import 'design_course_app_theme.dart';

class FollowPage extends StatefulWidget {
  @override
  _FollowPageState createState() => _FollowPageState();
}

class _FollowPageState extends State<FollowPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Takip Ettiklerim"),
      ),
      drawer: YanMenu(),
      body: FutureBuilder<MyFollowList>(
        future: MyFollowApi.fetchFollowList(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const SizedBox();
          } else {
            return ListView.builder(
              itemCount: snapshot.data.myFollow.length,
              itemBuilder: (BuildContext context, int index) {
                return Dismissible(
                  key: Key(snapshot.data.myFollow[index].toString()),
                  onDismissed: (directory) async {
                    await SearchApi.addFollow(
                        snapshot.data.myFollow[index].userId.toString());
                  },
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundImage:
                          NetworkImage(snapshot.data.myFollow[index].userImage),
                    ),
                    title: Text(snapshot.data.myFollow[index].userName +
                        " " +
                        snapshot.data.myFollow[index].userSurname),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
  Widget getAppBarUI() {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, left: 18, right: 18),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Kendi Tarifini',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                    letterSpacing: 0.2,
                    color: DesignCourseAppTheme.grey,
                  ),
                ),
                Text(
                  'Kendin Yap',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                    letterSpacing: 0.27,
                    color: DesignCourseAppTheme.darkerText,
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: 90,
            height: 70,
            child: Image.asset('assets/design_course/logo_v.png'),
          )
        ],
      ),
    );
  }
}

