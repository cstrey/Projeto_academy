import 'dart:async';
import 'package:flutter/material.dart';
import '../models/user.dart';
import 'database.dart';

/// Class used to manage and update the state related to [user] data.
class UserState extends ChangeNotifier {
  /// constructor initiates the loading of data.
  UserState() {
    unawaited(loadData());
  }

  String? _autonomyLevel;

  /// This controller access and invoke
  /// the methods and properties defined in the UserController class.
  final controller = UserController();

  /// Creates a global key that can be used to uniquely
  /// identify and interact with a FormState.
  final formKey = GlobalKey<FormState>();

  /// Creates a global key that can be used to uniquely
  /// identify and interact with a FormState.
  final formKeyLogin = GlobalKey<FormState>();

  final _controllerUser = TextEditingController();

  final _controllerAutonomy = TextEditingController();

  final _controllerName = TextEditingController();

  final _controllerCnpj = TextEditingController();

  final _controllerPassword = TextEditingController();

  User? _oldUser;

  final _listUser = <User>[];

  /// Used for managing the [controllerUser] model information.
  TextEditingController get controllerUser => _controllerUser;

  /// Used for managing the [controllerName] model information.
  TextEditingController get controllerName => _controllerName;

  /// Used for managing the [controllerCnpj] model information.
  TextEditingController get controllerCnpj => _controllerCnpj;

  /// Used for managing the [controllerPassword] model information.
  TextEditingController get controllerPassword => _controllerPassword;

  /// Keeps a record of the a [old user] data.
  User? get oldUser => _oldUser;

  /// Used to load a list of [user] objects.
  List<User> get listUser => _listUser;

  /// Used for managing the [user] [autonomy level] information.
  String? get autonomyLevel => _autonomyLevel;

  set autonomyLevel(String? value) {
    _autonomyLevel = value;

    notifyListeners();
  }

  /// Used to insert a new [user] in dataBase.
  Future<void> insert() async {
    final person = User(
      autonomy: autonomyLevel,
      name: controllerName.text,
      cnpj: int.parse(controllerCnpj.text),
      password: controllerPassword.text,
    );

    await controller.insert(person);
    await loadData();

    autonomyLevel = null;
    controllerName.clear();
    controllerCnpj.clear();
    controllerPassword.clear();
    notifyListeners();
  }

  /// Retrieves a [user's] information from a database by
  /// matching the provided [userCnpj] with the data in the database.
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
        autonomy: item[TableUser.autonomy],
      );
    }

    notifyListeners();
    return null;
  }

  /// Delete a [user].
  Future<void> delete(User person) async {
    await controller.delete(person);
    await loadData();

    notifyListeners();
  }

  /// function that loads data from a controller,
  /// clears an existing list [listUser], populates it with the new data,
  Future<void> loadData() async {
    final list = await controller.select();

    listUser
      ..clear()
      ..addAll(list);

    notifyListeners();
  }

  /// Updates the internal text controllers with the values
  /// from the [user] object and creates an _oldUser object.
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

  /// This function is used to update information related to a [user] object.
  Future<void> update() async {
    final updateUser = User(
      id: _oldUser?.id,
      name: controllerName.text,
      password: controllerPassword.text,
      autonomy: autonomyLevel,
      cnpj: int.parse(controllerCnpj.text),
    );

    await controller.update(updateUser);
    _oldUser = null;
    _controllerPassword.clear();
    _controllerAutonomy.clear();
    _controllerName.clear();
    _controllerCnpj.clear();

    await loadData();
  }

  /// function that clears the content of two input fields,
  /// [controllerCnpj] and [controllerPassword]
  Future<void> clearLogin() async {
    controllerCnpj.clear();
    controllerPassword.clear();
  }
}
