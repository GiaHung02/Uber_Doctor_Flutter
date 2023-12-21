import 'dart:convert';

class RegisterDoctorModel {
  final String fullName;
  final String email;
  final String phone;
  final String spectiality;
  final double exp; // Sửa kiểu dữ liệu thành double
  final String address;
  final int price; // Sửa kiểu dữ liệu thành int
  final String image;

  RegisterDoctorModel({
    required this.fullName,
    required this.email,
    required this.phone,
    required this.spectiality,
    required this.exp,
    required this.address,
    required this.price,
    required this.image,
  });

  Map<String, dynamic> toJson() {
    return {
      'fullName': fullName,
      'email': email,
      'phoneNumber': phone, // Sửa key thành 'phoneNumber'
      'spectiality': spectiality,
      'exp': exp,
      'address': address,
      'price': price,
      'imagePath': image,
    };
  }

  factory RegisterDoctorModel.fromJson(Map<String, dynamic> data) {
    return RegisterDoctorModel(
      fullName: data['fullName'] ?? "null",
      email: data['email'] ?? "null",
      phone: data['phoneNumber'] ?? "null", // Sửa key thành 'phoneNumber'
      spectiality: data['spectiality'] ?? "null", // Sửa key thành 'spectiality'
      exp: (data['exp'] != null && data['exp'] is! String)
          ? (data['exp'] as num).toDouble()
          : (double.tryParse(data['exp'].toString()) ?? 0),
      address: data['address'] ?? "null",
      price: (data['price'] != null && data['price'] is! String)
          ? (data['price'] as num).toInt()
          : (int.tryParse(data['price'].toString()) ?? 0),
      image: data['image'] ?? "null",
    );
  }
}
