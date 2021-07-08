class MyPost {
  final String postId;
  final String postTitle;
  final String postMaterial;
  final String postDesc;
  final String postImage;
  final String userName;
  final String userImage;

  MyPost(
    {this.postId, 
    this.postTitle, 
    this.postMaterial, 
    this.postDesc, 
    this.postImage,
    this.userName, 
    this.userImage}
    );

  factory MyPost.fromJson(Map<String, dynamic> json) {
    return MyPost(
      postId: json['post_id'].toString(),
      postTitle: json['post_title'],
      postMaterial: json['post_material'],
      postDesc: json['post_desc'],
      postImage: json['post_image'],
      userName: json['user_name'],
      userImage: json['user_img'],
    );
  }
}
class MyPostList {
  final List<MyPost> myPosts;

  MyPostList({this.myPosts});

  factory MyPostList.fromJson(List<dynamic> parsedJson) {
    List<MyPost> myPosts = parsedJson.map((i) => MyPost.fromJson(i)).toList();
    return MyPostList(myPosts: myPosts);
  }
}