import 'package:flutter/material.dart';
import 'design_course_app_theme.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CourseInfoScreen extends StatefulWidget {
  final String postId;

  CourseInfoScreen({
    this.postId,
  });

  @override
  State<StatefulWidget> createState() => _CourseInfoScreenState();
}

class _CourseInfoScreenState extends State<CourseInfoScreen>
    with TickerProviderStateMixin {
  final double infoHeight = 364.0;
  AnimationController animationController;
  Animation<double> animation;
  double opacity1 = 0.0;
  double opacity2 = 0.0;
  double opacity3 = 0.0;
  @override
  void initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    animation = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent: animationController,
        curve: Interval(0, 1.0, curve: Curves.fastOutSlowIn)));
    setData();
    getPostInfo();
    super.initState();
  }

  Future<void> setData() async {
    animationController.forward();
    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    setState(() {
      opacity1 = 1.0;
    });
    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    setState(() {
      opacity2 = 1.0;
    });
    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    setState(() {
      opacity3 = 1.0;
    });
  }

  String postImage = "";
  var postTitle = "", postMaterial = "", postDesc = "", userName = "";
  Map data;
  List postData;
  Future getPostInfo() async {
    final response = await http.get(
        "https://denizhanyigit.com/uygun-tarif/post-info.php?post_id=" +
            widget.postId);
    setState(() {
      postData = json.decode(response.body);
    });
    postTitle = postData[0]["post_title"];
    postMaterial = postData[0]["post_material"];
    postDesc = postData[0]["post_desc"];
    postImage = postData[0]["post_image"];
    userName = postData[0]["user_name"];
  }

  @override
  Widget build(BuildContext context) {
    final double tempHeight = MediaQuery.of(context).size.height -
        (MediaQuery.of(context).size.width / 30) +
        104.0;
    return Container(
      color: DesignCourseAppTheme.nearlyWhite,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: <Widget>[
            Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: AspectRatio(
                    aspectRatio: 1.2,
                    child: Image.network(
                      postImage,
                      width: 400,
                      height: 400,
                    ),
                  ),
                ),
              ],
            ),
            Positioned(
              top: (MediaQuery.of(context).size.width / 1.2) - 24.0,
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                decoration: BoxDecoration(
                  color: DesignCourseAppTheme.nearlyWhite,
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(32.0),
                      topRight: Radius.circular(32.0)),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                        color: DesignCourseAppTheme.grey.withOpacity(0.2),
                        offset: const Offset(1.1, 1.1),
                        blurRadius: 10.0),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 8, right: 8),
                  child: SingleChildScrollView(
                    child: Container(
                      constraints: BoxConstraints(
                          minHeight: infoHeight,
                          maxHeight: tempHeight > infoHeight
                              ? tempHeight
                              : infoHeight),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 10.0, left: 18, right: 16),
                            child: Center(
                              child: Text(
                                postTitle,
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 22,
                                  letterSpacing: 0.27,
                                  color: DesignCourseAppTheme.darkerText,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 16, right: 16, bottom: 8, top: 16),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  userName,
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w200,
                                    fontSize: 22,
                                    letterSpacing: 0.27,
                                    color: DesignCourseAppTheme.nearlyBlue,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: AnimatedOpacity(
                              duration: const Duration(milliseconds: 500),
                              opacity: opacity2,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 16, right: 16, top: 8, bottom: 8),
                                child: Center(
                                  child: Column(
                                    children: [
                                      Text(
                                        'Malzemeler',
                                        textAlign: TextAlign.justify,
                                        style: TextStyle(
                                          fontWeight: FontWeight.w200,
                                          fontSize: 20,
                                          letterSpacing: 0.27,
                                          color: DesignCourseAppTheme.grey,
                                        ),
                                        maxLines: 3,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      Divider(
                                        height: 20,
                                        thickness: 2,
                                        indent: 10,
                                        endIndent: 10,
                                        color: Colors.cyan[200],
                                      ),
                                      Text(
                                        postMaterial,
                                        textAlign: TextAlign.justify,
                                        style: TextStyle(
                                          fontWeight: FontWeight.w200,
                                          fontSize: 10,
                                          letterSpacing: 0.27,
                                          color: DesignCourseAppTheme.grey,
                                        ),
                                        maxLines: 30,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Column(
                                        children: [
                                          Text(
                                            'Tarif Açıklaması',
                                            textAlign: TextAlign.justify,
                                            style: TextStyle(
                                              fontWeight: FontWeight.w200,
                                              fontSize: 20,
                                              letterSpacing: 0.27,
                                              color: DesignCourseAppTheme.grey,
                                            ),
                                            maxLines: 10,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          Divider(
                                            height: 20,
                                            thickness: 2,
                                            indent: 10,
                                            endIndent: 10,
                                            color: Colors.cyan[200],
                                          ),
                                          Text(
                                            postDesc,
                                            textAlign: TextAlign.justify,
                                            style: TextStyle(
                                              fontWeight: FontWeight.w200,
                                              fontSize: 14,
                                              letterSpacing: 0.27,
                                              color: DesignCourseAppTheme.grey,
                                            ),
                                            maxLines: 15,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
              child: SizedBox(
                width: AppBar().preferredSize.height,
                height: AppBar().preferredSize.height,
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius:
                        BorderRadius.circular(AppBar().preferredSize.height),
                    child: Icon(
                      Icons.arrow_back_ios,
                      color: DesignCourseAppTheme.nearlyBlack,
                    ),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
