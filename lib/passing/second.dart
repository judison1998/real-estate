import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

class Second extends StatelessWidget {
  final String name, imgurl;
  const Second({
    super.key,
    required this.name,
    required this.imgurl,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('this is second page'),
      ),
      body: Container(
        child: Column(children: [
          Image(
            image: AssetImage('$imgurl'),
            height: 400,
            width: 250,
          ),
          SizedBox(
            height: 10,
          ),
          Text('$name')
        ]),
      ),
    );
  }
}
