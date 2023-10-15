import 'dart:async';
import 'package:flutter/material.dart';
import '../models/sales.dart';
import '../models/user.dart';
import 'database.dart';

/// Class used to manage and update the state related to [sales] data.
class SaleState extends ChangeNotifier {
  /// constructor initiates the loading of data.
  SaleState(this.loggedUser) {
    loading = true;
    unawaited(loadData());
    loading = false;
  }

  /// This variable can be used to track whether something is currently
  /// in a [loading] state,
  bool loading = true;

  Sale? _oldSale;

  final _listSale = <Sale>[];

  /// Declaring a variable named [loggedUser] of the type [User].
  final User loggedUser;

  /// declaring a variable named [sale] of the type [sale] that can be null.
  Sale? sale;

  /// declaring a variable named [dealershipCut]
  /// of the type [double] that can be null.
  double? dealershipCut;

  /// declaring a variable named [businessCut]
  /// of the type [double] that can be null.
  double? businessCut;

  /// declaring a variable named [safetyCut]
  /// of the type [double] that can be null.
  double? safetyCut;

  int? _dealershipController;

  /// This controller access and invoke
  /// the methods and properties defined in the SalesController class.
  final controller = SalesController();

  /// Creates a global key that can be used to uniquely
  /// identify and interact with a FormState.
  final formKey = GlobalKey<FormState>();
  final _controllerCustomerCpf = TextEditingController();
  final _controllerCustumerName = TextEditingController();
  final _controllerSoldDate = TextEditingController();
  final _controllerPriceSold = TextEditingController();
  final _controllerDealershipCut = TextEditingController();
  final _controllerBusinessCut = TextEditingController();
  final _controllerSafetyCut = TextEditingController();

  /// Used for managing the [CustomerCpf] model information.
  TextEditingController get controllerCustomerCpf => _controllerCustomerCpf;

  /// Used for managing the [CustumerName] model information.
  TextEditingController get controllerCustumerName => _controllerCustumerName;

  /// Used for managing the [SoldDate] model information.
  TextEditingController get controllerSoldDate => _controllerSoldDate;

  /// Used for managing the [PriceSold] model information.
  TextEditingController get controllerPriceSold => _controllerPriceSold;

  /// Used for managing the [DealershipCut] model information.
  TextEditingController get controllerDealershipCut => _controllerDealershipCut;

  /// Used for managing the [BusinessCut] model information.
  TextEditingController get controllerBusinessCut => _controllerBusinessCut;

  /// Used for managing the [SafetyCut] model information.
  TextEditingController get controllerSafetyCut => _controllerSafetyCut;

  /// Keeps a record of the a old [sale] data.
  Sale? get oldSale => _oldSale;

  /// Used to load a list of [sale] objects.
  List<Sale> get listSale => _listSale;

  /// allows retrieve the value of a [_dealershipController].
  int? get dealershipController => _dealershipController;

  /// Used to insert a new [sale] in dataBase.
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

    notifyListeners();
  }

  /// Fetches a list of [sales] based on the [user's id] and updates
  /// the list displayed in the screen.
  Future<void> loadData() async {
    final list = <Sale>[];
    if (loggedUser.id != 1) {
      list.addAll(await controller.selectByDealership(loggedUser.id!));
    } else {
      list.addAll(await controller.select());
    }

    listSale.clear();
    listSale.addAll(list);

    notifyListeners();
  }

  Sale? _selectSale;

  /// Getter method, loggedUser, returns the
  /// value of a private variable _loggedUser.
  Sale? get selectSale => _selectSale;

  void setSale(Sale sale) async {
    _selectSale = sale;

    notifyListeners();
  }

  /// this code adjusts the values of
  /// [dealershipCut], [businessCut], and [safetyCut] based on the value
  /// of [loggedUser.autonomy], effectively applying different percentage
  /// cuts to the [pricePaid] parameter based on the user's [autonomy level].
  Future<void> autonomy(double pricePaid) async {
    switch (loggedUser.autonomy) {
      case 'Iniciante':
        dealershipCut = pricePaid * 0.74;
        businessCut = pricePaid * 0.25;
        safetyCut = pricePaid / 100;
        break;
      case 'Intermediario':
        dealershipCut = pricePaid * 0.79;
        businessCut = pricePaid * 0.20;
        safetyCut = pricePaid / 100;
        break;
      case 'Avançado':
        dealershipCut = pricePaid * 0.84;
        businessCut = pricePaid * 0.15;
        safetyCut = pricePaid / 100;
        break;
      case 'Especial':
        dealershipCut = pricePaid * 0.94;
        businessCut = pricePaid * 0.5;
        safetyCut = pricePaid / 100;
        break;
    }
  }
}
