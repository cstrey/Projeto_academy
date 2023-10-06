import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../controller/user_controller.dart';

enum DropOpcoes {
  iniciante,
  intermediario,
  avancado,
  especial,
}

class DropMenu extends StatelessWidget {
  DropMenu({super.key});

  final dropOpcoes = ['Iniciante', 'Intermediario', 'Avançado', 'Especial'];

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<UserState>(context);
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: DropdownButtonFormField(
        hint: const Text('Escolha o Nivel de Autonomia'),
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        value: state.autonomyLevel,
        onChanged: (choose) => state.autonomyLevel = choose,
        items: dropOpcoes
            .map(
              (op) => DropdownMenuItem(
                value: op,
                child: Text(op),
              ),
            )
            .toList(),
      ),
    );
  }
}
