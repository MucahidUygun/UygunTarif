import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taslak1/design_course/follow.dart';
import 'package:taslak1/design_course/home_design_course.dart';
import 'package:taslak1/design_course/profil.dart';
import 'package:taslak1/design_course/tariflerim.dart';
import 'package:taslak1/login_screen.dart';
import '../create_post.dart';

class YanMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 20.0),
      child: Drawer(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              child: Image.asset("assets/design_course/banner.png"),
            ),
            Expanded(
              child: ListView(
                children: <Widget>[
                  ListTile(
                    leading: Icon(Icons.home_outlined),
                    title: Text('AnaSayfa'),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DesignCourseHomeScreen()));
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.food_bank),
                    title: Text("Tarif Oluştur"),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CreatePostScreen()));
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.format_align_right_outlined),
                    title: Text("Tariflerim"),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => TariflerimScreen()));
                    },
                  ),
                   ListTile(
                    leading: Icon(Icons.create_new_folder_outlined),
                    title: Text("Takip Ettiklerim"),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(context, MaterialPageRoute(builder: (context) => FollowPage()));
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.design_services_outlined),
                    title: Text("Profilim"),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ProfilPage()));
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.exit_to_app),
                    title: Text("Çıkış Yap"),
                    onTap: () async {
                      SharedPreferences sessions =
                          await SharedPreferences.getInstance();
                      sessions.clear();
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LoginScreen()),
                          (route) => false);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
