import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:taslak1/design_course/models/MyFollow.dart';
import 'dart:convert';

class MyFollowApi {
  static Future<MyFollowList> fetchFollowList() async {
    final prefs = await SharedPreferences.getInstance();
    final response = await http.get(
        "https://denizhanyigit.com/uygun-tarif/my-follow.php?user_id=" +
            prefs.getString('user_id'));
    if (response.statusCode == 200) {
      final data = utf8.decode(response.bodyBytes);
      final jsonResponse = json.decode(data);
      return MyFollowList.fromJson(jsonResponse);
    } else {
      return null;
    }
  }
}

