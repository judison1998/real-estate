import 'package:flutter/material.dart';

class Rent extends StatelessWidget {
  int selectedIndex;
  Rent({super.key, required this.selectedIndex});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: Text('just sold houses')),
    );
  }
}
