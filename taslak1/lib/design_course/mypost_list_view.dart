import 'package:flutter/material.dart';
import 'package:taslak1/Services/rest_api.dart';
import 'package:taslak1/design_course/models/my-post.dart';
import '../main.dart';
import 'design_course_app_theme.dart';
import 'models/category.dart';
class MyPostsListView extends StatefulWidget {
  
  const MyPostsListView({Key key, this.callBack}) : super(key: key);

  final Function callBack;  
  @override
  _MyPostsListViewState createState() => _MyPostsListViewState();
}

class _MyPostsListViewState extends State<MyPostsListView>
    
    with TickerProviderStateMixin {
  AnimationController animationController;
  Future<List<Category>> futurePost;
  @override
  void initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: FutureBuilder<MyPostList>(
        future: RestApi.getMyPosts(),
        builder: ( context,snapshot) {
          if (!snapshot.hasData) {
            return const SizedBox();
          } else {
            return GridView(
              padding: const EdgeInsets.all(8),
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.vertical,
              children: List<Widget>.generate(
                snapshot.data.myPosts.length,
                (int index) {
                  final int count = snapshot.data.myPosts.length;
                  final Animation<double> animation =
                      Tween<double>(begin: 0.0, end: 1.0).animate(
                    CurvedAnimation(
                      parent: animationController,
                      curve: Interval((1 / count) * index, 1.0,
                          curve: Curves.fastOutSlowIn),
                    ),
                  );
                  animationController.forward();
                  return MyPostListView(
                    callback: () {
                      widget.callBack(snapshot.data.myPosts[index].postId);
                    },
                    mypost: snapshot.data.myPosts[index],
                    animation: animation,
                    animationController: animationController,
                  );
                },
              ),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 32.0,
                crossAxisSpacing: 32.0,
                childAspectRatio: 0.8,
              ),
            );
          }
        },
      ),
    );
  }
}

class MyPostListView extends StatelessWidget {
  const MyPostListView(
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
                0.0, 50 * (1.0 - animation.value), 0.0),
            child: InkWell(
              splashColor: Colors.transparent,
              onTap: () {
                callback();
              },
              child: SizedBox(
                height: 50,
                child: Stack(
                  alignment: AlignmentDirectional.bottomCenter,
                  children: <Widget>[
                    Container(
                      child: Column(
                        children: <Widget>[
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                color: HexColor('#F8FAFB'),
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(16.0)),
                                // border: new Border.all(
                                //     color: DesignCourseAppTheme.notWhite),
                              ),
                              child: Column(
                                children: <Widget>[
                                  Expanded(
                                    child: Container(
                                      child: Column(
                                        children: <Widget>[
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 30, left: 16, right: 16),
                                            child: Text(
                                              mypost.postTitle,
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                fontFamily: 'Montserrat-Italic',
                                                fontWeight: FontWeight.w600,
                                                fontSize: 16,
                                                letterSpacing: 0.27,
                                                color: DesignCourseAppTheme
                                                    .darkerText,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 8,
                                                left: 16,
                                                right: 16,
                                                bottom: 8),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 28,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 28,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      child: Padding(
                        padding:
                            const EdgeInsets.only(top: 10, right: 16, left: 16),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(16.0)),
                            boxShadow: <BoxShadow>[
                              BoxShadow(
                                  color: DesignCourseAppTheme.grey
                                      .withOpacity(0.2),
                                  offset: const Offset(0.0, 0.0),
                                  blurRadius: 6.0),
                            ],
                          ),
                          child: ClipRRect(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(16.0)),
                            child: AspectRatio(
                                aspectRatio: 1.28,
                                child: Image.network(mypost.postImage)),
                          ),
                        ),
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
