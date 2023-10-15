import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:image_picker/image_picker.dart';
import '../models/car.dart';
import '../models/user.dart';
import 'api_controller.dart';
import 'database.dart';

/// Class used to manage and update the state related to [car] data.
class CarState extends ChangeNotifier {
  /// Class is initialized with a required [loggedUser],
  /// which is an instance of the [User] class.
  CarState(this.loggedUser) {
    init();
  }

  /// Declares a final variable named [loggedUser] of the type [User].
  final User loggedUser;

  Car? _oldCar;

  final _listCar = <Car>[];

  /// Create a variable [car] which is not initialized
  Car? car;

  /// This variable can be used to track whether something is currently
  /// in a [loading] state,
  bool loading = true;

  String? _controllerPhoto;

  int? _dealershipController;

  /// Creates an instance of a [CarsController] class.
  final controller = CarsController();

  /// Defines a formKey variable of type [GlobalKey<FormState>].
  final formKey = GlobalKey<FormState>();
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

  /// Used for managing the [car] model information.
  TextEditingController get controllerModel => _controllerModel;

  /// Used for managing the [car] plate information.
  TextEditingController get controllerPlate => _controllerPlate;

  /// Used for managing the [car] brand information.
  TextEditingController get controllerBrand => _controllerBrand;

  /// Used for managing the [car] built year information.
  TextEditingController get controllerBuiltYear => _controllerBuiltYear;

  /// Used for managing the [car] model year information.
  TextEditingController get controllerModelYear => _controllerModelYear;

  /// Used for managing the price paid in [car] information.
  MoneyMaskedTextController get controllerPricePaid => _controllerPricePaid;

  /// Used for managing the [car] purschase date information.
  TextEditingController get controllerPurchaseDate => _controllerPurchaseDate;

  /// Used for managing the [car] photo information.
  String? get controllerPhoto => _controllerPhoto;

  /// Keeps a record of the a old [car] data
  Car? get oldCar => _oldCar;

  /// Used to load a list of [Car] objects
  List<Car> get listCar => _listCar;

  /// allows retrieve the value of a [_dealershipController].
  int? get dealershipController => _dealershipController;

  /// Sets up a focus listener.
  final modelFieldFocusNode = FocusNode();

  /// Sets up a focus listener.
  final brandFieldFocusNode = FocusNode();

  /// Variable is declared as a List of String.
  final allBrands = <String>[];

  /// Variable is also declared as a List of String.
  final allModels = <String>[];

  /// loads some data, retrieves [brand] names,
  /// listens for focus changes on a particular field,
  /// and performs actions accordingly.
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

  /// Sets a dealership controller to the user's [ID], then loads some data
  void setDealership(User user) async {
    _dealershipController = user.id!;
    await loadData();

    notifyListeners();
  }

  /// Return a list of [brand] names as strings.
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

  /// Retrieves a list of [car models] for a given brand, extracts their names,
  /// and returns them as a list of strings.
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

  /// Used to insert a new [car] in dataBase.
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

  /// Fetches a list of [cars] based on the [user's] id and updates
  /// the list displayed in the screen.
  Future<void> loadData() async {
    final list = <Car>[];
    if (loggedUser.id != 1) {
      list.addAll(await controller.selectByDealership(loggedUser.id!));
    } else {
      list.addAll(await controller.select());
    }

    listCar.clear();
    listCar.addAll(list);

    notifyListeners();
  }

  /// Delete a [Car].
  Future<void> delete(Car car) async {
    await controller.delete(car);
    await loadData();

    notifyListeners();
  }

  /// Updates the internal text controllers with the values
  /// from the [car] object and creates an _oldCar object
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

  /// This function is used to update information related to a [Car] object.
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

  /// picking an image from the gallery, updating the [_controllerPhoto]
  /// with the selected image's path,
  Future pickImage() async {
    {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;

      _controllerPhoto = image.path;
    }
    notifyListeners();
  }

  /// used to take a photo using the device's camera,
  /// updating the [_controllerPhoto] with the selected image's path,
  Future takePhoto() async {
    {
      final image = await ImagePicker().pickImage(source: ImageSource.camera);
      if (image == null) return;

      _controllerPhoto = image.path;
      notifyListeners();
    }
  }
}
