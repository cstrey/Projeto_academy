import 'package:flutter/material.dart';

class DropMenu extends StatelessWidget {
  DropMenu({super.key});

  final dropValue = ValueNotifier('');
  final dropOpcoes = ['Iniciante', 'Intermediario', 'Avançado', 'Especial'];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ValueListenableBuilder(
        valueListenable: dropValue,
        builder: ((context, value, _) {
          return DropdownButtonFormField(
            hint: const Text('Escolha o Nivel de Autonomia'),
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            value: (value.isEmpty) ? null : value,
            onChanged: (choose) => dropValue.value = choose.toString(),
            items: dropOpcoes
                .map(
                  (op) => DropdownMenuItem(
                    value: op,
                    child: Text(op),
                  ),
                )
                .toList(),
          );
        }),
      ),
    );
  }
}
