import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controller/database.dart';
import '../models/user.dart';
import 'permanence/menu.dart';

class UserState extends ChangeNotifier {
  UserState() {
    loadData();
  }

  final controller = UserController();

  final _controllerUser = TextEditingController();
  final _listUser = <User>[];

  TextEditingController get controllerUser => _controllerUser;

  List<User> get listUser => _listUser;

  Future<void> insert() async {
    final person = User(
      autonomy: controllerUser.text,
      name: controllerUser.text,
      cnpj: controllerUser.text,
      password: controllerUser.text,
    );

    await controller.insert(person);

    controllerUser.clear();
    notifyListeners();
  }

  Future<void> loadData() async {
    final list = await controller.select();

    listUser.clear();
    listUser.addAll(list);

    notifyListeners();
  }
}

class ShowUsers extends StatelessWidget {
  const ShowUsers({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => UserState(),
      child: Consumer<UserState>(
        builder: (_, stateUser, __) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              flexibleSpace: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [
                      Color(0xff00456A),
                      Color(0xff051937),
                    ],
                  ),
                ),
              ),
              title: Text(title),
            ),
            body: ListView.builder(
              itemCount: stateUser.listUser.length,
              itemBuilder: (BuildContext context, int index) {
                final user = stateUser.listUser[index];
                return ListTile(title: Text(user.name));
              },
            ),
            drawer:
                const DrawerMenu(shopName: '', cnpj: '', profilePicture: ''),
          );
        },
      ),
    );
  }
}
