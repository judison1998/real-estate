import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:real_estate_uganda/pages/home1.dart';
import 'package:get/get.dart';

class Payment extends StatefulWidget {
  const Payment({Key? key}) : super(key: key);

  @override
  State<Payment> createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  final pricecontroller = TextEditingController();
  final ownerNamecontroller = TextEditingController();
  final locationcontroller = TextEditingController();
  final addresscontroller = TextEditingController();
  final description = TextEditingController();
  final propType = TextEditingController();
  final contact = TextEditingController();
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
                hintText: 'client names'),
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
            controller: description,
            decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(13),
                    borderSide: BorderSide(color: Colors.blueGrey, width: 3)),
                hintText: 'property description'),
          ),
          SizedBox(
            height: 10,
          ),
          TextField(
            controller: locationcontroller,
            decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(13),
                    borderSide: BorderSide(color: Colors.blueGrey, width: 3)),
                hintText: 'location'),
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
          MaterialButton(
              child: Text('create'),
              color: Colors.blue,
              onPressed: () {
                final payment = PaymentModel(
                    clientName: ownerNamecontroller.text,
                    price: int.parse(pricecontroller.text),
                    contact: contact.text,
                    address: addresscontroller.text,
                    description: description.text,
                    location: locationcontroller.text,
                    propType: propType.text);
                createPayment(payment);
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

  Future createPayment(PaymentModel payment) async {
    final docUser = FirebaseFirestore.instance.collection('payment').doc();
    payment.id = docUser.id;
    final json = payment.toJson();
    await docUser.set(json);
  }
}

class PaymentModel {
  String? id;
  String? clientName;
  String? contact;
  int? price;
  String? description;
  String? propType;
  String? location;
  String? address;

  PaymentModel(
      {this.id = '',
      required this.contact,
      required this.price,
      required this.address,
      required this.location,
      required this.clientName,
      required this.propType,
      required this.description});
  Map<String, dynamic> toJson() => {
        'id': id,
        'contact': contact,
        'price': price,
        'clientName': clientName,
        'propType': propType,
        'description': description,
        'location': location,
        'address': address,
      };
}






















// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:real_estate_uganda/widgets/big_text.dart';
// import 'package:dropdown_textfield/dropdown_textfield.dart';
// import 'package:intl/intl.dart';
// import 'dart:async';
// import 'dart:io';
// import '../model/payment_model.dart';
// import 'package:flutter/foundation.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:permission_handler/permission_handler.dart';

// class Payment extends StatefulWidget {
//   Payment({super.key});

//   @override
//   State<Payment> createState() => _PaymentState();
// }

// class _PaymentState extends State<Payment> {
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//   FocusNode searchFocusNode = FocusNode();
//   FocusNode textFieldFocusNode = FocusNode();
//   late SingleValueDropDownController _cnt;
//   late MultiValueDropDownController _cntMulti;
//   final format = DateFormat("yyyy-MM-dd");
//   final dateinput = TextEditingController();
//   List<XFile>? _imageFileList;
//   final controllername = TextEditingController();
//   final controllerage = TextEditingController();
//   File? image;
//   String? imgurl;
//   ImagePicker picker = ImagePicker();
//   final propTypeItems = ['house', 'apartment', 'plot'];
//   String? value1;
//   final genderItems = [
//     'Male',
//     'Female',
//   ];
//   String? value2;
//   final proptypecontroller = TextEditingController();
//   final paymentId = TextEditingController();
//   final clientId = TextEditingController();
//   final clientNames = TextEditingController();
//   final description = TextEditingController();
//   final gender = TextEditingController();
//   final price = TextEditingController();
//   final age = TextEditingController();
//   final contact = TextEditingController();
//   final amount = TextEditingController();
//   final date = TextEditingController();

//   void _setImageFileListFromFile(XFile? value) {
//     _imageFileList = value == null ? null : <XFile>[value];
//   }

//   @override
//   void initState() {
//     _cnt = SingleValueDropDownController();
//     _cntMulti = MultiValueDropDownController();
//     dateinput.text = "";
//     super.initState();
//   }

//   Future getImage() async {
//     final pickedFile = await picker.getImage(source: ImageSource.gallery);
//     setState(() {
//       if (pickedFile != null) {
//         imgurl = pickedFile.path;
//         image = File(pickedFile.path);
//         //print(json.encode(imgurl));
//         print("file path...");
//       } else {
//         print('No image selected.');
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
// //  // Create a CollectionReference called users that references the firestore collection
// //     CollectionReference users = FirebaseFirestore.instance.collection('users');

// //     Future<void> addUser() {
// //       // Call the user's CollectionReference to add a new user
// //       return users
// //           .add({
// //             'full_name': fullName, // John Doe
// //             'company': company, // Stokes and Sons
// //             'age': age // 42
// //           })
// //           .then((value) => print("User Added"))
// //           .catchError((error) => print("Failed to add user: $error"));
// //     }

// //     return TextButton(
// //       onPressed: addUser,
// //       child: Text(
// //         "Add User",
// //       ),
// //     );
// //   }
// // }

//     return Scaffold(
//       appBar: AppBar(
//         centerTitle: true,
//         title: Text('payment information'),
//       ),
//       body: SingleChildScrollView(
//           child: Form(
//         key: _formKey,
//         child: Padding(
//           padding: EdgeInsets.all(20),
//           child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
//             SizedBox(
//               height: 10,
//             ),
//             SizedBox(
//               height: 10,
//             ),
//             BigText(
//               text: 'property type:',
//             ),
//             Center(
//               child: Container(
//                 width: 400,
//                 padding: EdgeInsets.all(10),
//                 decoration: BoxDecoration(
//                   border: Border.all(color: Colors.grey, width: 2),
//                   borderRadius: BorderRadius.circular(12.0),
//                 ),
//                 child: DropdownButton<String>(
//                     value: value1,
//                     isExpanded: true,
//                     iconSize: 36,
//                     items: propTypeItems.map(buildMenuItem).toList(),
//                     onChanged: (value) => setState(() {
//                           this.value1 = value;
//                         })),
//               ),
//             ),
//             BigText(
//               text: 'Payment ID:',
//             ),
//             TextField(
//               decoration: InputDecoration(
//                 border: OutlineInputBorder(),
//               ),
//             ),
//             BigText(
//               text: 'client Id:',
//             ),
//             TextField(
//               decoration: InputDecoration(
//                 border: OutlineInputBorder(),
//               ),
//             ),
//             BigText(
//               text: 'Client Names:',
//             ),
//             TextField(
//               decoration: InputDecoration(
//                 border: OutlineInputBorder(),
//               ),
//             ),
//             BigText(
//               text: 'Property Description:',
//             ),
//             TextField(
//               decoration: InputDecoration(
//                 border: OutlineInputBorder(),
//               ),
//             ),
//             BigText(
//               text: 'Gender:',
//             ),
//             Center(
//               child: Container(
//                 width: 400,
//                 padding: EdgeInsets.all(10),
//                 decoration: BoxDecoration(
//                   border: Border.all(color: Colors.grey, width: 2),
//                   borderRadius: BorderRadius.circular(12.0),
//                 ),
//                 child: DropdownButton<String>(
//                     value: value2,
//                     isExpanded: true,
//                     iconSize: 36,
//                     items: genderItems.map(buildMenuItem2).toList(),
//                     onChanged: (val) => setState(() {
//                           this.value2 = val;
//                         })),
//               ),
//             ),
//             BigText(
//               text: 'Price:',
//             ),
//             TextField(
//               keyboardType: TextInputType.phone,
//               decoration: InputDecoration(
//                 border: OutlineInputBorder(),
//               ),
//             ),
//             BigText(
//               text: 'Age:',
//             ),
//             TextField(
//               decoration: InputDecoration(
//                 border: OutlineInputBorder(),
//               ),
//             ),
//             BigText(
//               text: 'Contact:',
//             ),
//             TextField(
//               decoration: InputDecoration(
//                 border: OutlineInputBorder(),
//               ),
//             ),
//             BigText(
//               text: 'Amount paid:',
//             ),
//             TextField(
//               decoration: InputDecoration(
//                 border: OutlineInputBorder(),
//               ),
//             ),
//             BigText(
//               text: 'Balance:',
//             ),
//             TextField(
//               decoration: InputDecoration(
//                 border: OutlineInputBorder(),
//               ),
//             ),
//             BigText(
//               text: 'Date:',
//             ),
//             Container(
//               decoration: BoxDecoration(border: Border.all()),
//               child: TextField(
//                 controller: dateinput, //editing controller of this TextField
//                 decoration: InputDecoration(
//                     icon: Icon(Icons.calendar_today), //icon of text field
//                     labelText: "Enter Date" //label text of field
//                     ),
//                 readOnly:
//                     true, //set it true, so that user will not able to edit text
//                 onTap: () async {
//                   DateTime? pickedDate = await showDatePicker(
//                       context: context,
//                       initialDate: DateTime.now(),
//                       firstDate: DateTime(
//                           2000), //DateTime.now() - not to allow to choose before today.
//                       lastDate: DateTime(2101));

//                   if (pickedDate != null) {
//                     print(
//                         pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
//                     String formattedDate =
//                         DateFormat('yyyy-MM-dd').format(pickedDate);
//                     print(
//                         formattedDate); //formatted date output using intl package =>  2021-03-16
//                     //you can implement different kind of Date Format here according to your requirement

//                     setState(() {
//                       dateinput.text =
//                           formattedDate; //set output date to TextField value.
//                     });
//                   } else {
//                     print("Date is not selected");
//                   }
//                 },
//               ),
//             ),
//             Container(
//                 width: 400,
//                 child: ElevatedButton(
//                     child: Text('pay now'),
//                     onPressed: () {
//                       final payment = PaymentModel(
//                         clientNames: clientNames.text,
//                         age: int.parse(controllerage.text),
//                         amount: amount.text,
//                         clientId: clientId.text,
//                         price: price.text,
//                         date: DateTime.parse(date.text),
//                         gender: gender.text,
//                         description: description.text,
//                         contact: contact.text,
//                         paymentId: paymentId.text,
//                         propController: proptypecontroller.text,
//                       );

//                       createUser(payment);

//                       Navigator.pop(context);
//                     }))
//           ]),
//         ),
//       )),
//     );
//   }

//   Future createUser(PaymentModel payment) async {
//     final docUser = FirebaseFirestore.instance.collection('payments').doc();
//     payment.id = docUser.id;
//     final json = payment.toJson();
//     await docUser.set(json);
//   }

//   DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
//         value: item,
//         child: Text(
//           item,
//           style: TextStyle(fontWeight: FontWeight.bold),
//         ),
//       );
//   DropdownMenuItem<String> buildMenuItem2(String item) => DropdownMenuItem(
//         value: item,
//         child: Text(
//           item,
//           style: TextStyle(fontWeight: FontWeight.bold),
//         ),
//       );
// }
