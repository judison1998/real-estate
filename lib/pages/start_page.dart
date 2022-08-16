//import 'dart:js';

import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:real_estate_uganda/maps/map_screen.dart';
import 'package:real_estate_uganda/pages/login.dart';
import 'package:real_estate_uganda/pages/signUp.dart';
import 'package:get/get.dart';
import 'package:real_estate_uganda/widgets/big_text.dart';
import 'package:real_estate_uganda/widgets/dimensions.dart';
import 'package:real_estate_uganda/widgets/colors.dart';

class Start extends StatefulWidget {
  const Start({Key? key}) : super(key: key);

  @override
  State<Start> createState() => _StartState();
}

class _StartState extends State<Start> {
  navigateToRegister() async {
    Get.to(Register());
    // Navigator.push(
    //     context, MaterialPageRoute(builder: (context) => Register()));
  }

  navigateToLogin() async {
    Get.to(Login());
    // Navigator.push(context, MaterialPageRoute(builder: (context) => Login()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          margin: EdgeInsets.only(top: 30, left: 10, right: 10),
          child: Column(
            children: [
              Container(
                child: RichText(
                  text: TextSpan(
                    text: 'WELCOME TO REAL ESTATES UG',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: AppColors.maincolor),
                  ),
                ),
              ),
              Container(
                // height: Dimensions.popularFoodimgSize,
                margin: EdgeInsets.only(
                  top: 10,
                ),
                child: Image(
                  fit: BoxFit.cover,
                  image: AssetImage('assets/images/NEWBG2.png'),
                  height: 250,
                ),
              ),

              SizedBox(
                height: 10,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  GestureDetector(
                    onTap: navigateToLogin,
                    child: Container(
                      child: Center(
                        child: Text(
                          'Login',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      width: 350,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.blueGrey,
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  GestureDetector(
                    onTap: navigateToRegister,
                    child: Container(
                      child: Center(
                        child: Text(
                          'Create an account',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      width: 350,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.blueGrey,
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              // SignInButton(
              //   Buttons.Google,
              //   text: 'sign in with google',
              //   onPressed: (){
              //
              //   },
              //
              // )
              // Container(
              //   width: 300,
              //   child: MaterialButton(
              //     color: Colors.blue,
              //     onPressed: () {
              //       Get.to(MapScreen());
              //     },
              //     child: Text('Go to maps'),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
