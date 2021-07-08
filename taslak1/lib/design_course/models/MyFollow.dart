
class MyFollow {
  int userId;
  String userName;
  String userSurname;
  String userImage;
  int postCount;

  MyFollow(
      {this.userId,
      this.userName,
      this.userSurname,
      this.userImage,
      this.postCount});

  MyFollow.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    userName = json['user_name'];
    userSurname = json['user_surname'];
    userImage = json['user_image'];
    postCount = json['post_count'];
  }
}
class MyFollowList {
    final List<MyFollow> myFollow;
    MyFollowList({this.myFollow});
    
    factory MyFollowList.fromJson(List<dynamic> parsedJson){
      List<MyFollow> myFollowList = parsedJson.map((i) => MyFollow.fromJson(i)).toList();
      return MyFollowList(myFollow:myFollowList);
    }
  }