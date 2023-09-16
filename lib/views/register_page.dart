import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controller/theme_controller.dart';
import '../controller/user_controller.dart';
import 'show_users.dart';
import 'utils/dropdown_autonomy.dart';
import 'utils/form.dart';
import 'utils/menu_drawer.dart';

class RegisterPage extends StatelessWidget {
  RegisterPage({super.key});

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<MyState>(context);
    final stateUser = Provider.of<UserState>(context);
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
          child: SingleChildScrollView(
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
                DropMenu(),
                ElevatedButton(
                  onPressed: () async {
                    if (stateUser.oldUser != null) {
                      stateUser.updateUser;
                      await stateUser.update();
                    } else {
                      await stateUser.insert();
                    }
                    if (context.mounted) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ShowUsers()),
                      );
                    }
                  },
                  child: const Text('Cadastrar'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
