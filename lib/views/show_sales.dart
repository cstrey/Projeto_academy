import 'dart:io';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../controller/cars_controller.dart';
import '../controller/main_controller.dart';
import '../controller/sale_infos.dart';
import '../controller/sales_controller.dart';
import '../main.dart';
import '../models/car.dart';
import 'utils/menu_drawer.dart';

/// Declaration of a widget class named [ShowSales]
/// that extends StatelessWidget.
class ShowSales extends StatelessWidget {
  /// Define a constructor [ShowSales].
  const ShowSales({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final numberFormatter = NumberFormat('###,###,###.00');
    final car = ModalRoute.of(context)!.settings.arguments as Car;
    final state = Provider.of<MyState>(context);
    final stateInfo = Provider.of<SalesInfosState>(context);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => CarState(state.loggedUser!),
        ),
      ],
      child: Consumer<CarState>(
        builder: (context, stateCar, _) {
          return ChangeNotifierProvider(
            create: (context) => SaleState(state.loggedUser!),
            child: Consumer<SaleState>(
              builder: (context, stateSale, value) {
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
                  body: stateSale.loading
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : ListView.builder(
                          itemCount: stateSale.listSale.length,
                          itemBuilder: (context, index) {
                            final sale = stateSale.listSale[index];
                            return ListTile(
                              onTap: () async {
                                stateInfo.setSale(sale);
                                await Navigator.of(context)
                                    .pushReplacementNamed(
                                  '/salesInfos',
                                  arguments: car,
                                );
                              },
                              leading: Image.file(
                                File(car.photo),
                              ),
                              title: Text(
                                '${car.modelYear}'
                                ' ${car.brand.toUpperCase()}'
                                ' ${car.model.toUpperCase()}',
                              ),
                              subtitle: Text(
                                'R\$${numberFormatter.format(sale.priceSold)}',
                              ),
                            );
                          },
                        ),
                  drawer: const DrawerMenu(),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
