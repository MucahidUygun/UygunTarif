import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:taslak1/login_screen.dart';

class SplashPage extends StatefulWidget {
  SplashPage({Key key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 3)).then((value) =>
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => LoginScreen())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                child: Image.asset('assets/design_course/banner.png'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
