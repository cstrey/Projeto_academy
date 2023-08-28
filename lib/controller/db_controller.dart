import 'package:flutter/material.dart';
import '../models/user.dart';
import 'database.dart';

class UserState extends ChangeNotifier {
  final controller = UserController();

  final _controllerUser = TextEditingController();
  final _controllerAutonomy = TextEditingController();
  final _controllerName = TextEditingController();
  final _controllerCnpj = TextEditingController();
  final _controllerPassword = TextEditingController();
  final _listUser = <User>[];

  TextEditingController get controllerUser => _controllerUser;
  TextEditingController get controllerAutonomy => _controllerAutonomy;
  TextEditingController get controllerName => _controllerName;
  TextEditingController get controllerCnpj => _controllerCnpj;
  TextEditingController get controllerPassword => _controllerPassword;

  List<User> get listUser => _listUser;

  Future<void> insert() async {
    final person = User(
      autonomy: controllerAutonomy.text,
      name: controllerName.text,
      cnpj: controllerCnpj.text,
      password: controllerPassword.text,
    );

    await controller.insert(person);
    await load();

    controllerUser.clear();
    notifyListeners();
  }

  Future<void> load() async {
    final list = await controller.select();

    listUser.clear();
    listUser.addAll(list);

    notifyListeners();
  }
}
