import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controller/cars_controller.dart';
import 'register_cars.dart';
import 'utils/menu_drawer.dart';

class ShowCars extends StatelessWidget {
  const ShowCars({
    super.key,
  });

  final String title = 'Anderson Automóveis';

  @override
  Widget build(BuildContext context) {
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
            title: Text(car.model),
            subtitle: Text(car.plate.toString()),
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
