//import 'dart:html';
//api key ==AIzaSyBPsPho48B024L_RqiR9Uv03drdNfQdCq4
import 'package:flutter/material.dart';
import 'package:real_estate_uganda/maps/location_controller.dart';
import 'package:real_estate_uganda/pages/firestore_project.dart';
import 'package:real_estate_uganda/pages/payment.dart';
import 'package:real_estate_uganda/pages/sell.dart';
import 'package:real_estate_uganda/pages/start_page.dart';
import 'package:real_estate_uganda/widgets/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      // options: FirebaseOptions(
      //   apiKey: "AIzaSyB28o_Hpq2NrMVOuLAKgsAXlRligDGorfw",
      //   appId: "1:1007882924775:web:b5e542d2af8a4a1935a842",
      //   messagingSenderId: "1007882924775",
      //   projectId: "realestate-5d246",
      // ),
      );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Get.put(LocationController());
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'REAL ESTATES',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Start(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    super.key,
  });

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('RealEstates'),
        centerTitle: true,
        backgroundColor: AppColors.maincolor,
      ),

      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
