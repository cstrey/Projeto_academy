import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../controller/cars_controller.dart';

/// Declaration of a widget class named [ChooseOrTakePhoto]
/// that extends StatelessWidget.
class ChooseOrTakePhoto extends StatelessWidget {
  /// Define a constructor [ChooseOrTakePhoto].
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
