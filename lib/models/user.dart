/// Represents a Vehicle with
/// [id], [cnpj], [password], [name], [autonomy].
class User {
  /// Declaring a variable [id] that can hold an integer or be null.
  int? id;

  /// Declaring a variable [cnpj] that can hold an integer.
  int cnpj;

  /// Declaring a variable [password] that can hold an string.
  String password;

  /// Declaring a variable [name] that can hold an string.
  String name;

  /// Declaring a variable [autonomy] that can hold an string or be null.
  String? autonomy;

  /// Defines a constructor for a [User].
  User({
    required this.cnpj,
    required this.password,
    required this.name,
    this.autonomy,
    this.id,
  });
}
