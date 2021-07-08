import 'package:flutter/material.dart';
import 'package:taslak1/custom_drawer/yanmenu.dart';
import 'package:taslak1/design_course/mypost_list_view.dart';
import 'course_info_screen.dart';
import 'design_course_app_theme.dart';

class TariflerimScreen extends StatefulWidget {
  @override
  _TariflerimScreenState createState() => _TariflerimScreenState();
}

class _TariflerimScreenState extends State<TariflerimScreen> {

  @override
  Widget build(BuildContext context) {
    return Container(
      color: DesignCourseAppTheme.nearlyWhite,
      child: Scaffold(
        appBar: AppBar(
        title: Text("Uygun Tarif"),
        // centerTitle: true,
      ),
        drawer: YanMenu(),
        backgroundColor: Colors.transparent,
        body: Column(
          children: <Widget>[
            getAppBarUI(),
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  child: Column(
                    children: <Widget>[
                    //  getSearchBarUI(),
                     Flexible(
                        child: getPopularCourseUI(),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget getPopularCourseUI() {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, left: 18, right: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Flexible(
            child: MyPostsListView(
              callBack: (String postId) {
                moveTo(postId);
              },
            ),
          )
        ],
      ),
    );
  }

  void moveTo(String postId) {
    Navigator.push<dynamic>(
      context,
      MaterialPageRoute<dynamic>(
        builder: (BuildContext context) => CourseInfoScreen(postId : postId),
      ),
    );
  }
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
                  'Benim',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                    letterSpacing: 0.2,
                    color: DesignCourseAppTheme.grey,
                  ),
                ),
                Text(
                  'Tariflerim',
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

