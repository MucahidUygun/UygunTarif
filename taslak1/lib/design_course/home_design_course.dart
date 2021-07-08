import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taslak1/Services/MyFollowApi.dart';
import 'package:taslak1/Services/searh_api.dart';
import 'package:taslak1/custom_drawer/yanmenu.dart';
import 'package:taslak1/design_course/my_post_list_view.dart';
import 'package:taslak1/login_screen.dart';
import '../main.dart';
import 'course_info_screen.dart';
import 'design_course_app_theme.dart';
import 'popular_course_list_view.dart';

//////////////////////////////////Search tipinde veri gönder consta o veriyi parçala class içinde\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
class DesignCourseHomeScreen extends StatefulWidget {
  @override
  _DesignCourseHomeScreenState createState() => _DesignCourseHomeScreenState();
}

class _DesignCourseHomeScreenState extends State<DesignCourseHomeScreen> {
  List<String> userName = [];
  final List<String> postCount = [];
  final List<String> userImage = [];
  final List<int> userId = [];
  String followStatus;
  final List<bool> isFollow = [];

  _MySearchDelegate _delegate;

  getWords() async {
    final result = await SearchApi.fetchSearch();

    result.searchs.forEach((result) {
      userName.add(result.userName);
    });
    result.searchs.forEach((result) {
      postCount.add(result.postCount);
    });
    result.searchs.forEach((result) {
      userImage.add(result.userImage);
    });
    result.searchs.forEach((result) {
      userId.add(result.userId);
    });
    result.searchs.forEach((result) {
      isFollow.add(result.isFollow);
    });
  }

  Future session(context) async {
    SharedPreferences sessions = await SharedPreferences.getInstance();
    if (sessions.getString('user_id') == null) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    session(context);
    getWords();
    _delegate = _MySearchDelegate(
        userName, userImage, postCount, userId, followStatus, isFollow);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: DesignCourseAppTheme.nearlyWhite,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Uygun Tarif'),
          actions: <Widget>[
            IconButton(
              tooltip: 'Search',
              icon: const Icon(Icons.search),
              onPressed: () async {
                final String selected = await showSearch<String>(
                  context: context,
                  delegate: _delegate,
                );
                if (selected != null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Geçmiş Temizlendi'),
                    ),
                  );
                }
              },
            ),
          ],
        ),
        backgroundColor: Colors.transparent,
        body: Column(
          children: <Widget>[
            getAppBarUI(),
            SizedBox(
              height: MediaQuery.of(context).padding.top,
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  child: Column(
                    children: <Widget>[
                      getCategoryUI(),
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
        drawer: YanMenu(),
      ),
    );
  }

  Widget getCategoryUI() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 8.0, left: 18, right: 16),
          child: Text(
            'Tariflerim',
            textAlign: TextAlign.left,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 22,
              letterSpacing: 0.27,
              color: DesignCourseAppTheme.darkerText,
            ),
          ),
        ),
        MyPostListView(
          callBack: (String postId) {
            moveTo(postId);
          },
        ),
      ],
    );
  }

  Widget getPopularCourseUI() {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, left: 18, right: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Ana Akış',
            textAlign: TextAlign.left,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 22,
              letterSpacing: 0.27,
              color: DesignCourseAppTheme.darkerText,
            ),
          ),
          Flexible(
            child: PopularCourseListView(
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
        builder: (BuildContext context) => CourseInfoScreen(postId: postId),
      ),
    );
  }

  Widget getSearchBarUI() {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, left: 18),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width * 0.75,
            height: 64,
            child: Padding(
              padding: const EdgeInsets.only(top: 8, bottom: 8),
              child: Container(
                decoration: BoxDecoration(
                  color: HexColor('#F8FAFB'),
                  borderRadius: const BorderRadius.only(
                    bottomRight: Radius.circular(13.0),
                    bottomLeft: Radius.circular(13.0),
                    topLeft: Radius.circular(13.0),
                    topRight: Radius.circular(13.0),
                  ),
                ),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.only(left: 16, right: 16),
                        child: TextFormField(
                          style: TextStyle(
                            fontFamily: 'WorkSans',
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: DesignCourseAppTheme.nearlyBlue,
                          ),
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            labelText: 'Search for course',
                            border: InputBorder.none,
                            helperStyle: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: HexColor('#B9BABC'),
                            ),
                            labelStyle: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                              letterSpacing: 0.2,
                              color: HexColor('#B9BABC'),
                            ),
                          ),
                          onEditingComplete: () {},
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 60,
                      height: 60,
                      child: Icon(Icons.search, color: HexColor('#B9BABC')),
                    )
                  ],
                ),
              ),
            ),
          ),
          const Expanded(
            child: SizedBox(),
          )
        ],
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

