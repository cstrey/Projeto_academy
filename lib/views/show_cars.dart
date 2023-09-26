import 'dart:io';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../controller/cars_controller.dart';
import '../models/car.dart';
import 'register_cars.dart';
import 'utils/menu_drawer.dart';

class ShowCars extends StatelessWidget {
  const ShowCars({
    super.key,
    this.car,
  });

  final String title = 'Anderson Automóveis';
  final Car? car;

  @override
  Widget build(BuildContext context) {
    final numberFormatter = NumberFormat('###,###,###.00');
    final stateCar = Provider.of<CarState>(context);
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
        title: Text(title),
      ),
      body: ListView.builder(
        itemCount: stateCar.listCar.length,
        itemBuilder: (context, index) {
          final car = stateCar.listCar[index];
          return ListTile(
            leading: Image.file(
              File(car.photo),
            ),
            title: Text(
              '${car.modelYear}'
              ' ${car.brand.toUpperCase()}'
              ' ${car.model.toUpperCase()}',
            ),
            subtitle: Text('R\$${numberFormatter.format(car.pricePaid)}'),
            trailing: IntrinsicWidth(
              child: Row(
                children: [
                  IconButton(
                    onPressed: () async {
                      stateCar.updateCar(car);
                      Navigator.push(
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
              ),
            ),
          );
        },
      ),
      drawer: const DrawerMenu(),
    );
  }
}
