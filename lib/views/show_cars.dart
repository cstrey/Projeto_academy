import 'dart:io';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../controller/cars_controller.dart';
import '../controller/main_controller.dart';
import '../main.dart';
import 'utils/menu_drawer.dart';

/// Declaration of a widget class named [ShowCars]
/// that extends StatelessWidget.
class ShowCars extends StatelessWidget {
  /// Define a constructor [ShowCars].
  const ShowCars({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final numberFormatter = NumberFormat('###,###,###.00');
    final state = Provider.of<MyState>(context);
    return ChangeNotifierProvider(
      create: (context) => CarState(state.loggedUser!),
      child: Consumer<CarState>(
        builder: (context, stateCar, value) {
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
            body: stateCar.loading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : ListView.builder(
                    itemCount: stateCar.listCar.length,
                    itemBuilder: (context, index) {
                      final car = stateCar.listCar[index];
                      return InkWell(
                        onTap: () async {
                          await Navigator.of(context).pushReplacementNamed(
                            '/carInfos',
                            arguments: car,
                          );
                        },
                        child: ListTile(
                          leading: Image.file(
                            File(car.photo),
                          ),
                          title: Text(
                            '${car.modelYear}'
                            ' ${car.brand.toUpperCase()}'
                            ' ${car.model.toUpperCase()}',
                          ),
                          subtitle: Text(
                              'R\$${numberFormatter.format(car.pricePaid)}'),
                        ),
                      );
                    },
                  ),
            drawer: const DrawerMenu(),
          );
        },
      ),
    );
  }
}