class _MySearchDelegate extends SearchDelegate<String> {
  final List<String> _words;
  final List<String> _history;
  final List<String> postCount;
  final List<String> userImage;
  final List<int> userId;
  final String followStatus;
  final List<bool> isFollow;

  _MySearchDelegate(
      List<String> words,
      List<String> userImage,
      List<String> postCount,
      List<int> userId,
      String followStatus,
      List<bool> isFollow)
      : _words = words,
        _history = <String>[],
        this.isFollow = isFollow,
        this.followStatus = followStatus,
        this.userImage = userImage,
        this.userId = userId,
        this.postCount = postCount;

  // Leading icon in search bar.
  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      tooltip: 'Back',
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        // SearchDelegate.close() can return vlaues, similar to Navigator.pop().
        this.close(context, null);
      },
    );
  }

  // Widget of result page.
  @override
  Widget buildResults(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const Text('Seçilen Kişi:'),
            GestureDetector(
              onTap: () {
                // Returns this.query as result to previous screen, c.f.
                // `showSearch()` above.
                this.close(context, this.query);
              },
              child: Text(
                this.query,
                style: Theme.of(context)
                    .textTheme
                    .headline4
                    .copyWith(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Suggestions list while typing (this.query).
  @override
  Widget buildSuggestions(BuildContext context) {
    final Iterable<String> suggestions = this.query.isEmpty
        ? _history
        : _words.where((word) => word.startsWith(query));
    return _SuggestionList(
      isFollow: isFollow,
      followStatus: this.followStatus,
      userId: this.userId,
      userImage: userImage.toList(),
      postCount: postCount,
      words: _words,
      query: this.query,
      suggestions: suggestions.toList(),
      onSelected: (String suggestion) {
        this.query = suggestion;
        this._history.insert(0, suggestion);
        showResults(context);
      },
    );
  }

  // Action buttons at the right of search bar.
  @override
  List<Widget> buildActions(BuildContext context) {
    return <Widget>[
      if (_history.isNotEmpty && query.isEmpty)
        IconButton(
          tooltip: 'Clear History',
          icon: const Icon(Icons.cleaning_services),
          onPressed: () {
            this._history.clear();
            Navigator.of(context).pop('Temizlendi');
          },
        ),
      if (query.isNotEmpty)
        IconButton(
          tooltip: 'Clear',
          icon: const Icon(Icons.clear),
          onPressed: () {
            query = '';
            showSuggestions(context);
          },
        )
    ];
  }
}

class _SuggestionList extends StatelessWidget {
  const _SuggestionList(
      {this.isFollow,
      this.followStatus,
      this.suggestions,
      this.query,
      this.onSelected,
      this.postCount,
      this.userImage,
      this.words,
      this.userId});
  final List<String> words;
  final List<String> suggestions;
  final String query;
  final ValueChanged<String> onSelected;
  final List<String> postCount;
  final List<String> userImage;
  final List<int> userId;
  final String followStatus;
  final List<bool> isFollow;
  follow(String userId) async {
    String follow_status = followStatus;
    final result = await SearchApi.addFollow(userId);
    follow_status = result;
    return follow_status;
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme.subtitle1;
    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (BuildContext context, int i) {
        final String suggestion = suggestions[i];
        int count = 0;
        for (var i = 0; i < words.length; i++) {
          if (words[i] == suggestion) {
            count = i;
          }
        }
        return ListTile(
          trailing: isFollow[count] == true
              ? Icon(Icons.check_box_sharp, color: Colors.green)
              : Icon(Icons.check_box_outline_blank_sharp),
          subtitle: Text('Paylaşım Sayısı:' + postCount[count]), //Post Sayısı
          leading: query.isNotEmpty
              ? CircleAvatar(
                  radius: 20.0,
                  backgroundImage:
                      NetworkImage(userImage[count]), //kullanıcı fotoğrafı
                  backgroundColor: Colors.transparent,
                )
              : const Icon(Icons.history), //
          title: RichText(
            text: TextSpan(
              text: suggestion.substring(
                  0, query.length), //Yazılan Harfleri Alıyor
              style: textTheme.copyWith(fontWeight: FontWeight.bold),
              children: <TextSpan>[
                TextSpan(
                  text: suggestion.substring(query.length), //Devamını getiriyor
                  style: textTheme,
                ),
              ],
            ),
          ),
          onTap: () async {
            onSelected(suggestion);
            await follow(userId[count].toString());
            if (isFollow[count]==true) {
              isFollow[count]=false;
            }
            else isFollow[count]=true;
          },
        );
      },
    );
  }
}
