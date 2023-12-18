import 'dart:convert';
import 'dart:typed_data';

class Doctor {
  int? id;
  String? phoneNumber;
  String? fullName;
  String? email;
  String? bankingAccount;
  String? imagePath;
  String? address;
  bool? accepted;
  bool? status;
  String? spectiality; // Chỉnh sửa tên trường để phản ánh đúng tên từ API
  int? rate;
  double? price;
  int? exp;
  String? description;

  Doctor({
    this.id,
    this.phoneNumber,
    this.fullName,
    this.email,
    this.bankingAccount,
    this.imagePath,
    this.address,
    this.accepted,
    this.status,
    this.spectiality,
    this.rate,
    this.price,
    this.exp,
    this.description
  });

  factory Doctor.fromJson(Map<String, dynamic>? json) {
    return Doctor(
      id: json?['id'],
      phoneNumber: json?['phoneNumber'],
      fullName: json?['fullName'],
      email: json?['email'],
      bankingAccount: json?['bankingAccount'],
      imagePath: json?['imagePath'],
      address: json?['address'],
      accepted: json?['accepted'],
      status: json?['status'],
      spectiality: json?['spectiality'], // Chỉnh sửa tên trường để phản ánh đúng tên từ API
      rate: json?['rate'],
      price: json?['price'],
      exp: json?['exp'],
      description: json?['description']
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'id': id,
      'phoneNumber': phoneNumber,
      'fullName': fullName,
      'email': email,
      'bankingAccount': bankingAccount,
      'imagePath': imagePath,
      'address': address,
      'accepted': accepted,
      'status': status,
      'spectiality': spectiality, // Chỉnh sửa tên trường để phản ánh đúng tên từ API
      'rate': rate,
      'price': price,
      'exp': exp,
      'description': description
    };
    return data;
  }
}
