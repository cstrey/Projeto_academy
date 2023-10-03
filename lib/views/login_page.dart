import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controller/theme_controller.dart';
import '../controller/user_controller.dart';
import 'utils/form.dart';
import 'utils/header.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<MyState>(context);
    final stateUser = Provider.of<UserState>(context);
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
        key: stateUser.formKeyLogin,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const AppHeader(header: 'CNPJ'),
            const Padding(
              padding: EdgeInsets.all(8),
              child: _CnpjTextField(),
            ),
            const AppHeader(header: 'Senha'),
            const Padding(
              padding: EdgeInsets.all(8),
              child: _PasswordTextField(),
            ),
            ElevatedButton(
              child: const Text('Entrar'),
              onPressed: () async {
                final userCnpj = stateUser.controllerCnpj.text;
                final password = stateUser.controllerPassword.text;
                print(userCnpj);
                final userLogin = await stateUser.getUser(userCnpj);
                if (stateUser.formKeyLogin.currentState!.validate()) {
                  if (userLogin != null && userLogin.password == password) {
                    state.setLoggedUser(userLogin);
                    await stateUser.clearLogin();
                    if (context.mounted) {
                      await Navigator.of(context).pushReplacementNamed('/');
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
  }
}

class _CnpjTextField extends StatelessWidget {
  const _CnpjTextField();

  String? validator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor, informe um CNPJ válido.';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final stateUser = Provider.of<UserState>(context, listen: true);
    return AppTextField(
      controller: stateUser.controllerCnpj,
      validator: validator,
      hint: '02.652.603/0001-01',
    );
  }
}

class _PasswordTextField extends StatelessWidget {
  const _PasswordTextField();

  String? validator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor, informe uma senha válida.';
    } else if (value.length > 12) {
      return 'senha deve  ter menos de 12 caracteres';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final stateUser = Provider.of<UserState>(context, listen: true);
    return AppTextField(
      obscureText: true,
      controller: stateUser.controllerPassword,
      validator: validator,
      hint: '*****',
    );
  }
}
