import 'dart:io';
import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'app_theme.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'custom_drawer/yanmenu.dart';
import 'design_course/tariflerim.dart';

class CreatePostScreen extends StatefulWidget {
  @override
  _CreatePostScreenState createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  File imageFile;
  final TextEditingController _postTitleController = TextEditingController();
  final TextEditingController _postDescController = TextEditingController();
  final TextEditingController _postMaterialController = TextEditingController();

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

  Future<String> createPost() async {
    String uploadurl = "https://denizhanyigit.com/uygun-tarif/create-post.php";
    String baseimage="";
    if(imageFile!=null){
      List<int> imageBytes = imageFile.readAsBytesSync();
      baseimage = base64Encode(imageBytes);
    }  
    SharedPreferences sessions = await SharedPreferences.getInstance();
    var response = await http.post(uploadurl, body: {
      'user_id': sessions.getString("user_id"),
      'image': baseimage,
      'post_title': _postTitleController.text.toString(),
      'post_material': _postMaterialController.text.toString(),
      'post_desc': _postDescController.text.toString()
    });
    var userMap = jsonDecode(response.body);
    return userMap["status"];
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

  @override
  void initState() {
    super.initState();
  }

  Widget _decideImageView() {
    if (imageFile == null) {
      return Image.asset(
        'assets/design_course/interFace1.png',
        height: MediaQuery.of(context).size.height * 0.25,
      );
    } else
      return Image.file(
        imageFile,
        height: MediaQuery.of(context).size.height * 0.25,
      );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppTheme.nearlyWhite,
      child: SafeArea(
        top: false,
        child: Scaffold(
          appBar: AppBar(
            title: Text("Uygun Tarif"),
          ),
          drawer: YanMenu(),
          backgroundColor: AppTheme.nearlyWhite,
          body: Column(
            children: [
              SingleChildScrollView(
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.85,
                  child: Column(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(
                            top: MediaQuery.of(context).padding.top,
                            left: 16,
                            right: 16),
                        child: _decideImageView(),
                      ),
                      Container(
                        padding: const EdgeInsets.only(top: 8),
                        child: Text(
                          'Senin Tarifin',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Flexible(child: _postTitle()),
                      Flexible(child: _postMaterial()),
                      Flexible(child: _postDesc()),
                      Center(
                          child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            IconButton(
                              color: Colors.blue,
                              onPressed: () {
                                _showChoiceDialog(context);
                              },
                              icon: Icon(Icons.camera_alt_sharp),
                            ),
                            FlatButton(
                              color: Colors.blue,
                              onPressed: () async {
                                final String cevap = await createPost();
                                if (cevap == "true") {
                                  Fluttertoast.showToast(
                                      msg: "Tarifiniz başarıyla kaydedildi.",
                                      toastLength: Toast.LENGTH_LONG,
                                      timeInSecForIosWeb: 3);
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              TariflerimScreen()));
                                } else if (cevap == "false") {
                                  Fluttertoast.showToast(
                                      msg: "İşlem başarısız.",
                                      toastLength: Toast.LENGTH_LONG,
                                      timeInSecForIosWeb: 3);
                                } else if (cevap == "required") {
                                  Fluttertoast.showToast(
                                      msg: "Tüm alanları doldurmalısınız.",
                                      toastLength: Toast.LENGTH_LONG,
                                      timeInSecForIosWeb: 3);
                                }
                              },
                              child: Text('Gönder'),
                            ),
                          ],
                        ),
                      )),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _postTitle() {
    return Padding(
      padding: const EdgeInsets.only(top: 16, left: 32, right: 32),
      child: Container(
        decoration: BoxDecoration(
          color: AppTheme.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: Colors.grey.withOpacity(0.8),
                offset: const Offset(4, 4),
                blurRadius: 8),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(25),
          child: Container(
            padding: const EdgeInsets.all(4.0),
            constraints: const BoxConstraints(minHeight: 80, maxHeight: 160),
            color: AppTheme.white,
            child: SingleChildScrollView(
              padding:
                  const EdgeInsets.only(left: 10, right: 10, top: 0, bottom: 0),
              child: TextField(
                controller: _postTitleController,
                maxLines: null,
                onChanged: (String txt) {},
                style: TextStyle(
                  fontFamily: AppTheme.fontName,
                  fontSize: 16,
                  color: AppTheme.dark_grey,
                ),
                cursorColor: Colors.blue,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Tarif Başlığını giriniz'),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _postDesc() {
    return Padding(
      padding: const EdgeInsets.only(top: 16, left: 32, right: 32),
      child: Container(
        decoration: BoxDecoration(
          color: AppTheme.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: Colors.grey.withOpacity(0.8),
                offset: const Offset(4, 4),
                blurRadius: 8),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(25),
          child: Container(
            padding: const EdgeInsets.all(4.0),
            constraints: const BoxConstraints(minHeight: 80, maxHeight: 160),
            color: AppTheme.white,
            child: SingleChildScrollView(
              padding:
                  const EdgeInsets.only(left: 10, right: 10, top: 0, bottom: 0),
              child: TextField(
                controller: _postDescController,
                maxLines: null,
                onChanged: (String txt) {},
                style: TextStyle(
                  fontFamily: AppTheme.fontName,
                  fontSize: 16,
                  color: AppTheme.dark_grey,
                ),
                cursorColor: Colors.blue,
                decoration: InputDecoration(
                    border: InputBorder.none, hintText: 'Tarifinizi giriniz'),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _postMaterial() {
    return Padding(
      padding: const EdgeInsets.only(top: 16, left: 32, right: 32),
      child: Container(
        decoration: BoxDecoration(
          color: AppTheme.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: Colors.grey.withOpacity(0.8),
                offset: const Offset(4, 4),
                blurRadius: 8),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(25),
          child: Container(
            padding: const EdgeInsets.all(4.0),
            constraints: const BoxConstraints(minHeight: 80, maxHeight: 160),
            color: AppTheme.white,
            child: SingleChildScrollView(
              padding:
                  const EdgeInsets.only(left: 10, right: 10, top: 0, bottom: 0),
              child: TextField(
                controller: _postMaterialController,
                maxLines: null,
                onChanged: (String txt) {},
                style: TextStyle(
                  fontFamily: AppTheme.fontName,
                  fontSize: 16,
                  color: AppTheme.dark_grey,
                ),
                cursorColor: Colors.blue,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Tarif malzemelerini giriniz'),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
