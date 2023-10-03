import 'dart:async';
import 'package:flutter/material.dart';
import '../models/user.dart';
import 'database.dart';

class UserState extends ChangeNotifier {
  UserState() {
    unawaited(loadData());
  }

  final controller = UserController();
  final formKey = GlobalKey<FormState>();
  final formKeyLogin = GlobalKey<FormState>();
  final _controllerUser = TextEditingController();
  final _controllerAutonomy = TextEditingController();
  final _controllerName = TextEditingController();
  final _controllerCnpj = TextEditingController();
  final _controllerPassword = TextEditingController();
  User? _oldUser;
  final _listUser = <User>[];
  String? _controllerPhoto;

  TextEditingController get controllerUser => _controllerUser;
  TextEditingController get controllerAutonomy => _controllerAutonomy;
  TextEditingController get controllerName => _controllerName;
  TextEditingController get controllerCnpj => _controllerCnpj;
  TextEditingController get controllerPassword => _controllerPassword;
  User? get oldUser => _oldUser;
  List<User> get listUser => _listUser;
  String? get controllerPhoto => _controllerPhoto;

  Future<void> insert() async {
    final person = User(
      autonomy: controllerAutonomy.text,
      name: controllerName.text,
      cnpj: int.parse(controllerCnpj.text),
      password: controllerPassword.text,
    );

    await controller.insert(person);
    await loadData();

    controllerAutonomy.clear();
    controllerName.clear();
    controllerCnpj.clear();
    controllerPassword.clear();
    _controllerPhoto = null;
    notifyListeners();
  }

  Future<dynamic> getUser(String userCnpj) async {
    final database = await getDatabase();
    final List<Map<String, dynamic>> result = await database.query(
      TableUser.tableName,
      where: '${TableUser.cnpj} = ?',
      whereArgs: [userCnpj],
    );
    if (result.isNotEmpty) {
      final item = result.first;

      return User(
        id: item[TableUser.id],
        cnpj: item[TableUser.cnpj],
        name: item[TableUser.name],
        password: item[TableUser.password],
      );
    }

    notifyListeners();
    return null;
  }

  Future<void> delete(User person) async {
    await controller.delete(person);
    await loadData();

    notifyListeners();
  }

  Future<void> loadData() async {
    final list = await controller.select();

    listUser
      ..clear()
      ..addAll(list);

    notifyListeners();
  }

  void updateUser(User person) {
    _controllerName.text = person.name;
    _controllerCnpj.text = person.cnpj.toString();

    _oldUser = User(
      name: person.name,
      cnpj: person.cnpj,
      password: person.password,
      autonomy: person.autonomy,
      id: person.id,
    );

    notifyListeners();
  }

  Future<void> update() async {
    final updateUser = User(
      id: _oldUser?.id,
      name: controllerName.text,
      password: controllerPassword.text,
      autonomy: controllerAutonomy.text,
      cnpj: int.parse(controllerCnpj.text),
    );

    await controller.update(updateUser);
    _oldUser = null;
    _controllerPassword.clear();
    _controllerAutonomy.clear();
    _controllerName.clear();
    _controllerCnpj.clear();
    _controllerPhoto = null;

    await loadData();
  }

  Future<void> clearLogin() async {
    controllerCnpj.clear();
    controllerPassword.clear();
  }
}
