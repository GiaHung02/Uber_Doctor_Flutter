class Payment {
  int? id;

  double? price;

  Payment({
    this.id,
    this.price,
  });

  factory Payment.fromJson(Map<String, dynamic>? json) {
    return Payment(
      id: json?['id'],
      price: json?['price'],
    );
  }
}
