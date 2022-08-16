//import 'dart:html';

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:real_estate_uganda/image_fetching/firebase_file.dart';
import 'package:real_estate_uganda/pages/sell.dart';
import 'package:real_estate_uganda/pages/start_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:real_estate_uganda/widgets/big_text.dart';
import '../model/house.dart';
import 'package:real_estate_uganda/pages/just_sold.dart';
import 'package:get/get.dart';
import '../widgets/colors.dart';
import '../widgets/dimensions.dart';
import 'details.dart';
import 'firestore_project.dart';

class Home1 extends StatefulWidget {
  const Home1({Key? key}) : super(key: key);

  @override
  State<Home1> createState() => _Home1State();
}

class _Home1State extends State<Home1> with SingleTickerProviderStateMixin {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  late User user;
  late TabController _controller;
  bool isLoggedIn = false;
  final Stream<QuerySnapshot> houses =
      FirebaseFirestore.instance.collection('houses').snapshots();

  checkAuthentification() async {
    _auth.authStateChanges().listen((user) {
      if (user == null) {
        Get.to(Start());
      }
    });
  }

  getUser() async {
    User firebaseUser = await _auth.currentUser!;
    await firebaseUser.reload();
    firebaseUser = _auth.currentUser!;
    if (firebaseUser != null) {
      setState(() {
        this.user = firebaseUser;
        this.isLoggedIn = true;
      });
    }
  }

  static const List<Tab> myTabs = <Tab>[
    Tab(text: 'buy'),
    Tab(text: 'sell'),
    Tab(text: 'rent'),
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.checkAuthentification();
    this.getUser();
    _controller = TabController(vsync: this, length: myTabs.length);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var children2 = [
      Container(
        height: 150,
        child: Expanded(
          child: Stack(
            fit: StackFit.expand,
            children: [
              //background image
              Positioned(
                  left: 0,
                  right: 0,
                  child: Container(
                    padding: EdgeInsets.all(10),
                    width: double.maxFinite,
                    height: 150,
                    //height: Dimensions.popularFoodimgSize,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage("assets/images/background1.png"),
                            fit: BoxFit.cover)),
                  )),
              Positioned(
                top: 50,
                bottom: 30,
                child: BigText(
                  text: 'FIND YOUR BEST HOUSE NOW',
                  color: Colors.white,
                ),
              ),
              Positioned(
                top: 10,
                right: 120,
                child: GestureDetector(
                  onTap: () {
                    Get.to(Profile(
                      userName: user.displayName!,
                    ));
                  },
                  child: CircleAvatar(
                      child: Icon(
                        Icons.person,
                        color: Colors.black12,
                      ),
                      backgroundColor: AppColors.iconcolor1),
                ),
              ),
              Positioned(
                top: 10,
                right: 10,
                child: BigText(
                  text: 'welcome Back',
                  size: 25,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
      Container(
        decoration: BoxDecoration(
          color: Colors.blue,
        ),
        child: InkWell(
          onTap: () {
            Get.to(Rent(
              selectedIndex: 0,
            ));
          },
          child: TabBar(
            controller: _controller,
            tabs: [
              new Tab(
                icon: const Icon(
                  Icons.home,
                  color: Colors.green,
                ),
                text: 'buy',
              ),
              InkWell(
                onTap: () {
                  Get.to(FirestoreUser());
                },
                child: Tab(
                  icon: const Icon(
                    Icons.sell,
                    color: Colors.red,
                  ),
                  text: 'sell',
                ),
              ),
              InkWell(
                onTap: () {
                  Get.to(Rent(
                    selectedIndex: 2,
                  ));
                },
                child: Tab(
                  icon: const Icon(
                    Icons.my_location,
                    color: Colors.red,
                  ),
                  text: 'rent',
                ),
              )
            ],
          ),
        ),
      ),
      SizedBox(
        height: 10,
      ),
      StreamBuilder(
          stream: houses,
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            // if (snapshot.data == null) {
            //   return Container(
            //     child: Text("Loading..."),
            //   );
            // }
            //else
            if (snapshot.hasData) {
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
                          padding: EdgeInsets.only(left: 2),
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
            return Container();
          })
    ];
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
            // The search area here
            title: Container(
          width: double.infinity,
          height: 40,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(5)),
          child: Center(
            child: TextField(
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search),
                  suffixIcon: IconButton(
                    icon: Icon(Icons.clear),
                    onPressed: () {
                      /* Clear the search field */
                    },
                  ),
                  hintText: 'Search for homes near you',
                  border: InputBorder.none),
            ),
          ),
        )),
        drawer: Drawer(
          child: ListView(
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                curve: Curves.bounceInOut,
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
                child: Container(
                    child: CircleAvatar(
                  child: Text('Real estates ug'),
                  backgroundImage: AssetImage('assets/images/NEWBG2.png'),
                )),
              ),
              ListTile(
                leading: Icon(Icons.home),
                title: const Text('houses for sell'),
                onTap: () {
                  Navigator.pop(context);
                  //Get.to(Home1());
                  // Update the state of the app.
                  // ...
                },
              ),
              ListTile(
                leading: Icon(Icons.home),
                title: const Text('houses for rent'),
                onTap: () {
                  // Get.to(Home1());
                  // Update the state of the app.
                  // ...
                },
              ),
              ListTile(
                leading: Icon(Icons.home),
                title: const Text('sell your property'),
                onTap: () {
                  Get.to(FirestoreUser());
                  // Update the state of the app.
                  // ...
                },
              ),
              ListTile(
                leading: Icon(Icons.home),
                title: const Text('Apartments for sell/rent'),
                onTap: () {
                  // Update the state of the app.
                  // ...
                },
              ),
              ListTile(
                leading: Icon(Icons.home),
                title: const Text('plots for sell'),
                onTap: () {
                  // Update the state of the app.
                  // ...
                },
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Container(
              child: !isLoggedIn
                  ? Container(height: 40, child: CircularProgressIndicator())
                  : Container(
                      child: Column(
                        children: children2,
                      ),
                    ),
            ),
            Center(
              child: Container(child: Text('selling information')),
            ),
            Center(
              child: Container(child: Text('houses for rent')),
            ),
          ],
        ),
      ),
    );
  }
}

class Profile extends StatelessWidget {
  final String userName;
  Profile({Key? key, required this.userName}) : super(key: key);
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('hellow $userName')),
      body: Padding(
        padding: EdgeInsets.only(
          top: 10,
          left: 30,
          right: 30,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CircleAvatar(
              backgroundColor: Colors.black,
              radius: 50,
              child: Icon(
                Icons.person,
                size: 50,
                color: Colors.grey,
              ),
            ),
            MaterialButton(
              color: Colors.blue,
              child: Text('sign out'),
              onPressed: signOut,
            )
          ],
        ),
      ),
    );
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }
}
