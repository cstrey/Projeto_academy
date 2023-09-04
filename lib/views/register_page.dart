import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controller/db_controller.dart';
import '../controller/theme_controller.dart';
import 'permanence/form.dart';
import 'permanence/menu.dart';

class RegisterPage extends StatelessWidget {
  RegisterPage({super.key});

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
                  onPressed: state.toggleTheme,
                  icon: Icon(
                    state.ligthMode ? Icons.dark_mode : Icons.light_mode,
                  ),
                ),
              ],
            ),
            drawer: const DrawerMenu(),
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FormPattern(
                      controler: stateUser.controllerName,
                      labelText: 'Nome da Loja',
                      keyboardType: TextInputType.text,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor, informe um nome válido.';
                        } else if (value.length > 120) {
                          return 'Nome deve ter menos de 120 caracteres';
                        }
                        return null;
                      },
                    ),
                    FormPattern(
                      controler: stateUser.controllerCnpj,
                      labelText: 'CNPJ',
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor, informe um CNPJ válido.';
                        } else if (value.length < 14 || value.length > 14) {
                          return 'cnpj deve conter 14 digitos';
                        }
                        return null;
                      },
                    ),
                    FormPattern(
                      controler: stateUser.controllerPassword,
                      labelText: 'Senha',
                      keyboardType: TextInputType.text,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor, informe uma senha válida.';
                        } else if (value.length > 12) {
                          return 'senha deve  ter menos de 12 caracteres';
                        }
                        return null;
                      },
                    ),
                    FormPattern(
                      controler: stateUser.controllerAutonomy,
                      labelText: 'Autonomia',
                      keyboardType: TextInputType.text,
                      validator: (value) {
                        return null;
                      },
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          await stateUser.insert();
                        }
                      },
                      child: const Text('Cadastrar'),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
