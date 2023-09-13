class Car {
  final int? id;
  final String model;
  final String plate;
  final String brand;
  final int builtYear;
  final int modelYear;
  final String photo;
  final double pricePaid;
  final DateTime purchasedDate;
  final int dealershipId;

  Car({
    this.id,
    required this.model,
    required this.plate,
    required this.brand,
    required this.builtYear,
    required this.modelYear,
    required this.photo,
    required this.pricePaid,
    required this.purchasedDate,
    required this.dealershipId,
  });
}
