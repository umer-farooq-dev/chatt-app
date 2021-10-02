import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:telegramchatapp/Widgets/ProgressWidget.dart';
import 'package:telegramchatapp/main.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Settings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {}
}

class SettingsScreen extends StatefulWidget {
  @override
  State createState() => SettingsScreenState();
}

class SettingsScreenState extends State<SettingsScreen> {
  TextEditingController nickNameTextEditingController;
  TextEditingController aboutMeTextEditingController;

  SharedPreferences preferences;
  String id= "";
  String nickname= "";
  String aboutMe= "";
  String photoUrl= "";
  File imageFileAvatar;
  bool isLoading = false;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    readDataFromLocal();
  }

  void readDataFromLocal () async{
    preferences = await SharedPreferences.getInstance();
    id = preferences.getString("id");
    nickname = preferences.getString("nickname");
    aboutMe = preferences.getString("aboutMe");
    photoUrl = preferences.getString("photoUrl");

    nickNameTextEditingController =TextEditingController(text: nickname);
    aboutMeTextEditingController =TextEditingController(text: aboutMe);

    setState(() {

    });
    Future getImage() async {
      File newImageFile = await ImagePicker.pickImage(source: ImageSource.gallery);

      if(newImageFile!= null){
        setState(() {
          this.imageFileAvatar = newImageFile;
          isLoading= true;
        });

      }
    }
  }
  Widget build(BuildContext context) {

    return Stack(
      children: <Widget>[
        SingleChildScrollView(
          child: Column(
            children: <Widget>[
             // Profile image - Avatar
      Container(
        child: Center(
          child: Stack(
            children: <Widget>[
              (imageFileAvatar ==null)
              ? (photoUrl !="")
                  ? Material(
                //display alreday existing old image file
                child: CachedNetworkImage(
                  placeholder: (context, url) => Container(
                    child: CircularProgressIndicator(
                      strokeWidth: 2.0,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.lightBlueAccent),
                    ),
                    width: 200.0,
                    height: 200.0,
                    padding: EdgeInsets.all(20.0),
                  ),
                  imageUrl: photoUrl,
                  width: 200.0,
                  height: 200.0,
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.all(Radius.circular(125.0)),
                clipBehavior: Clip.hardEdge,
              )
              : Icon:(Icons.account_circle, size: 90.0, color: Colors.grey,)
              : Material(
                //displa the new image upfate here
                child: Image.file(
                  imageFileAvatar,
                  with: 200.0,
                  height:200.0,
                  fit: BoxFit.cover,
                ),




              ),

            ],
          ),
        ),

    ),
            ],
          ),
        ),
      ],
    );
  }
}
