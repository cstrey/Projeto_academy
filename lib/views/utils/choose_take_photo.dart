import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../controller/cars_controller.dart';

class ChooseOrTakePhoto extends StatelessWidget {
  const ChooseOrTakePhoto({super.key});

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<CarState>(context, listen: true);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ElevatedButton(
          onPressed: state.pickImage,
          child: const Text('Galeria'),
        ),
        ElevatedButton(
          onPressed: state.takePhoto,
          child: const Text('Câmera'),
        )
      ],
    );
  }
}
