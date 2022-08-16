// ignore_for_file: prefer_const_constructors

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:real_estate_uganda/pages/home1.dart';
import 'package:real_estate_uganda/pages/payment.dart';
import 'package:real_estate_uganda/widgets/big_text.dart';
import 'package:real_estate_uganda/widgets/dimensions.dart';
import '../model/house.dart';
import 'package:real_estate_uganda/pages/payment.dart';
import 'package:get/get.dart';

class Details extends StatelessWidget {
  final int index;
  final String imgurl;
  final String location;
  Details(
      {Key? key,
      required this.index,
      required this.imgurl,
      required this.location})
      : super(key: key);
  final Stream<QuerySnapshot> houses =
      FirebaseFirestore.instance.collection('houses').snapshots();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 350,
            padding: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 2),
            //  height: Dimensions.pageViiew,

            child: Card(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image(
                    image: NetworkImage('$imgurl'),
                    height: 250,
                    width: double.maxFinite,
                  ),
                  Text('located in $location'),
                  MaterialButton(
                      color: Colors.blue,
                      onPressed: () {
                        Get.to(Payment());
                      },
                      child: Text('buy now'))
                ],
              ),
            ),
          ),
          SizedBox(
            height: 5,
          ),
          BigText(text: 'more huses for sell'),
          SizedBox(
            height: 10,
          ),
          StreamBuilder(
              stream: houses,
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.data == null) {
                  return Container(
                    child: Text("Loading..."),
                  );
                } else {
                  var data = snapshot.data;
                  return Expanded(
                    child: SingleChildScrollView(
                      child: GridView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: data!.size,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            // maxCrossAxisExtent: 250,
                            crossAxisSpacing: 2.0,
                            mainAxisSpacing: 2.0),
                        itemBuilder: (context, index) => Card(
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(20), // if you need this
                            side: BorderSide(
                              color: Colors.grey.withOpacity(0.2),
                              width: 1,
                            ),
                          ),
                          child: InkWell(
                            onTap: () {
                              int pageindex = index;

                              var imgurl = data!.docs[index]['img'];
                              var location = data.docs[index]['location'];
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => Details(
                                        imgurl: imgurl,
                                        index: pageindex,
                                        location: location,
                                      )));
                            },
                            child: Container(
                              padding: EdgeInsets.only(left: 5),
                              height: 100,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Image(
                                    image: NetworkImage(
                                      data!.docs[index]['img'],
                                    ),
                                    width: 300,
                                    height: 90,
                                    fit: BoxFit.cover,
                                  ),
                                  Text('LOCATED IN: ' +
                                      data.docs[index]['location']),
                                  Text(' PRICE: ' +
                                      data.docs[index]['price'].toString()),
                                  ElevatedButton(
                                    child: Text('buy now'),
                                    onPressed: () {},
                                  ),
                                ],
                              ),
                            ),
                          ),
                          color: Colors.white,
                        ),
                      ),
                    ),
                  );
                }
              })
        ],
      ),
    );
  }
}
