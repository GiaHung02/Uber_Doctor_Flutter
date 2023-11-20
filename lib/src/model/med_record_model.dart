import 'dart:ffi';

class MedicalRecord {
  final int id;
  final String symptoms;
  final String previousSurgeries;
  final String pastIllnesses;
  

  MedicalRecord({
    required this.id,
    required this.symptoms,
    required this.previousSurgeries,
    required this.pastIllnesses,

  });

  factory MedicalRecord.fromJson(Map<String, dynamic> json) {
    return MedicalRecord(
      id: json['id'],
      symptoms: json['symptoms'],
      previousSurgeries: json['previousSurgeries'],
      pastIllnesses: json['pastIllnesses'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'symptoms': symptoms,
      'previousSurgeries': previousSurgeries,
      'pastIllnesses': pastIllnesses,
    };
  }
}
