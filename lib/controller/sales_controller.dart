import 'dart:async';
import 'package:flutter/material.dart';
import '../models/sales.dart';
import '../models/user.dart';
import 'database.dart';

class SaleState extends ChangeNotifier {
  SaleState(this.loggedUser) {
    unawaited(loadData());
  }

  bool loading = true;

  Sale? _oldSale;

  final _listSale = <Sale>[];

  final User loggedUser;

  Sale? sale;

  double? dealershipCut;

  double? businessCut;

  double? safetyCut;

  int? _dealershipController;

  final controller = SalesController();
  final formKey = GlobalKey<FormState>();
  final _controllerCustomerCpf = TextEditingController();
  final _controllerCustumerName = TextEditingController();
  final _controllerSoldDate = TextEditingController();
  final _controllerPriceSold = TextEditingController();
  final _controllerDealershipCut = TextEditingController();
  final _controllerBusinessCut = TextEditingController();
  final _controllerSafetyCut = TextEditingController();
  //int? _controllerCarId;

  TextEditingController get controllerCustomerCpf => _controllerCustomerCpf;

  TextEditingController get controllerCustumerName => _controllerCustumerName;

  TextEditingController get controllerSoldDate => _controllerSoldDate;

  TextEditingController get controllerPriceSold => _controllerPriceSold;

  TextEditingController get controllerDealershipCut => _controllerDealershipCut;

  TextEditingController get controllerBusinessCut => _controllerBusinessCut;

  TextEditingController get controllerSafetyCut => _controllerSafetyCut;

  Sale? get oldSale => _oldSale;

  List<Sale> get listSale => _listSale;

  int? get dealershipController => _dealershipController;

  Future<void> insert() async {
    final sale = Sale(
      businessCut: businessCut!,
      customerCpf: int.parse(controllerCustomerCpf.text),
      customerName: controllerCustumerName.text,
      dealershipCut: dealershipCut!,
      priceSold: double.parse(controllerPriceSold.text),
      safetyCut: safetyCut!,
      soldDate: controllerSoldDate.text,
      userId: int.parse(controllerCustomerCpf.text),
      //vehicleId: _controllerCarId!,
      dealershipId: loggedUser.id!,
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
    //_controllerCarId = null;

    notifyListeners();
  }

  Future<void> loadData() async {
    loading = true;

    var dealershipId = 0;

    loggedUser.id == 1
        ? dealershipId = _dealershipController ?? 1
        : dealershipId = loggedUser.id!;

    final result = await controller.selectByDealership(dealershipId);

    //result.removeWhere((element) => element.isSold == true);

    _listSale
      ..clear()
      ..addAll(result.reversed);

    loading = false;

    notifyListeners();
  }

  void updateSale(Sale sale) {
    _controllerBusinessCut.text = sale.businessCut.toString();
    _controllerCustomerCpf.text = sale.customerCpf.toString();
    _controllerCustumerName.text = sale.customerName;
    _controllerDealershipCut.text = sale.dealershipCut.toString();
    _controllerPriceSold.text = sale.priceSold.toString();
    _controllerSafetyCut.text = sale.safetyCut.toString();
    _controllerSoldDate.text = sale.soldDate.toString();
    //_controllerCarId = sale.vehicleId;

    _oldSale = Sale(
      businessCut: double.parse(controllerBusinessCut.text),
      customerCpf: int.parse(controllerCustomerCpf.text),
      customerName: controllerCustumerName.text,
      dealershipCut: double.parse(controllerDealershipCut.text),
      priceSold: double.parse(controllerPriceSold.text),
      safetyCut: double.parse(controllerSafetyCut.text),
      soldDate: controllerSoldDate.text,
      userId: loggedUser.id!,
      //vehicleId: _controllerCarId!,
      dealershipId: loggedUser.id!,
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
      soldDate: controllerSoldDate.text,
      userId: int.parse(controllerCustomerCpf.text),
      //vehicleId: ,
      dealershipId: loggedUser.id!,
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
    //_controllerCarId = null;

    await loadData();
  }

  Future<void> autonomy(double pricePaid) async {
    switch (loggedUser.autonomy) {
      case 'Iniciante':
        dealershipCut = pricePaid * 74 / 100;
        businessCut = pricePaid * 25 / 100;
        safetyCut = pricePaid / 100;
        break;
      case 'Intermediario':
        dealershipCut = pricePaid * 79 / 100;
        businessCut = pricePaid * 20 / 100;
        safetyCut = pricePaid / 100;
        break;
      case 'Avançado':
        dealershipCut = pricePaid * 84 / 100;
        businessCut = pricePaid * 15 / 100;
        safetyCut = pricePaid / 100;
        break;
      case 'Especial':
        dealershipCut = pricePaid * 94 / 100;
        businessCut = pricePaid * 5 / 100;
        safetyCut = pricePaid / 100;
        break;
    }
  }
}
