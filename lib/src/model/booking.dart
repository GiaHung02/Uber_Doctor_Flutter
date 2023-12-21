class Booking {
  int id;
  String statusBooking;
  bool? isAvailable;
  DateTime? bookingDate;
  String appointmentDate;
  String appointmentTime;
  String? symptoms;
  String? notes;
  double? price;
  String? bookingAttachedFile;
  Patient? patients;
  Doctor? doctors;

  Booking({
    required this.id,
    required this.statusBooking,
    required this.isAvailable,
    required this.bookingDate,
    required this.appointmentDate,
    required this.appointmentTime,
    required this.symptoms,
    required this.notes,
    required this.price,
    required this.bookingAttachedFile,
    required this.patients,
    required this.doctors, required booking,
  });

  factory Booking.fromJson(Map<String, dynamic> json) {
    return Booking(
      id: json['id'],
      statusBooking: json['statusBooking'],
      isAvailable: json['isAvailable'],
      bookingDate: DateTime.parse(json['bookingDate']),
      appointmentDate: json['appointmentDate'],
      appointmentTime: json['appointmentTime'],
      symptoms: json['symptoms'],
      notes: json['notes'],
      price: json['price'],
      bookingAttachedFile: json['bookingAttachedFile'],
      patients: Patient.fromJson(json['patients']),
      doctors: Doctor.fromJson(json['doctors']), booking: null,
    );
  }
}

class Patient {
  int id;
  String? phoneNumber;
  String? password;
  String? fullName;
  bool? role;
  String? email;
  double? wallet;
  String? bankingAccount;
  String? medicalRecord;
  String? address;
  bool? status;
  int? rate;

  Patient({
    required this.id,
    required this.phoneNumber,
    required this.password,
    required this.fullName,
    required this.role,
    required this.email,
    required this.wallet,
    required this.bankingAccount,
    required this.medicalRecord,
    required this.address,
    required this.status,
    required this.rate,
  });

  factory Patient.fromJson(Map<String, dynamic> json) {
    return Patient(
      id: json['id'],
      phoneNumber: json['phoneNumber'],
      password: json['password'],
      fullName: json['fullName'],
      role: json['role'],
      email: json['email'],
      wallet: json['wallet'],
      bankingAccount: json['bankingAccount'],
      medicalRecord: json['medicalRecord'],
      address: json['address'],
      status: json['status'],
      rate: json['rate'],
    );
  }
}

class Doctor {
  int id;
  String phoneNumber;
  String? password;
  String fullName;
  String email;
  double? wallet;
  String? bankingAccount;
  String imagePath;
  String? address;
  bool? accepted;
  bool? status;
  String spectiality;
  int? rate;
  double? price;
  int? exp;

  Doctor({
    required this.id,
    required this.phoneNumber,
    required this.password,
    required this.fullName,
    required this.email,
    required this.wallet,
    required this.bankingAccount,
    required this.imagePath,
    required this.address,
    required this.accepted,
    required this.status,
    required this.spectiality,
    required this.rate,
    required this.price,
    required this.exp,
  });

  factory Doctor.fromJson(Map<String, dynamic> json) {
    return Doctor(
      id: json['id'],
      phoneNumber: json['phoneNumber'],
      password: json['password'],
      fullName: json['fullName'],
      email: json['email'],
      wallet: json['wallet'],
      bankingAccount: json['bankingAccount'],
      imagePath: json['imagePath'],
      address: json['address'],
      accepted: json['accepted'],
      status: json['status'],
      spectiality: json['spectiality'],
      rate: json['rate'],
      price: json['price'],
      exp: json['exp'],
    );
  }
}
