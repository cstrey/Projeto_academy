import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controller/car_infos.dart';
import '../controller/cars_controller.dart';
import '../controller/main_controller.dart';
import '../main.dart';
import '../models/car.dart';
import 'register_cars.dart';
import 'utils/header.dart';
import 'utils/menu_drawer.dart';

/// Declaration of a widget class named [CarInfos] that extends StatelessWidget.
class CarInfos extends StatelessWidget {
  /// Define a constructor [CarInfos].
  const CarInfos({super.key});

  @override
  Widget build(BuildContext context) {
    final car = ModalRoute.of(context)!.settings.arguments as Car;
    return ChangeNotifierProvider(
      create: (context) => CarInfosState(car),
      child: Consumer<CarInfosState>(
        builder: (context, stateInfo, child) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.transparent,
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
              title: const Text(title),
            ),
            drawer: const DrawerMenu(),
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Image.file(
                    File(car.photo),
                  ),
                  const AppHeader(header: 'Marca'),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: Text(car.brand),
                  ),
                  const AppHeader(header: 'Modelo'),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: Text(car.model),
                  ),
                  const AppHeader(header: 'Placa'),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: Text(car.plate),
                  ),
                  const AppHeader(header: 'Ano Fabricação'),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: Text(car.builtYear.toString()),
                  ),
                  const AppHeader(header: 'Ano do Modelo'),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: Text(car.modelYear.toString()),
                  ),
                  const AppHeader(header: 'Preço Pago'),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: Text(car.pricePaid.toString()),
                  ),
                  const AppHeader(header: 'Funcionalidades'),
                  const Padding(
                    padding: EdgeInsets.all(8),
                    child: Buttons(),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

/// Buttons widget is used to display a row of [buttons] that
/// perform various actions related to a [Car].
class Buttons extends StatelessWidget {
  /// Define a constructor [Buttons].
  const Buttons({super.key});

  @override
  Widget build(BuildContext context) {
    final car = ModalRoute.of(context)!.settings.arguments as Car;
    final state = Provider.of<MyState>(context);
    return ChangeNotifierProvider(
      create: (context) => CarState(state.loggedUser!),
      child: Consumer<CarState>(
        builder: (context, stateCar, child) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                  onPressed: () async {
                    await Navigator.pushReplacementNamed(
                      context,
                      '/registerSale',
                      arguments: car,
                    );
                  },
                  icon: const Icon(Icons.sell)),
              IconButton(
                onPressed: () async {
                  stateCar.updateCar(car);
                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ChangeNotifierProvider.value(
                        value: stateCar,
                        child: const RegisterCarsPage(),
                      ),
                    ),
                  );
                },
                icon: const Icon(
                  Icons.edit,
                ),
              ),
              IconButton(
                onPressed: () async {
                  await stateCar.delete(car);
                },
                icon: const Icon(
                  Icons.delete,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
