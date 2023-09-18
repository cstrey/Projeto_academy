import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/car.dart';
import 'database.dart';

class CarState extends ChangeNotifier {
  CarState() {
    loadData();
  }

  final controller = CarsController();
  final formKey = GlobalKey<FormState>();
  final _controllerCar = TextEditingController();
  final _controllerModel = TextEditingController();
  final _controllerPlate = TextEditingController();
  final _controllerBrand = TextEditingController();
  final _controllerBuiltYear = TextEditingController();
  final _controllerModelYear = TextEditingController();
  final _controllerPhoto = TextEditingController();
  final _controllerPricePaid = TextEditingController();
  final _controllerPurchaseDate = TextEditingController();
  Car? _oldCar;
  final _listCar = <Car>[];

  TextEditingController get controllerCar => _controllerCar;

  TextEditingController get controllerModel => _controllerModel;

  TextEditingController get controllerPlate => _controllerPlate;

  TextEditingController get controllerBrand => _controllerBrand;

  TextEditingController get controllerBuiltYear => _controllerBuiltYear;

  TextEditingController get controllerModelYear => _controllerModelYear;

  TextEditingController get controllerPhoto => _controllerPhoto;

  TextEditingController get controllerPricePaid => _controllerPricePaid;

  TextEditingController get controllerPurchaseDate => _controllerPurchaseDate;

  Car? get oldCar => _oldCar;

  List<Car> get listCar => _listCar;

  Future<void> insert() async {
    final car = Car(
      model: controllerModel.text,
      plate: controllerPlate.text,
      brand: controllerBrand.text,
      builtYear: int.parse(controllerBuiltYear.text),
      modelYear: int.parse(controllerModelYear.text),
      photo: controllerPhoto.text,
      pricePaid: double.parse(controllerPricePaid.text),
      purchasedDate:
          DateFormat('yyyy/MM/dd').parse(controllerPurchaseDate.text),
    );

    await controller.insert(car);
    await loadData();

    controllerModel.clear();
    controllerPlate.clear();
    controllerBrand.clear();
    controllerBuiltYear.clear();
    controllerModelYear.clear();
    controllerPhoto.clear();
    controllerPricePaid.clear();
    controllerPurchaseDate.clear();

    notifyListeners();
  }

  Future<void> loadData() async {
    final list = await controller.select();

    listCar
      ..clear()
      ..addAll(list);

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
    _controllerPhoto.text = car.photo;
    _controllerPricePaid.text = car.pricePaid.toString();
    _controllerPurchaseDate.text = car.purchasedDate.toString();

    _oldCar = Car(
      model: controllerModel.text,
      plate: controllerPlate.text,
      brand: controllerBrand.text,
      builtYear: int.parse(controllerBuiltYear.text),
      modelYear: int.parse(controllerModelYear.text),
      photo: controllerPhoto.text,
      pricePaid: double.parse(controllerPricePaid.text),
      purchasedDate: DateFormat('yyyy/MM/dd').parse(
        controllerPurchaseDate.text,
      ),
    );
  }

  Future<void> update() async {
    final updateCar = Car(
      model: controllerModel.text,
      plate: controllerPlate.text,
      brand: controllerBrand.text,
      builtYear: int.parse(controllerBuiltYear.text),
      modelYear: int.parse(controllerModelYear.text),
      photo: controllerPhoto.text,
      pricePaid: double.parse(controllerPricePaid.text),
      purchasedDate: DateFormat('dd/MM/yyyy').parse(
        controllerPurchaseDate.text,
      ),
    );
    await controller.update(updateCar);

    controllerModel.clear();
    controllerPlate.clear();
    controllerBrand.clear();
    controllerBuiltYear.clear();
    controllerModelYear.clear();
    controllerPhoto.clear();
    controllerPricePaid.clear();
    controllerPurchaseDate.clear();

    await loadData();
  }
}
