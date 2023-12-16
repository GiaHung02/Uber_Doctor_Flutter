import 'dart:ffi';

class DepartmentModel {
  final String id;
  final String name;

  DepartmentModel({required this.id, required this.name});

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'departmentName': name
    };
  }

  factory DepartmentModel.fromJson(Map<String, dynamic> data) {
    return DepartmentModel(
      id: data['id'] ?? "null",
      name: data['departmentName'] ?? "null"
    );
  }
}
