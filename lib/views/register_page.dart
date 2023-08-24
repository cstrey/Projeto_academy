import 'package:flutter/material.dart';
import 'package:projeto_lince/controller/database.dart';
import 'package:provider/provider.dart';
import '../main.dart';
import '../models/user.dart';

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
              title: const Text('Registre Sua Loja'),
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
                        controller: stateUser.controllerName,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          labelText: 'Nome da loja',
                        ),
                      ),
                      TextFormField(
                        controller: stateUser.controllerCnpj,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          labelText: 'CNPJ',
                        ),
                      ),
                      TextFormField(
                        controller: stateUser.controllerPassword,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          labelText: 'Senha',
                        ),
                      ),
                      TextFormField(
                        controller: stateUser.controllerPassword,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          labelText: 'Senha',
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          await stateUser.insert();
                          Navigator.pushReplacementNamed(context, "/");
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
