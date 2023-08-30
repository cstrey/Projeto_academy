import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controller/db_controller.dart';
import '../controller/theme_controller.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<MyState>(context);
    return ChangeNotifierProvider(
      create: (context) => UserState(),
      child: Consumer<UserState>(
        builder: (_, stateUser, __) {
          return Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
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
                  onPressed: state.toggleTheme,
                  icon: Icon(
                    state.ligthMode ? Icons.dark_mode : Icons.light_mode,
                  ),
                ),
              ],
            ),
            body: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        labelText: 'Usuário',
                      ),
                      validator: (value) {
                        if (value == null ||
                            value.isEmpty ||
                            value.length != 14) {
                          return 'Por favor, informe um CNPJ válido.';
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        labelText: 'Senha',
                      ),
                      validator: (value) {
                        if (value == null ||
                            value.isEmpty ||
                            value.length < 4) {
                          return 'Por favor, informe uma senha válida.';
                        }
                        return null;
                      },
                      obscureText: true,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      final shopCnpj = stateUser.controllerCnpj.text;
                      final password = stateUser.controllerPassword.text;
                      final userLogin = await stateUser.getUser(shopCnpj);
                      if (_formKey.currentState!.validate()) {
                        if (userLogin != null &&
                            userLogin.password == password) {
                          await Navigator.of(context).pushReplacementNamed('/');
                        } else {
                          // ignore: use_build_context_synchronously
                          await showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: const Text('Erro de Login'),
                                content:
                                    const Text('CNPJ ou senha incorretos.'),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text('OK'),
                                  ),
                                ],
                              );
                            },
                          );
                        }
                      }
                    },
                    child: const Text('Entrar'),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
