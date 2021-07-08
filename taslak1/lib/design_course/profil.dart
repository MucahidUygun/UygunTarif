import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taslak1/custom_drawer/yanmenu.dart';
import '../constants.dart';

class ProfilPage extends StatefulWidget {
  @override
  _ProfilPageState createState() => _ProfilPageState();
}

class _ProfilPageState extends State<ProfilPage> {
  File imageFile;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _surnameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  _openGallery(BuildContext context) async {
    var picture = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      imageFile = picture;
    });
    Navigator.of(context).pop();
  }

  _openCamera(BuildContext context) async {
    var picture = await ImagePicker.pickImage(source: ImageSource.camera);
    setState(() {
      imageFile = picture;
    });
    Navigator.of(context).pop();
  }

  var userName, userSurname, userEmail;
  Map data;
  List userData;
  String baseimage="";
  Future getUserInfo() async {
    SharedPreferences sessions = await SharedPreferences.getInstance();
    final response = await http.get(
        "https://denizhanyigit.com/uygun-tarif/user-info.php?user_id=" +
            sessions.getString('user_id'));
    setState(() {
      userData = json.decode(response.body);
      userName = userData[0]["user_name"];
      userSurname = userData[0]["user_surname"];
      userEmail = userData[0]["user_email"];
      _nameController.text = userName;
      _surnameController.text = userSurname;
      _emailController.text = userEmail;
    });
  }

  Future userEdit(String userName, String userSurname, String email,
    String password) async {
    if(imageFile!=null){
      List<int> imageBytes = imageFile.readAsBytesSync();
      baseimage = base64Encode(imageBytes);
    }  
    
    SharedPreferences sessions = await SharedPreferences.getInstance();
    final String apiUrl = "https://denizhanyigit.com/uygun-tarif/user-edit.php";
    final response = await http.post(apiUrl, body: {
      "user_id": sessions.getString("user_id"),
      "user_name": userName,
      "user_surname": userSurname,
      "user_email": email,
      "user_password": password,
      'user_image': baseimage
    });
    var userMap = jsonDecode(response.body);
    return userMap["status"];
  }

  void initState() {
    getUserInfo();
    super.initState();
  }

  Future<void> _showChoiceDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Seçim Yapınız!'),
            content: SingleChildScrollView(
              child: ListBody(
                children: [
                  GestureDetector(
                    child: Text("Gallery"),
                    onTap: () {
                      _openGallery(context);
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                  ),
                  GestureDetector(
                    child: Text("Camera"),
                    onTap: () {
                      _openCamera(context);
                    },
                  )
                ],
              ),
            ),
          );
        });
  }
  //bool _rememberMe = false;

  Widget _buildEmailTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Email',
          style: kLabelStyle,
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextField(
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.email,
                color: Colors.white,
              ),
              hintText: 'Lütfen email adresinizi giriniz.',
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildNameTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'İsim',
          style: kLabelStyle,
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextField(
            controller: _nameController,
            keyboardType: TextInputType.emailAddress,
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.email,
                color: Colors.white,
              ),
              hintText: 'Lütfen isminizi giriniz.',
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSurnameTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Soyisim',
          style: kLabelStyle,
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextField(
            controller: _surnameController,
            keyboardType: TextInputType.emailAddress,
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.email,
                color: Colors.white,
              ),
              hintText: 'Lütfen soyisminizi giriniz.',
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPasswordTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Şifre',
          style: kLabelStyle,
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextField(
            controller: _passwordController,
            obscureText: true,
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.lock,
                color: Colors.white,
              ),
              hintText: 'Lütfen şifrenizi giriniz.',
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildRegisterBtn() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25.0),
      width: double.infinity,
      child: RaisedButton(
        elevation: 5.0,
        onPressed: () async {
          final String name = _nameController.text.toString();
          final String surname = _surnameController.text.toString();
          final String email = _emailController.text.toString();
          final String password = _passwordController.text.toString();
          final cevap = await userEdit(name, surname, email, password);
          if (cevap == "true") {
            Fluttertoast.showToast(
                msg: "Profil bilgileriniz güncellenmiştir.",
                toastLength: Toast.LENGTH_LONG,
                timeInSecForIosWeb: 3);
          } else if (cevap == "required") {
            Fluttertoast.showToast(
                msg: "Lütfen boş alanları doldurunuz.",
                toastLength: Toast.LENGTH_LONG,
                timeInSecForIosWeb: 3);
          } else if (cevap == "false") {
            Fluttertoast.showToast(
                msg: "Güncelleme işlemi başarısız.",
                toastLength: Toast.LENGTH_LONG,
                timeInSecForIosWeb: 3);
          }
        },
        padding: EdgeInsets.all(15.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        color: Colors.white,
        child: Text(
          'Güncelleyiniz',
          style: TextStyle(
            color: Color(0xFF527DAA),
            letterSpacing: 1.5,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'OpenSans',
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Güncelleme',
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'OpenSans',
            fontSize: 30.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Color(0xFF6C6867),
      ),
      drawer: YanMenu(),
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Stack(
            children: <Widget>[
              Container(
                height: double.infinity,
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0xFF6C6867),
                      Color(0xFF555352),
                      Color(0xFF444241),
                      Color(0xFF32302F),
                    ],
                    stops: [0.1, 0.4, 0.7, 0.9],
                  ),
                ),
              ),
              Container(
                height: double.infinity,
                child: SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  padding: EdgeInsets.symmetric(
                    horizontal: 30.0,
                    vertical: 90.0,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(height: 10.0),
                      _buildNameTF(),
                      SizedBox(height: 10.0),
                      _buildSurnameTF(),
                      SizedBox(height: 10.0),
                      _buildEmailTF(),
                      SizedBox(
                        height: 10.0,
                      ),
                      _buildPasswordTF(),
                      SizedBox(
                        height: 20.0,
                      ),
                      IconButton(
                        icon: Icon(Icons.camera_alt_sharp),
                        iconSize: 35.0,
                        color: Colors.grey[400],
                        onPressed: () {
                          _showChoiceDialog(context);
                        },
                      ),
                      _buildRegisterBtn(),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
