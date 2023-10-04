// ignore_for_file: unused_local_variable

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/sales.dart';
import '../models/user.dart';
import 'database.dart';

class SaleState extends ChangeNotifier {
  SaleState() {
    unawaited(loadData());
  }
  Sale? _oldSale;

  final _listSale = <Sale>[];

  User? _loggedUser;

  Sale? sale;

  final controller = SalesController();
  final formKey = GlobalKey<FormState>();
  final _controllerCustomerCpf = TextEditingController();
  final _controllerCustumerName = TextEditingController();
  final _controllerSoldDate = TextEditingController();
  final _controllerPriceSold = TextEditingController();
  final _controllerDealershipCut = TextEditingController();
  final _controllerBusinessCut = TextEditingController();
  final _controllerSafetyCut = TextEditingController();
  final _controllerVehicleId = TextEditingController();

  TextEditingController get controllerCustomerCpf => _controllerCustomerCpf;

  TextEditingController get controllerCustumerName => _controllerCustumerName;

  TextEditingController get controllerSoldDate => _controllerSoldDate;

  TextEditingController get controllerPriceSold => _controllerPriceSold;

  TextEditingController get controllerDealershipCut => _controllerDealershipCut;

  TextEditingController get controllerBusinessCut => _controllerBusinessCut;

  TextEditingController get controllerSafetyCut => _controllerSafetyCut;

  TextEditingController get controllerVehicleId => _controllerVehicleId;

  Sale? get oldSale => _oldSale;

  List<Sale> get listSale => _listSale;

  Future<void> insert() async {
    final sale = Sale(
      businessCut: double.parse(controllerBusinessCut.text),
      customerCpf: int.parse(controllerCustomerCpf.text),
      customerName: controllerCustumerName.text,
      dealershipCut: double.parse(controllerDealershipCut.text),
      priceSold: double.parse(controllerPriceSold.text),
      safetyCut: double.parse(controllerSafetyCut.text),
      soldDate: DateFormat('dd/MM/yyyy').parse(controllerSoldDate.text),
      userId: int.parse(controllerCustomerCpf.text),
      vehicleId: int.parse(controllerVehicleId.text),
      dealershipId: _loggedUser!.id!,
    );

    await controller.insert(sale);
    await loadData();

    controllerBusinessCut.clear();
    controllerCustomerCpf.clear();
    controllerCustumerName.clear();
    controllerDealershipCut.clear();
    controllerPriceSold.clear();
    controllerSafetyCut.clear();
    controllerSoldDate.clear();
    controllerVehicleId.clear();

    notifyListeners();
  }

  Future<void> loadData() async {
    final list = await controller.select();

    listSale
      ..clear()
      ..addAll(list);
  }

  void updateSale(Sale sale) {
    _controllerBusinessCut.text = sale.businessCut.toString();
    _controllerCustomerCpf.text = sale.customerCpf.toString();
    _controllerCustumerName.text = sale.customerName;
    _controllerDealershipCut.text = sale.dealershipCut.toString();
    _controllerPriceSold.text = sale.priceSold.toString();
    _controllerSafetyCut.text = sale.safetyCut.toString();
    _controllerSoldDate.text = sale.soldDate.toString();
    _controllerVehicleId.text = sale.vehicleId.toString();

    _oldSale = Sale(
      businessCut: double.parse(controllerBusinessCut.text),
      customerCpf: int.parse(controllerCustomerCpf.text),
      customerName: controllerCustumerName.text,
      dealershipCut: double.parse(controllerDealershipCut.text),
      priceSold: double.parse(controllerPriceSold.text),
      safetyCut: double.parse(controllerSafetyCut.text),
      soldDate: DateFormat('dd/MM/yyyy').parse(controllerSoldDate.text),
      userId: int.parse(controllerCustomerCpf.text),
      vehicleId: int.parse(controllerCustomerCpf.text),
      dealershipId: _loggedUser!.id!,
    );
  }

  Future<void> update() async {
    final updateSale = Sale(
      businessCut: double.parse(controllerBusinessCut.text),
      customerCpf: int.parse(controllerCustomerCpf.text),
      customerName: controllerCustumerName.text,
      dealershipCut: double.parse(controllerDealershipCut.text),
      priceSold: double.parse(controllerPriceSold.text),
      safetyCut: double.parse(controllerSafetyCut.text),
      soldDate: DateFormat('dd/MM/yyyy').parse(controllerSoldDate.text),
      userId: int.parse(controllerCustomerCpf.text),
      vehicleId: int.parse(controllerCustomerCpf.text),
      dealershipId: _loggedUser!.id!,
    );
    await controller.update(updateSale);

    _oldSale = null;
    controllerBusinessCut.clear();
    controllerCustomerCpf.clear();
    controllerCustumerName.clear();
    controllerDealershipCut.clear();
    controllerPriceSold.clear();
    controllerSafetyCut.clear();
    controllerSoldDate.clear();
    controllerVehicleId.clear();

    await loadData();
  }

  Future<void> autonomy(double pricePaid) async {
    switch (_loggedUser!.autonomy) {
      case 'Iniciante':
        var dealershipCut = pricePaid * 74 / 100;
        var businessCut = pricePaid * 25 / 100;
        var safetyCut = pricePaid / 100;
        break;
      case 'Intermediario':
        var dealershipCut = pricePaid * 79 / 100;
        var businessCut = pricePaid * 20 / 100;
        var safetyCut = pricePaid / 100;
        break;
      case 'Avançado':
        var dealershipCut = pricePaid * 84 / 100;
        var businessCut = pricePaid * 15 / 100;
        var safetyCut = pricePaid / 100;
        break;
      case 'Especial':
        var dealershipCut = pricePaid * 94 / 100;
        var businessCut = pricePaid * 5 / 100;
        var safetyCut = pricePaid / 100;
        break;
    }
  }

  // ignore: use_setters_to_change_properties
  void setLoggedUser(User? user) {
    _loggedUser = user;
  }
}
