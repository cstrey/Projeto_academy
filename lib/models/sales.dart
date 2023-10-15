/// Represents a Vehicle with [id], [customerCpf], [customerName], [soldDate],
///  [priceSold], [dealershipCut], [businessCut], [safetyCut],
///  [dealershipId] and [userId].
class Sale {
  /// Declaring a variable [id] that can hold an integer or be null.
  final int? id;

  /// Declaring a variable [customerCpf] that can hold an integer.
  final int customerCpf;

  /// Declaring a variable [customerName] that can hold an string.
  final String customerName;

  /// Declaring a variable [soldDate] that can hold an string.
  final String soldDate;

  /// Declaring a variable [priceSold] that can hold an double.
  final double priceSold;

  /// Declaring a variable [dealershipCut] that can hold an double.
  final double dealershipCut;

  /// Declaring a variable [businessCut] that can hold an double.
  final double businessCut;

  /// Declaring a variable [safetyCut] that can hold an double.
  final double safetyCut;

  /// Declaring a variable [dealershipId] that can hold an integer.
  final int dealershipId;

  /// Declaring a variable [userId] that can hold an integer.
  final int userId;

  /// Defines a constructor for a [Sale].
  Sale({
    this.id,
    required this.customerCpf,
    required this.customerName,
    required this.soldDate,
    required this.priceSold,
    required this.dealershipCut,
    required this.businessCut,
    required this.safetyCut,
    required this.dealershipId,
    required this.userId,
  });
}
