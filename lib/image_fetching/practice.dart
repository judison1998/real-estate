import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:real_estate_uganda/pages/home1.dart';
import 'package:real_estate_uganda/pages/signUp.dart';
import 'package:get/get.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return new FutureBuilder<String>(
      future: loadImage(),
      builder: (BuildContext context, AsyncSnapshot<String> image) {
        if (image.hasData) {
          return Image.network(image.data.toString()); // image is ready
          //return Text('data');
        } else {
          return new Container(); // placeholder
        }
      },
    );
  }
}

Future<String> loadImage() async {
  //current user id
  final _userID = FirebaseAuth.instance.currentUser!.uid;

  //collect the image name
  DocumentSnapshot variable = await FirebaseFirestore.instance
      .collection('data_user')
      .doc('user')
      .collection('personal_data')
      .doc(_userID)
      .get();

  //a list of images names (i need only one)
  var _file_name = variable['path_profile_image'];

  //select the image url
  Reference ref = FirebaseStorage.instance
      .ref()
      .child("images/user/profile_images/${_userID}")
      .child(_file_name[0]);

  //get image url from firebase storage
  var url = await ref.getDownloadURL();
  print('url: ' + url);
  return url;
}
