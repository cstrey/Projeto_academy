/// Represents a Vehicle with [id], [model], [plate], [brand], [builtYear],
/// [modelYear], [photos], [pricePaid], [purchasedDate] and [dealershipId].
class Car {
  /// Declaring a variable [id] that can hold an integer or be null.
  final int? id;

  /// Declaring a variable [model] that can hold an string.
  final String model;

  /// Declaring a variable [plate] that can hold an string.
  final String plate;

  /// Declaring a variable [brand] that can hold an string.
  final String brand;

  /// Declaring a variable [builtYear] that can hold an integer.
  final int builtYear;

  /// Declaring a variable [modelYear] that can hold an integer.
  final int modelYear;

  /// Declaring a variable [photo] that can hold an string.
  final String photo;

  /// Declaring a variable [pricePaid] that can hold an double.
  final double pricePaid;

  /// Declaring a variable [purchasedDate] that can hold an string.
  final String purchasedDate;

  /// Declaring a variable [dealershipId] that can hold an integer.
  final int dealershipId;

  /// Defines a constructor for a [Car].
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
