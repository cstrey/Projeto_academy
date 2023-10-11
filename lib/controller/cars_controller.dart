import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:image_picker/image_picker.dart';
import '../models/car.dart';
import '../models/user.dart';
import 'api_controller.dart';
import 'database.dart';

class CarState extends ChangeNotifier {
  CarState(this.loggedUser) {
    init();
  }

  final User loggedUser;

  Car? _oldCar;

  final _listCar = <Car>[];

  Car? car;

  bool loading = true;

  String? _controllerPhoto;

  int? _dealershipController;

  final controller = CarsController();
  final formKey = GlobalKey<FormState>();
  final _controllerCar = TextEditingController();
  final _controllerModel = TextEditingController();
  final _controllerPlate = TextEditingController();
  final _controllerBrand = TextEditingController();
  final _controllerBuiltYear = TextEditingController();
  final _controllerModelYear = TextEditingController();
  final _controllerPricePaid = MoneyMaskedTextController(
    decimalSeparator: '.',
    thousandSeparator: ',',
  );
  final _controllerPurchaseDate = TextEditingController();

  TextEditingController get controllerCar => _controllerCar;

  TextEditingController get controllerModel => _controllerModel;

  TextEditingController get controllerPlate => _controllerPlate;

  TextEditingController get controllerBrand => _controllerBrand;

  TextEditingController get controllerBuiltYear => _controllerBuiltYear;

  TextEditingController get controllerModelYear => _controllerModelYear;

  MoneyMaskedTextController get controllerPricePaid => _controllerPricePaid;

  TextEditingController get controllerPurchaseDate => _controllerPurchaseDate;

  String? get controllerPhoto => _controllerPhoto;

  Car? get oldCar => _oldCar;

  List<Car> get listCar => _listCar;

  int? get dealershipController => _dealershipController;

  final modelFieldFocusNode = FocusNode();
  final brandFieldFocusNode = FocusNode();

  final allBrands = <String>[];
  final allModels = <String>[];

  void init() async {
    loading = true;
    await loadData();
    final result = await getBrandNames();

    allBrands.addAll(result ?? []);

    modelFieldFocusNode.addListener(
      () async {
        if (modelFieldFocusNode.hasFocus) {
          final result = await getModelsByBrand(controllerBrand.text);
          allModels.addAll(result!);
        }
      },
    );

    loading = false;
    notifyListeners();
  }

  void setDealership(User user) async {
    _dealershipController = user.id!;
    await loadData();

    notifyListeners();
  }

  Future<List<String>?> getBrandNames() async {
    final brandsList = await getCarBrands();

    final brandNames = <String>[];

    if (brandsList != null) {
      for (final item in brandsList) {
        brandNames.add(item.name!);
      }
    }
    return brandNames;
  }

  Future<List<String>?> getModelsByBrand(String brand) async {
    final modelsList = await getCarModel(brand);

    final modelNames = <String>[];

    if (modelsList != null) {
      for (final item in modelsList) {
        modelNames.add(item.name!);
      }
    }
    return modelNames;
  }

  Future<void> insert() async {
    final car = Car(
      model: controllerModel.text,
      plate: controllerPlate.text,
      brand: controllerBrand.text,
      builtYear: int.parse(controllerBuiltYear.text),
      modelYear: int.parse(controllerModelYear.text),
      photo: controllerPhoto.toString(),
      pricePaid: double.parse(
        controllerPricePaid.text.replaceAll(RegExp(r','), ''),
      ),
      purchasedDate: controllerPurchaseDate.text,
      dealershipId: loggedUser.id!,
    );

    await controller.insert(car);
    await loadData();

    controllerModel.clear();
    controllerPlate.clear();
    controllerBrand.clear();
    controllerBuiltYear.clear();
    controllerModelYear.clear();
    controllerPricePaid.updateValue(0.00);
    controllerPurchaseDate.clear();
    _controllerPhoto = null;

    notifyListeners();
  }

  Future<void> loadData() async {
    loading = true;

    var dealershipId = 0;

    loggedUser.id == 1
        ? dealershipId = _dealershipController ?? 1
        : dealershipId = loggedUser.id!;

    final result = await controller.selectByDealership(dealershipId);

    result.removeWhere((element) => element.isSold == true);

    _listCar
      ..clear()
      ..addAll(result.reversed);

    loading = false;

    notifyListeners();
  }

  Future<void> delete(Car car) async {
    await controller.delete(car);
    await loadData();

    notifyListeners();
  }

  void updateCar(Car car) {
    _controllerModel.text = car.model;
    _controllerPlate.text = car.plate;
    _controllerBrand.text = car.brand;
    _controllerBuiltYear.text = car.builtYear.toString();
    _controllerModelYear.text = car.modelYear.toString();
    _controllerPhoto = car.photo.toString();
    _controllerPricePaid.text = car.pricePaid.toString();
    _controllerPurchaseDate.text = car.purchasedDate.toString();

    _oldCar = Car(
      id: car.id,
      model: controllerModel.text,
      plate: controllerPlate.text,
      brand: controllerBrand.text,
      builtYear: int.parse(controllerBuiltYear.text),
      modelYear: int.parse(controllerModelYear.text),
      photo: controllerPhoto.toString(),
      pricePaid: double.parse(
        controllerPricePaid.text.replaceAll(RegExp(r','), ''),
      ),
      purchasedDate: controllerPurchaseDate.text,
      dealershipId: loggedUser.id!,
    );
  }

  Future<void> update() async {
    final updateCar = Car(
      id: _oldCar!.id,
      model: controllerModel.text,
      plate: controllerPlate.text,
      brand: controllerBrand.text,
      builtYear: int.parse(controllerBuiltYear.text),
      modelYear: int.parse(controllerModelYear.text),
      photo: controllerPhoto.toString(),
      pricePaid: double.parse(
        controllerPricePaid.text.replaceAll(RegExp(r','), ''),
      ),
      purchasedDate: controllerPurchaseDate.text,
      dealershipId: loggedUser.id!,
    );
    await controller.update(updateCar);

    _oldCar = null;
    _controllerPhoto = null;
    controllerModel.clear();
    controllerPlate.clear();
    controllerBrand.clear();
    controllerBuiltYear.clear();
    controllerModelYear.clear();
    controllerPricePaid.clear();
    controllerPurchaseDate.clear();

    await loadData();
  }

  Future pickImage() async {
    {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;

      _controllerPhoto = image.path;
    }
    notifyListeners();
  }

  Future takePhoto() async {
    {
      final image = await ImagePicker().pickImage(source: ImageSource.camera);
      if (image == null) return;

      _controllerPhoto = image.path;
      notifyListeners();
    }
  }
}
