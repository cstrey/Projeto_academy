import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controller/theme_controller.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<MyState>(context);
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
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  labelText: 'Usuário',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Insira um usuário";
                  } else if (value != "admin") {
                    return "Usuário inválido";
                  }
                  return null;
                },
              ),
              TextFormField(
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  labelText: 'Senha',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Insira uma senha";
                  } else if (value.toString() != "1234") {
                    return "Senha inválida";
                  }
                  return null;
                },
              ),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    Navigator.pushReplacementNamed(context, "/");
                  }
                },
                child: const Text('Entrar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
