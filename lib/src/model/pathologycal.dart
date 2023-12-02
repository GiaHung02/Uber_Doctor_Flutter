class Symptomslist {
  int? id;
  String? symptoms;
  String? description;
  String? reason;

  Symptomslist({
    this.id,
    this.symptoms,
    this.description,
    this.reason,
  });

  factory Symptomslist.fromJson(Map<String, dynamic>? json) {
    return Symptomslist(
      id: json?['id'],
      symptoms: json?['symptoms'],
      description: json?['description'],
      reason: json?['reason'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'id': id,
      'symptoms': symptoms,
      'description': description,
      'reason': reason,
    };
    return data;
  }
}
