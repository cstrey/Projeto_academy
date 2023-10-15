import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controller/main_controller.dart';
import '../controller/sales_controller.dart';
import '../main.dart';
import '../models/car.dart';
import 'utils/header.dart';
import 'utils/menu_drawer.dart';

/// Declaration of a widget class named [SalesInfos]
/// that extends StatelessWidget.
class SalesInfos extends StatelessWidget {
  /// Define a constructor [SalesInfos].
  const SalesInfos({super.key});

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<MyState>(context);
    final car = ModalRoute.of(context)!.settings.arguments as Car;
    return ChangeNotifierProvider(
      create: (context) => SaleState(state.loggedUser!),
      child: Consumer<SaleState>(
        builder: (context, stateSale, child) {
          final selectSale = stateSale.selectSale;
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
              child: SingleChildScrollView(
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
                    const AppHeader(header: 'Nome do Comprador'),
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(selectSale!.customerName),
                    ),
                    const AppHeader(header: 'CPF do Comprador'),
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(selectSale.customerCpf.toString()),
                    ),
                    const AppHeader(header: 'Valor Pago Pela Loja'),
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(car.pricePaid.toString()),
                    ),
                    const AppHeader(header: 'Valor da Venda'),
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(selectSale.priceSold.toString()),
                    ),
                    const AppHeader(header: 'Porcentagem da Loja'),
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(selectSale.dealershipCut.toString()),
                    ),
                    const AppHeader(header: 'Porcentagem da Matriz'),
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(selectSale.businessCut.toString()),
                    ),
                    const AppHeader(header: 'Porcentagem de Segurança'),
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(selectSale.safetyCut.toString()),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
