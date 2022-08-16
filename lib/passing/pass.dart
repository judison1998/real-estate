import 'package:flutter/material.dart';
import 'package:real_estate_uganda/passing/second.dart';

class passMyData extends StatefulWidget {
  const passMyData({super.key});

  @override
  State<passMyData> createState() => _passMyDataState();
}

class _passMyDataState extends State<passMyData> {
  final nameController = TextEditingController();
  final imageurlController = TextEditingController();
  // late final String img;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('pass my data'),
        ),
        body: Container(
          child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => Second(
                          name: nameController.text,
                          imgurl: 'assets/images/realhouse.png',
                        )));
              },
              child: Image(
                image: AssetImage('assets/images/realhouse.png'),
                height: 400,
                width: 250,
              ),
            ),
            SizedBox(
              height: 5,
            ),
            TextField(
              controller: nameController,
              decoration: InputDecoration(hintText: 'enter name'),
            ),
            SizedBox(
              height: 10,
            ),
            MaterialButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => Second(
                          name: nameController.text,
                          imgurl: 'assets/images/realhouse.png',
                        )));
              },
              child: Text('send me to page two'),
            )
          ]),
        ),
      ),
    );
  }
}
