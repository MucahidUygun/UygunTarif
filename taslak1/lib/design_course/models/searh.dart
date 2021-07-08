class Search {
  bool isFollow;
  int userId;
  String userName;
  String userSurname;
  String userEmail;
  String userImage;
  String postCount;

  Search(
      {this.isFollow,
      this.userId,
      this.userName,
      this.userSurname,
      this.userEmail,
      this.userImage,
      this.postCount});


  factory Search.fromJson(Map<String, dynamic> json) {
    return Search(
      isFollow: json['is_follow'],
      userId: json['user_id'],
      userName: json['user_name'].toString(),
      userSurname: json['user_surname'],
      userEmail: json['user_email'],
      userImage: json['user_image'],
      postCount: json['post_count'].toString(),
    );
  }
}

class SearchList {
  final List<Search> searchs;

  SearchList({this.searchs});

  factory SearchList.fromJson(List<dynamic> parsedJson) {
    List<Search> searchList = parsedJson.map((i) => Search.fromJson(i)).toList();
    return SearchList(searchs: searchList);
  }
}