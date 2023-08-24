class User {
  int? id;
  String cnpj;
  String password;
  String name;
  String? autonomy;

  User(
      {required this.cnpj,
      required this.password,
      required this.name,
      this.autonomy,
      this.id});
}
