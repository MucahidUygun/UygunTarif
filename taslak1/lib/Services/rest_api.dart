import 'package:shared_preferences/shared_preferences.dart';
import 'package:taslak1/design_course/models/category.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:taslak1/design_course/models/my-post.dart';

class RestApi {
  static Future<CategoryList> fetchPosts() async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.getString('user_id') != null) {
      final response = await http.get(
          "https://denizhanyigit.com/uygun-tarif/get-post.php?user_id=" +
              prefs.getString("user_id"));
      if (response.statusCode == 200) {
        final data = utf8.decode(response.bodyBytes);
        final jsonResponse = json.decode(data);
        return CategoryList.fromJson(jsonResponse);
      } else {
        return null;
      }
    }
    return null ;
  }

  static Future<MyPostList> getMyPosts() async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.getString('user_id') != null) {
      final response = await http.get(
          "https://denizhanyigit.com/uygun-tarif/my-posts.php?user_id=" +
              prefs.getString("user_id"));
      if (response.statusCode == 200) {
      final data = utf8.decode(response.bodyBytes);
      final jsonResponse = json.decode(data);
        return MyPostList.fromJson(jsonResponse);
      } else {
        return null;
      }
    } else {
      return null;
    }
  }
}
