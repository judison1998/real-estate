//import 'dart:html';

import 'package:flutter/material.dart';

import '../widgets/colors.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
     return MaterialApp(
       debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 3,
        child: Container(
          // constraints: BoxConstraints.expand(),

width: double.maxFinite,

padding: EdgeInsets.all(8.0),
decoration: BoxDecoration(
image: DecorationImage(
image: AssetImage('assets/images/bgd.jpg'),
fit: BoxFit.cover
)
),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              title: Text('REAL ESTATES UGANDA'),
              centerTitle: true,
              actions: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text('find your best home right now'),
                    Text('find your best home right now'),
                    Text('find your best home right now'),
                    Text('find your best home right now')

                  ],
                )

              ],
              backgroundColor: AppColors.maincolor,
              bottom: const TabBar(
                tabs: [
                  Tab(icon: Icon(Icons.directions_car),text: 'buy',),
                  Tab(icon: Icon(Icons.directions_transit),text: 'sell',),
                  Tab(icon: Icon(Icons.directions_bike),text: 'just sold',),
                ],
              ),
            ),

            body: Column(
              children: [
                Container(
                  height: 300,
                  width: 500,
                  color: Colors.green,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
// Container(
// constraints: BoxConstraints.expand(),
// height: 500,
// width: double.maxFinite,
//
// padding: EdgeInsets.all(8.0),
// decoration: BoxDecoration(
// image: DecorationImage(
// image: AssetImage('assets/images/house8.jpg'),
// fit: BoxFit.cover
// )
// ),
// child: Scaffold(
// backgroundColor: Colors.transparent,
// appBar: AppBar(
// title: Text('RealEstates'),
// centerTitle: true,
// backgroundColor: AppColors.maincolor,
//
// ),
// body: Column(
// children: [
// TextField()
// ],
// ),
//
// ),
// );

