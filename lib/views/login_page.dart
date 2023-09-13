import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controller/db_controller.dart';
import '../controller/theme_controller.dart';
import 'permanence/form.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

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
              key: stateUser.formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FormPattern(
                    labelText: 'CNPJ do Usuário',
                    keyboardType: TextInputType.text,
                    validator: (value) {
                      if (value == null ||
                          value.isEmpty ||
                          value.length != 14) {
                        return 'Por favor, informe um CNPJ válido.';
                      }
                      return null;
                    },
                    controler: stateUser.controllerCnpj,
                  ),
                  FormPattern(
                    labelText: 'Senha',
                    keyboardType: TextInputType.text,
                    validator: (value) {
                      if (value == null || value.isEmpty || value.length < 4) {
                        return 'Por favor, informe uma senha válida.';
                      }
                      return null;
                    },
                    obscureText: true,
                    controler: stateUser.controllerPassword,
                  ),
                  ElevatedButton(
                    child: const Text('Entrar'),
                    onPressed: () async {
                      final userCnpj = stateUser.controllerCnpj.text;
                      final password = stateUser.controllerPassword.text;
                      final userLogin = await stateUser.getUser(userCnpj);
                      if (stateUser.formKey.currentState!.validate()) {
                        if (userLogin != null &&
                            userLogin.password == password) {
                          if (context.mounted) {
                            await Navigator.of(context)
                                .pushReplacementNamed('/');
                          }
                        } else {
                          if (context.mounted) {
                            await showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: const Text('Erro de Login'),
                                  content: const Text(
                                    'informações podem estar incorretas',
                                  ),
                                  actions: [
                                    ElevatedButton(
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
                      }
                    },
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
