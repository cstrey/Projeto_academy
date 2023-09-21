import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../controller/cars_controller.dart';

class PhotosList extends StatelessWidget {
  const PhotosList({super.key});

  @override
  Widget build(BuildContext context) {
    final stateCar = Provider.of<CarState>(context, listen: true);
    return SingleChildScrollView(
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).focusColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Image.file(
                File(stateCar.controllerPhoto!),
                height: MediaQuery.of(context).size.height / 10,
              )
            ],
          ),
        ),
      ),
    );
  }
}
