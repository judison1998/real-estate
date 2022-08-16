class PaymentModel {
  String id;
  final String propController;
  final int age;
  final String paymentId;
  final String clientId;
  final String clientNames;
  final String description;
  final String gender;
  final String price;
  final String contact;
  final String amount;
  final DateTime date;

  PaymentModel({
    this.id = '',
    required this.clientNames,
    required this.age,
    required this.amount,
    required this.clientId,
    required this.contact,
    required this.date,
    required this.description,
    required this.gender,
    required this.paymentId,
    required this.price,
    required this.propController,
  });
  Map<String, dynamic> toJson() => {
        'id': id,
        // 'imageurl': imageurl,
        'clientNames': clientNames,
        'age': age,
        'amount': amount,
        'clientId': clientId,
        'contact': contact,
        'description': description,
        'gender': gender,
        'paymentId': paymentId,
        'price': price,
        'propController': propController,
      };

  PaymentModel fromJson(Map<String, dynamic> json) => PaymentModel(
      id: json['id'],
      clientNames: json['clientNames'],
      age: json['age'],
      propController: json['propController'],
      price: json['price'],
      paymentId: json['paymentId'],
      gender: json['gender'],
      description: json['description'],
      contact: json['contact'],
      clientId: json['clientId'],
      amount: json['amount'],
      date: json[date]);
}
