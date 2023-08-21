import 'package:flutter/material.dart';
import 'package:projeto_lince/controller/database.dart';
import 'package:provider/provider.dart';
import '../main.dart';
import '../models/user.dart';

class UserState extends ChangeNotifier {
  UserState() {
    load();
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

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<MyState>(context);
    return ChangeNotifierProvider(
      create: (context) => UserState(),
      child: Consumer<UserState>(
        builder: (_, stateUser, __) {
          return Scaffold(
            appBar: AppBar(
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
              title: const Text('Login'),
              actions: [
                IconButton(
                  onPressed: () => state.toggleTheme(),
                  icon: Icon(
                    state.ligthMode ? Icons.dark_mode : Icons.light_mode,
                  ),
                ),
              ],
            ),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      TextFormField(
                        controller: stateUser.controllerUser,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          labelText: 'Nome',
                        ),
                      ),
                      TextFormField(
                        controller: stateUser.controllerUser,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          labelText: 'Email',
                        ),
                      ),
                      TextFormField(
                        controller: stateUser.controllerUser,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          labelText: 'Senha',
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, "/");
                        },
                        child: const Text('Entrar'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
