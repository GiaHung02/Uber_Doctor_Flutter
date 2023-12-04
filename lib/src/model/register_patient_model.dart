class RegisterPatientModel {
  final String fullName;
  final String email;
  final String phone;

  RegisterPatientModel({required this.fullName, required this.email, required this.phone});

  Map<String, dynamic> toJson() {
    return {
      'fullName': fullName,
      'email': email,
      'phoneNumber': phone,
    };
  }

  factory RegisterPatientModel.fromJson(Map<String, dynamic> data) {
    return RegisterPatientModel(
      fullName: data['fullName'] ?? "null",
      email: data['email'] ?? "null",
      phone: data['phoneNumber'] ?? "null",
    );
  }
}