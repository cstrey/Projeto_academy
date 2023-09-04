import 'package:flutter/material.dart';
import '../models/user.dart';
import 'database.dart';

class UserState extends ChangeNotifier {
  UserState() {
    loadData();
  }

  String userName = 'nome';
  int? userCnpj;

  final controller = UserController();
  final formKey = GlobalKey<FormState>();
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
      cnpj: int.parse(controllerCnpj.text),
      password: controllerPassword.text,
    );

    await controller.insert(person);

    controllerUser.clear();
    notifyListeners();
  }

  Future<void> loadData() async {
    final list = await controller.select();

    listUser
      ..clear()
      ..addAll(list);

    notifyListeners();
  }

  Future<dynamic> getUser(String username) async {
    final database = await getDatabase();
    final List<Map<String, dynamic>> result = await database.query(
      TableUser.tableName,
    );

    if (result.isNotEmpty) {
      final item = result.first;
      userName = item[TableUser.name];
      userCnpj = item[TableUser.cnpj];

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
}
