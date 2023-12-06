class RegisterDoctorModel {
  final String fullName;
  final String email;
  final String phone;

  RegisterDoctorModel({required this.fullName, required this.email, required this.phone});

  Map<String, dynamic> toJson() {
    return {
      'fullName': fullName,
      'email': email,
      'phoneNumber': phone,
    };
  }

  factory RegisterDoctorModel.fromJson(Map<String, dynamic> data) {
    return RegisterDoctorModel(
      fullName: data['fullName'] ?? "null",
      email: data['email'] ?? "null",
      phone: data['phoneNumber'] ?? "null",
    );
  }
}