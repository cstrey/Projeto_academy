import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controller/user_controller.dart';
import 'show_users.dart';
import 'utils/dropdown_autonomy.dart';
import 'utils/form.dart';
import 'utils/header.dart';
import 'utils/menu_drawer.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
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
      ),
      drawer: const DrawerMenu(),
      body: Form(
        key: stateUser.formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const AppHeader(header: 'Name'),
              const Padding(
                padding: EdgeInsets.all(16),
                child: _NameTextField(),
              ),
              const AppHeader(header: 'CNPJ'),
              const Padding(
                padding: EdgeInsets.all(16),
                child: _CnpjTextField(),
              ),
              const AppHeader(header: 'Senha'),
              const Padding(
                padding: EdgeInsets.all(16),
                child: _PasswordTextField(),
              ),
              const AppHeader(header: 'Nível de Autonomia'),
              DropMenu(),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: ElevatedButton(
                  onPressed: () async {
                    if (stateUser.oldUser != null) {
                      stateUser.updateUser;
                      await stateUser.update();
                    } else {
                      await stateUser.insert();
                    }
                    if (context.mounted) {
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ShowUsers(),
                        ),
                      );
                    }
                  },
                  child: const Text('Cadastrar'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NameTextField extends StatelessWidget {
  const _NameTextField();

  String? validator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor, informe um nome válido.';
    } else if (value.length > 120) {
      return 'Nome deve ter menos de 120 caracteres';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final stateUser = Provider.of<UserState>(context, listen: true);
    return AppTextField(
      controller: stateUser.controllerName,
      validator: validator,
      hint: 'Anderson',
    );
  }
}

class _CnpjTextField extends StatelessWidget {
  const _CnpjTextField();

  String? validator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor, informe um CNPJ válido.';
    } else if (value.length < 14 || value.length > 14) {
      return 'cnpj deve conter 14 digitos';
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
      controller: stateUser.controllerPassword,
      validator: validator,
      hint: '*****',
    );
  }
}
