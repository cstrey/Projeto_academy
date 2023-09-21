import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
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
  final _controllerPricePaid = TextEditingController();
  final _controllerPurchaseDate = TextEditingController();
  String? _controllerPhoto;
  Car? _oldCar;
  final _listCar = <Car>[];

  TextEditingController get controllerCar => _controllerCar;

  TextEditingController get controllerModel => _controllerModel;

  TextEditingController get controllerPlate => _controllerPlate;

  TextEditingController get controllerBrand => _controllerBrand;

  TextEditingController get controllerBuiltYear => _controllerBuiltYear;

  TextEditingController get controllerModelYear => _controllerModelYear;

  TextEditingController get controllerPricePaid => _controllerPricePaid;

  TextEditingController get controllerPurchaseDate => _controllerPurchaseDate;

  String? get controllerPhoto => _controllerPhoto;

  Car? get oldCar => _oldCar;

  List<Car> get listCar => _listCar;

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
    );

    await controller.insert(car);
    await loadData();

    controllerModel.clear();
    controllerPlate.clear();
    controllerBrand.clear();
    controllerBuiltYear.clear();
    controllerModelYear.clear();
    controllerPricePaid.clear();
    controllerPurchaseDate.clear();
    _controllerPhoto = null;

    notifyListeners();
  }

  Future<void> loadData() async {
    final list = await controller.select();

    listCar
      ..clear()
      ..addAll(list);
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
      pricePaid: double.parse(controllerPricePaid.text),
      purchasedDate: controllerPurchaseDate.text,
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
      pricePaid: double.parse(controllerPricePaid.text),
      purchasedDate: controllerPurchaseDate.text,
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

  /*Future<File> loadVehicleImage(String imageName) async {
    final result = await LocalStorage().loadImageLocal(imageName);
    return result;
  }

  void setPickedDate(String date) {
    _controllerPurchaseDate.text = date;
    notifyListeners();
  }*/
}
