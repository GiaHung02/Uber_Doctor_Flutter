import 'dart:convert';
import 'dart:typed_data';


class Doctor {
  int? id;
  String? fullName;
  String? email;
  String? spectiality;
  int? exp;
  int? rate;
  double? price;
  List<int>? image; // Change the type to List<int> for image data

  Doctor({
    this.id,
    this.fullName,
    this.email,
    this.spectiality,
    this.exp,
    this.rate,
    this.price,
    this.image,
  });

  factory Doctor.fromJson(Map<String, dynamic>? json) {
    return Doctor(
      id: json?['id'],
      fullName: json?['fullName'],
      email: json?['email'],
      spectiality: json?['spectiality'],
      exp: json?['exp'],
      rate: json?['rate'],
      price: json?['price'],
      image: json?['image'] != null
          ? base64Decode(json?['image'])
          : null, // Decode base64 string to List<int>
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'id': id,
      'fullName': fullName,
      'email': email,
      'spectiality': spectiality,
      'exp': exp,
      'rate': rate,
      'price':price,
      'image': image != null ? base64Encode(Uint8List.fromList(image!)) : null, // Encode List<int> to base64 string
    };
    return data;
  }
}
