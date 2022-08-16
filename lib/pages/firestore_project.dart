import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:io';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:real_estate_uganda/pages/home1.dart';

class FirestoreUser extends StatefulWidget {
  const FirestoreUser({Key? key}) : super(key: key);

  @override
  State<FirestoreUser> createState() => _FirestoreUserState();
}

class _FirestoreUserState extends State<FirestoreUser> {
  final pricecontroller = TextEditingController();
  final ownerNamecontroller = TextEditingController();
  final locationcontroller = TextEditingController();
  final addresscontroller = TextEditingController();
  final statuscontroller = TextEditingController();
  final propType = TextEditingController();
  final contact = TextEditingController();
  //late File image;
  // String? imgurl;
  // ImagePicker picker = ImagePicker();
  // Future getImage() async {
  //   final pickedFile = await picker.getImage(source: ImageSource.gallery);
  //   setState(() {
  //     if (pickedFile != null) {
  //       imgurl = pickedFile.path;
  //       image = File(pickedFile.path);
  //       //print(json.encode(imgurl));
  //       print("file path...");
  //     } else {
  //       print('No image selected.');
  //     }
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        padding: EdgeInsets.all(8),
        children: [
          TextField(
            controller: ownerNamecontroller,
            decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(13),
                    borderSide: BorderSide(color: Colors.blueGrey, width: 3)),
                hintText: 'owner name'),
          ),
          SizedBox(
            height: 10,
          ),
          TextField(
            controller: propType,
            decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(13),
                    borderSide: BorderSide(color: Colors.blueGrey, width: 3)),
                hintText: 'property type, house/ apartment'),
          ),
          SizedBox(
            height: 10,
          ),
          TextField(
            controller: pricecontroller,
            decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(13),
                    borderSide: BorderSide(color: Colors.blueGrey, width: 3)),
                hintText: 'price'),
          ),
          SizedBox(
            height: 10,
          ),
          TextField(
            controller: locationcontroller,
            decoration: InputDecoration(hintText: 'location'),
          ),
          SizedBox(
            height: 10,
          ),
          TextField(
            controller: addresscontroller,
            decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(13),
                    borderSide: BorderSide(color: Colors.blueGrey, width: 3)),
                hintText: 'address'),
          ),
          SizedBox(
            height: 10,
          ),
          TextField(
            controller: contact,
            decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(13),
                    borderSide: BorderSide(color: Colors.blueGrey, width: 3)),
                hintText: 'contact'),
          ),
          SizedBox(
            height: 10,
          ),
          TextField(
            controller: statuscontroller,
            decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(13),
                    borderSide: BorderSide(color: Colors.blueGrey, width: 3)),
                hintText: 'status, sell/rent'),
          ),
          MaterialButton(
              child: Text('Sell Property'),
              color: Colors.blue,
              onPressed: () {
                final property = Property(
                    ownerName: ownerNamecontroller.text,
                    price: int.parse(pricecontroller.text),
                    contact: contact.text,
                    address: addresscontroller.text,
                    status: statuscontroller.text,
                    location: locationcontroller.text,
                    propType: propType.text);
                createProperty(property);
                Get.to(Home1());
              })
        ],
      ),
    );
  }

  // Future createUser({required String name}) async {
  //   final docUser =
  //       FirebaseFirestore.instance.collection('properties').doc( );
  //   final property =Property = {
  //     'id':id,
  //     name:name,
  //     age
  //     'name': name,
  //     'age': 32,
  //   };
  //   await docUser.set(json);
  // }

  Future createProperty(Property property) async {
    // var storage = FirebaseStorage.instance.ref().child(image.path);
    //  var task = await storage.putFile(image);
    //imgurl = await storage.getDownloadURL();
    final docUser = FirebaseFirestore.instance.collection('properties').doc();
    property.id = docUser.id;
    final json = property.toJson();
    await docUser.set(json);
  }
}

class Property {
  String? id;
  String? ownerName;
  String? contact;
  int? price;
  String? propType;
  String? status;
  String? location;
  String? address;

  Property(
      {this.id = '',
      required this.contact,
      required this.price,
      required this.address,
      required this.location,
      required this.ownerName,
      required this.propType,
      required this.status});
  Map<String, dynamic> toJson() => {
        'id': id,
        'name': contact,
        'price': price,
        'ownerName': ownerName,
        'propType': propType,
        'status': status,
        'location': location,
        'address': address,
      };
}
