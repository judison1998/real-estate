import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:real_estate_uganda/pages/home1.dart';
import 'package:real_estate_uganda/pages/signUp.dart';
import 'package:get/get.dart';
import 'package:real_estate_uganda/widgets/big_text.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  late String _email, _password;
  checkAuthentication() async {
    _auth.authStateChanges().listen((event) {
      if (_auth.currentUser != null) {
        Get.to(Home1());
        // Navigator.push(
        //     context, MaterialPageRoute(builder: (context) => Home1()));
      }
    });
  }

  signout() async {
    _auth.signOut();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.checkAuthentication();
  }

  Login() async {
    if (_formkey.currentState!.validate()) {
      _formkey.currentState!.save();
      try {
        UserCredential user = await _auth.signInWithEmailAndPassword(
            email: _email, password: _password);
      } catch (e) {
        showError(e.toString());
      }
    }
  }

  showError(String errormessage) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('error'),
            content: Text(errormessage),
            actions: [
              MaterialButton(
                color: Colors.blue,
                onPressed: () {
                  Get.to(Login());
                },
                child: Text('ok'),
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          child: Column(children: <Widget>[
            Container(
              height: 300,
              child: Image(
                fit: BoxFit.cover,
                image: AssetImage('assets/images/NEWBG2.png'),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 10, right: 10),
              child: Form(
                key: _formkey,
                child: Column(
                  children: [
                    BigText(text: 'login to your account'),
                    SizedBox(
                      height: 10,
                    ),
                    // input field for email
                    TextFormField(
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide:
                                BorderSide(width: 3, color: Colors.grey),
                          ),
                          prefixIcon: Icon(Icons.email),
                          labelText: 'Email'),
                      validator: (value) =>
                          value!.isEmpty ? 'Email cannot be blank' : null,
                      onSaved: (value) => _email = value!,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    // input field for password
                    TextFormField(
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide:
                                BorderSide(width: 3, color: Colors.grey),
                          ),
                          prefixIcon: Icon(Icons.lock),
                          labelText: 'Password'),
                      obscureText: true,
                      validator: (value) =>
                          value!.isEmpty ? 'Password cannot be blank' : null,
                      onSaved: (value) => _password = value!,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    GestureDetector(
                      onTap: Login,
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
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      Text('dont have an account? '),
                      SizedBox(
                        width: 10,
                      ),
                      MaterialButton(
                        onPressed: (() {
                          Get.to(Register());
                        }),
                        child: BigText(
                          text: 'Register',
                        ),
                      ),
                    ]),
                  ],
                ),
              ),
            )
          ]),
        ),
      ),
    );
  }
}
