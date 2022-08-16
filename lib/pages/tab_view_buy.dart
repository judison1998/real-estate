import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

class TabViewBuy extends StatefulWidget {
  const TabViewBuy({super.key});

  @override
  State<TabViewBuy> createState() => _TabViewBuyState();
}

class _TabViewBuyState extends State<TabViewBuy> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        initialIndex: 0,
        length: 2,
        child: Scaffold(
          body: Container(),
        ));
  }
}
