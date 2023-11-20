import 'dart:convert';

class DoctorModel {
  String name;
  String type;
  String description;
  double rating;
  double goodReviews;
  double totalScore;
  double satisfaction;
  bool isfavourite;
  String image;

DoctorModel({required this.name, required this.type , required this.description , required this.rating , required this.goodReviews , required this.totalScore , required this.satisfaction,
required this.isfavourite , required this.image});
  

  DoctorModel copyWith({
    String? name,
    String? type,
    String? description,
    double? rating,
    double? goodReviews,
    double? totalScore,
    double? satisfaction,
    bool? isfavourite,
    String? image,
  }) =>
      DoctorModel(
        name: name ?? this.name,
        type: type ?? this.type,
        description: description ?? this.description,
        rating: rating ?? this.rating,
        goodReviews: goodReviews ?? this.goodReviews,
        totalScore: totalScore ?? this.totalScore,
        satisfaction: satisfaction ?? this.satisfaction,
        isfavourite: isfavourite ?? this.isfavourite,
        image: image ?? this.image,
      );

  factory DoctorModel.fromRawJson(String str) => DoctorModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory DoctorModel.fromJson(Map<String, dynamic> json) => DoctorModel(
    name: json["name"],
    type: json["type"],
    description: json["description"],
    rating: json["rating"]?.toDouble(),
    goodReviews: json["goodReviews"]?.toDouble(),
    totalScore: json["totalScore"]?.toDouble(),
    satisfaction: json["satisfaction"]?.toDouble(),
    isfavourite: json["isfavourite"],
    image: json["image"],
);


  Map<String, dynamic> toJson() => {
  "name": name,
  "type": type,
  "description": description,
  "rating": rating,
  "goodReviews": goodReviews,
  "totalScore": totalScore,
  "satisfaction": satisfaction,
  "isfavourite": isfavourite,
  "image": image,
};

}

void main() {
  // Dữ liệu JSON dưới dạng chuỗi
  String jsonData = '{"name": "Dr. John Doe", "type": "Cardiologist", "description": "Experienced cardiologist", "rating": 4.5, "goodReviews": 25, "totalScore": 50, "satisfaction": 95, "isfavourite": true, "image": "doctor.jpg"}';

  // Chuyển chuỗi JSON thành một đối tượng Map
  Map<String, dynamic> jsonMap = json.decode(jsonData);

  // Tạo một đối tượng DoctorModel từ Map
  DoctorModel doctor = DoctorModel.fromJson(jsonMap);

  // In thông tin của bác sĩ
  print('Doctor Name: ${doctor.name}');
  print('Doctor Type: ${doctor.type}');
  print('Doctor Description: ${doctor.description}');
  print('Doctor Rating: ${doctor.rating}');
  print('Good Reviews: ${doctor.goodReviews}');
  print('Total Score: ${doctor.totalScore}');
  print('Satisfaction: ${doctor.satisfaction}');
  print('Is Favorite: ${doctor.isfavourite}');
  print('Image: ${doctor.image}');
}


class Product {
  final int id;
  final String name;
  final double price;

  Product({
    required this.id,
    required this.name,
    this.price = 0.0,
  });
}
