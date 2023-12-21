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
  Map<String, dynamic> toJson() {
   final Map<String, dynamic> data = {
      'id': id,
      'statusBooking': statusBooking,
      'isAvailable': isAvailable,
      'bookingDate': bookingDate?.toIso8601String(),
      'appointmentDate': appointmentDate,
      'appointmentTime': appointmentTime,
      'symptoms': symptoms,
      'notes': notes,
      'price': price,
      'bookingAttachedFile': bookingAttachedFile,
      'patients': patients?.toJson(),
      'doctors': doctors?.toJson(),
    };
     return data;
  }
}

class Patient {
  int id;
  String? phoneNumber;
  String? password;
  String fullName;
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
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'id': id,
      'phoneNumber': phoneNumber,
      'password': password,
      'fullName': fullName,
      'role': role,
      'email': email,
      'wallet': wallet,
      'bankingAccount': bankingAccount,
      'medicalRecord': medicalRecord,
      'address': address,
      'status': status,
      'rate': rate,
    };
    return data;
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
  bool status;
  String spectiality;
  int? rate;
  double? price;
  int? exp;
  String? description;

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
    this.description,
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
        description: json?['description']);
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
      'spectiality':
          spectiality, // Chỉnh sửa tên trường để phản ánh đúng tên từ API
      'rate': rate,
      'price': price,
      'exp': exp,
      'description': description
    };
    return data;
  }
}
