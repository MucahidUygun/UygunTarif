class Category {
  final String postId;
  final String postTitle;
  final String postMaterial;
  final String postDesc;
  final String postImage;
  final String userName;
  final String userImage;

  Category(
    {this.userImage,
    this.userName,
    this.postId, 
    this.postTitle, 
    this.postMaterial, 
    this.postDesc, 
    this.postImage}
    );

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      userName: json['user_name'],
      userImage: json['user_img'],
      postId: json['post_id'].toString(),
      postTitle: json['post_title'],
      postMaterial: json['post_material'],
      postDesc: json['post_desc'],
      postImage: json['post_image']
    );
  }
}
class CategoryList {
  final List<Category> categories;

  CategoryList({this.categories});

  factory CategoryList.fromJson(List<dynamic> parsedJson) {
    List<Category> categories = parsedJson.map((i) => Category.fromJson(i)).toList();
    return CategoryList(categories: categories);
  }
}