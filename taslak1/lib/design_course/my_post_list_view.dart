import 'package:flutter/material.dart';
import 'package:taslak1/Services/rest_api.dart';
import '../main.dart';
import 'design_course_app_theme.dart';
import 'models/my-post.dart';

class MyPostListView extends StatefulWidget {
  const MyPostListView({Key key, this.callBack}) : super(key: key);

  final Function callBack;
  @override
  _MyPostListViewState createState() => _MyPostListViewState();
}

class _MyPostListViewState extends State<MyPostListView>
    with TickerProviderStateMixin {
  AnimationController animationController;

  @override
  void initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Container(
        height: 134,
        width: double.infinity,
        child: FutureBuilder<MyPostList>(
          future: RestApi.getMyPosts(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const SizedBox();
            } else {
              return ListView.builder(
                padding:
                    const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
                itemCount: snapshot.data.myPosts.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, int index) {
                  final int count = snapshot.data.myPosts.length > 10
                      ? 10
                      : snapshot.data.myPosts.length;
                  final Animation<double> animation =
                      Tween<double>(begin: 0.0, end: 1.0).animate(
                          CurvedAnimation(
                              parent: animationController,
                              curve: Interval((1 / count) * index, 1.0,
                                  curve: Curves.fastOutSlowIn)));
                  animationController.forward();

                  return CategoryView(
                      mypost: snapshot.data.myPosts[index],
                      animation: animation,
                      animationController: animationController,
                      callback: () =>
                          widget.callBack(snapshot.data.myPosts[index].postId));
                },
              );
            }
          },
        ),
      ),
    );
  }
}

class CategoryView extends StatelessWidget {
  const CategoryView(
      {Key key,
      this.mypost,
      this.animationController,
      this.animation,
      this.callback})
      : super(key: key);

  final VoidCallback callback;
  final MyPost mypost;
  final AnimationController animationController;
  final Animation<dynamic> animation;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController,
      builder: (BuildContext context, Widget child) {
        return FadeTransition(
          opacity: animation,
          child: Transform(
            transform: Matrix4.translationValues(
                100 * (1.0 - animation.value), 0.0, 0.0),
            child: InkWell(
              splashColor: Colors.transparent,
              onTap: () => callback(),
              child: SizedBox(
                width: 280,
                child: Stack(
                  children: <Widget>[
                    Container(
                      child: Row(
                        children: <Widget>[
                          const SizedBox(
                            width: 48,
                          ),
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                color: HexColor('#F8FAFB'),
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(16.0)),
                              ),
                              child: Row(
                                children: <Widget>[
                                  const SizedBox(
                                    width: 48 + 24.0,
                                  ),
                                  Expanded(
                                    child: Container(
                                      child: Column(
                                        children: <Widget>[
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 16),
                                          ),
                                          const Expanded(
                                            child: SizedBox(),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                right: 16, bottom: 8),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: <Widget>[
                                                SizedBox(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.35,
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.04,
                                                  child: Text(
                                                    '${mypost.postTitle}',
                                                    textAlign: TextAlign.left,
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w200,
                                                      fontSize: 12,
                                                      letterSpacing: 0.27,
                                                      color:
                                                          DesignCourseAppTheme
                                                              .grey,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 16, right: 8),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                SizedBox(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.25,
                                                  child: AspectRatio(
                                                    aspectRatio: 1.7,
                                                    child: Image.network(
                                                      mypost.postImage,
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                              0.25,
                                                      height:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                              0.25,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      child: Row(
                        children: <Widget>[
                          ClipRRect(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(16.0)),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
