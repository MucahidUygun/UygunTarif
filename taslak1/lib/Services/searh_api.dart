import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:taslak1/design_course/models/searh.dart';

class SearchApi {
  static Future<SearchList> fetchSearch() async {
    final prefs = await SharedPreferences.getInstance();
     String userId = '0';
    if(prefs.getString("user_id")!=null){
      userId=prefs.getString("user_id");
    }
    final response = await http.get(
        "https://denizhanyigit.com/uygun-tarif/search.php?user_id=" +
            userId);
    if (response.statusCode == 200) {
      final data = utf8.decode(response.bodyBytes);
      final jsonResponse = json.decode(data);
      return SearchList.fromJson(jsonResponse);
    } else {
      return null;
    }
  }
  static Future<String> addFollow(String userId) async {
    final prefs = await SharedPreferences.getInstance();
    final response = await http.get(
        "https://denizhanyigit.com/uygun-tarif/add-follow.php?user_id=" +
            userId + "&follow_user_id=" + prefs.getString('user_id'));
        final jsonResponse = json.decode(response.body);
        return jsonResponse['status'];
  }
}

