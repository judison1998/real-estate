import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:real_estate_uganda/pages/home1.dart';
import 'package:real_estate_uganda/pages/login.dart';
import 'package:get/get.dart';
import 'package:real_estate_uganda/widgets/big_text.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);
  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  late String _email, _password, _name;
  checkAuthentification() async {
    _auth.authStateChanges().listen((user) async {
      if (_auth.currentUser != null) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Home1()));
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.checkAuthentification();
  }

  signup() async {
    if (_formkey.currentState!.validate()) {
      _formkey.currentState!.save();
      try {
        UserCredential user = await _auth.createUserWithEmailAndPassword(
            email: _email, password: _password);
        if (user != null) {
          await FirebaseAuth.instance.currentUser!
              .updateProfile(displayName: _name);
        }
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
                onPressed: () {},
                child: Text('ok'),
              )
            ],
          );
        });
  }

  Future<bool?> showWarning(BuildContext context) async => showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
            title: Text('you want to exit app?'),
            actions: [
              ElevatedButton(
                  onPressed: () => Navigator.pop(context, false),
                  child: Text('No')),
              ElevatedButton(
                  onPressed: () => Navigator.pop(context, true),
                  child: Text('Yes')),
            ],
          ));

  @override
  Widget build(BuildContext context) => WillPopScope(
      onWillPop: () async {
        print('back button clicked');
        final shouldPop = await showWarning(context);
        return shouldPop ?? false;
      },
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            child: Column(children: <Widget>[
              Container(
                height: 400,
                child: Image(
                  fit: BoxFit.cover,
                  image: AssetImage('assets/images/NEWBG2.png'),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 15, right: 15),
                child: Form(
                  key: _formkey,
                  child: Column(
                    children: [
                      BigText(text: 'create an account'),
                      // input field for name
                      TextFormField(
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide:
                                  BorderSide(width: 3, color: Colors.grey),
                            ),
                            prefixIcon: Icon(Icons.person_add_alt_1_rounded),
                            labelText: 'user name'),
                        validator: (value) => value!.isEmpty
                            ? 'user name can not be empty'
                            : null,
                        onSaved: (value) => _name = value!,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      // input field for email
                      TextFormField(
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide:
                                  BorderSide(width: 2, color: Colors.grey),
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
                                  BorderSide(width: 2, color: Colors.grey),
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
                        onTap: signup,
                        child: Container(
                          child: Center(
                            child: Text(
                              'Register',
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
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            BigText(text: 'already have an account? '),
                            SizedBox(
                              width: 10,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            MaterialButton(
                              onPressed: (() {
                                Get.to(Login());
                                // Navigator.push(context,
                                //     MaterialPageRoute(builder: (context) => Login()));
                              }),
                              child: BigText(
                                color: Colors.blue,
                                text: 'login',
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
      ));
}
