import 'dart:ffi';

class Doctor {
  int? id;
  String? name;
  String? email;
  String? spectiality;

  Doctor({
    this.id,
    this.name,
    this.email,
    this.spectiality,
  });

  factory Doctor.fromJson(Map<String, dynamic>? json) {
    return Doctor(
      id: json?['id'],
      name: json?['name'],
      email: json?['email'],
      spectiality: json?['spectiality'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'id': id,
      'name': name,
      'email': email,
      'spectiality': spectiality,
    };
    return data;
  }
}
