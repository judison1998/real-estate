import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:real_estate_uganda/widgets/big_text.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:intl/intl.dart';
import 'dart:async';
import 'dart:io';
import 'package:real_estate_uganda/model/propertyModel.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Sell extends StatefulWidget {
  Sell({super.key});
  @override
  State<Sell> createState() => _SellState();
}

class _SellState extends State<Sell> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  FocusNode searchFocusNode = FocusNode();
  FocusNode textFieldFocusNode = FocusNode();
  late SingleValueDropDownController _cnt;
  late MultiValueDropDownController _cntMulti;
  final format = DateFormat("yyyy-MM-dd");
  final dateinput = TextEditingController();
  List<XFile>? _imageFileList;
  final controllername = TextEditingController();
  final controllerage = TextEditingController();
  File? image;
  String? imgurl;
  ImagePicker picker = ImagePicker();
  final propTypeItems = ['house', 'apartment', 'plot'];
  String? value1;
  final statusitems = [
    'sell',
    'rent',
  ];
  String? value2;

  final propNo = TextEditingController();
  final propName = TextEditingController();
  final location = TextEditingController();
  final ownerNames = TextEditingController();
  final description = TextEditingController();
  final address = TextEditingController();
  final price = TextEditingController();
  final contact = TextEditingController();
  final amount = TextEditingController();
  final date = TextEditingController();
  final status = TextEditingController();
  final propType = TextEditingController();
  final ownerId = TextEditingController();

  void _setImageFileListFromFile(XFile? value) {
    _imageFileList = value == null ? null : <XFile>[value];
  }

  @override
  void initState() {
    dateinput.text = "";
    super.initState();
  }

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        imgurl = pickedFile.path;
        image = File(pickedFile.path);
        //print(json.encode(imgurl));
        print("file path...");
      } else {
        print('No image selected.');
      }
    });
  }

  Future createProperty(PropertyModel propertyModel) async {
    final docUser1 = FirebaseFirestore.instance.collection('properties2').doc();
    propertyModel.propNo = docUser1.id;
    final json = propertyModel.toJson();
    await docUser1.set(json);

    await docUser1.set(json);
  }

  // final CollectionReference _properties =
  //     FirebaseFirestore.instance.collection('properties');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('sell your property'),
      ),
      body: SingleChildScrollView(
          child: Form(
        key: _formKey,
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            SizedBox(
              height: 10,
            ),
            BigText(
              text: 'plot/house number:',
            ),
            TextField(
              controller: propNo,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
              ),
            ),
            BigText(
              text: 'property name:',
            ),
            TextField(
              controller: propName,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            BigText(
              text: 'property type:',
            ),
            Center(
              child: Container(
                width: 400,
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey, width: 2),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: DropdownButton<String>(
                    value: value1,
                    isExpanded: true,
                    iconSize: 36,
                    items: propTypeItems.map(buildMenuItem).toList(),
                    onChanged: (value) => setState(() {
                          this.value1 = value;
                        })),
              ),
            ),
            BigText(
              text: 'owner ID:',
            ),
            TextField(
              controller: ownerId,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
              ),
            ),
            BigText(
              text: 'owner Names:',
            ),
            TextField(
              controller: ownerNames,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
              ),
            ),
            BigText(
              text: 'Location District:',
            ),
            TextField(
              controller: location,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
              ),
            ),
            BigText(
              text: 'Address:',
            ),
            TextField(
              controller: address,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
              ),
            ),
            BigText(
              text: 'Description:',
            ),
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
              ),
            ),
            BigText(
              text: 'status:',
            ),
            Center(
              child: Container(
                width: 400,
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey, width: 2),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: DropdownButton<String>(
                    value: value2,
                    isExpanded: true,
                    iconSize: 36,
                    items: statusitems.map(buildMenuItem2).toList(),
                    onChanged: (value) => setState(() {
                          this.value2 = value;
                        })),
              ),
            ),
            BigText(
              text: 'Price:',
            ),
            TextField(
              controller: price,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
              ),
            ),
            BigText(
              text: 'Date:',
            ),
            Container(
              decoration: BoxDecoration(border: Border.all()),
              child: TextField(
                controller: dateinput, //editing controller of this TextField
                decoration: InputDecoration(
                    icon: Icon(Icons.calendar_today), //icon of text field
                    labelText: "Enter Date" //label text of field
                    ),
                readOnly:
                    true, //set it true, so that user will not able to edit text
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(
                          2000), //DateTime.now() - not to allow to choose before today.
                      lastDate: DateTime(2101));

                  if (pickedDate != null) {
                    print(
                        pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                    String formattedDate =
                        DateFormat('yyyy-MM-dd').format(pickedDate);
                    print(
                        formattedDate); //formatted date output using intl package =>  2021-03-16
                    //you can implement different kind of Date Format here according to your requirement

                    setState(() {
                      dateinput.text =
                          formattedDate; //set output date to TextField value.
                    });
                  } else {
                    print("Date is not selected");
                  }
                },
              ),
            ),
            BigText(
              text: 'tap to pick image',
            ),
            InkWell(
              onTap: () => getImage(),
              child: Container(
                height: 100,
                width: 300,
                decoration: BoxDecoration(),
                child: CircleAvatar(
                    backgroundColor: Colors.grey,
                    radius: 100,
                    backgroundImage: image != null ? FileImage(image!) : null),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Container(
              width: 400,
              child: MaterialButton(
                  color: Colors.blue,
                  child: Text('submit now'),
                  onPressed: () {
                    final propertyModel = PropertyModel(
                      ownerNames: ownerNames.text,
                      price: price.text,
                      date: DateTime.parse(dateinput.text),
                      contact: price.text,
                      description: description.text,
                      propName: propName.text,
                      fullAddress: address.text,
                      propType: int.parse(value1!),
                      status: value2!,
                      location: location.text,
                      ownerId: ownerId.text,
                    );
                    createProperty(propertyModel);
                    Navigator.pop(context);
                  }),
            )
          ]),
        ),
      )),
    );
  }

  DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
        value: item,
        child: Text(
          item,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      );
  DropdownMenuItem<String> buildMenuItem2(String item) => DropdownMenuItem(
        value: item,
        child: Text(
          item,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      );
  // Future createProperty(PropertyModel propertyModel) async {
  //   var storedImage = FirebaseStorage.instance.ref().child(image!.path);
  //   var task = await storedImage.putFile(image!);
  //   imgurl = await storedImage.getDownloadURL();
  //   final docUser = FirebaseFirestore.instance.collection('properties').doc();
  //   propertyModel.propNo = docUser.id;
  //   final json = propertyModel.toJson();
  //   await docUser.set(json);
  //   print('saved successfull');
  // }
}
