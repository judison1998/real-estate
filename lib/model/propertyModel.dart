class PropertyModel {
  String propNo;
  final String propName;
  final int propType;
  final String ownerId;
  final String ownerNames;
  final String contact;
  final String location;
  final String fullAddress;
  final String description;
  final String status;
  final String price;
  final DateTime date;

  PropertyModel({
    this.propNo = '',
    required this.fullAddress,
    required this.location,
    required this.ownerId,
    required this.ownerNames,
    required this.contact,
    required this.date,
    required this.description,
    required this.propName,
    required this.propType,
    required this.price,
    required this.status,
  });
  Map<String, dynamic> toJson() => {
        'propNo': propNo,
        // 'imageurl': imageurl,
        'fullAddress': fullAddress,
        'location': location,
        'ownerId': ownerId,
        'ownerNames': ownerNames,
        'contact': contact,
        'description': description,
        'propName': propName,
        'status': status,
        'price': price,
        'propType': propType,
      };

  PropertyModel fromJson(Map<String, dynamic> json) => PropertyModel(
      propNo: json['propNo'],
      fullAddress: json['fullAddress'],
      location: json['location'],
      ownerId: json['ownerId'],
      price: json['price'],
      ownerNames: json['ownerNames'],
      propName: json['propName'],
      description: json['description'],
      contact: json['contact'],
      status: json['status'],
      propType: json['propType'],
      date: json[date]);
}
