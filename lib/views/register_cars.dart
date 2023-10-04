import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controller/cars_controller.dart';
import '../models/user.dart';
import 'show_cars.dart';
import 'utils/auto_complete.dart';
import 'utils/choose_take_photo.dart';
import 'utils/form.dart';
import 'utils/header.dart';
import 'utils/menu_drawer.dart';
import 'utils/photo_list.dart';

class RegisterCarsPage extends StatelessWidget {
  const RegisterCarsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final userlogged = ModalRoute.of(context)!.settings.arguments as User;
    final stateCar = Provider.of<CarState>(context);
    stateCar.setLoggedUser(userlogged);
    return Scaffold(
      appBar: AppBar(
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
        title: const Text('Registre Seu Veículo'),
      ),
      drawer: const DrawerMenu(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: stateCar.formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const AppHeader(header: 'Brand'),
                const Padding(
                  padding: EdgeInsets.only(
                    top: 8,
                    bottom: 8,
                  ),
                  child: _BrandTextField(),
                ),
                const AppHeader(header: 'Model'),
                const Padding(
                  padding: EdgeInsets.only(
                    top: 8,
                    bottom: 8,
                  ),
                  child: _ModelTextField(),
                ),
                const AppHeader(header: 'Plate'),
                const Padding(
                  padding: EdgeInsets.only(
                    top: 8,
                    bottom: 8,
                  ),
                  child: _PlateTextField(),
                ),
                const AppHeader(header: 'Built Year'),
                const Padding(
                  padding: EdgeInsets.only(
                    top: 8,
                    bottom: 8,
                  ),
                  child: _BuiltYearTextField(),
                ),
                const AppHeader(header: 'Model Year'),
                const Padding(
                  padding: EdgeInsets.only(
                    top: 8,
                    bottom: 8,
                  ),
                  child: _ModelYearTextField(),
                ),
                const AppHeader(header: 'Price'),
                const Padding(
                  padding: EdgeInsets.only(
                    top: 8,
                    bottom: 8,
                  ),
                  child: _PriceTextField(),
                ),
                const AppHeader(header: 'Date of purchase'),
                const Padding(
                  padding: EdgeInsets.only(
                    top: 8,
                    bottom: 8,
                  ),
                  child: _DateTextField(),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 8,
                    bottom: 8,
                  ),
                  child: stateCar.controllerPhoto != null
                      ? const PhotosList()
                      : Container(),
                ),
                const Padding(
                  padding: EdgeInsets.only(
                    top: 8,
                    bottom: 8,
                  ),
                  child: ChooseOrTakePhoto(),
                ),
                ElevatedButton(
                  onPressed: () async {
                    if (stateCar.oldCar != null) {
                      stateCar.updateCar;
                      await stateCar.update();
                    } else {
                      await stateCar.insert();
                    }
                    if (context.mounted) {
                      await Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ShowCars(),
                        ),
                      );
                    }
                  },
                  child: const Text('Cadastrar'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _BrandTextField extends StatelessWidget {
  const _BrandTextField();

  String? validator(String? value) {
    if (value!.isEmpty) {
      return "Please inform the vehicle's brand";
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final stateCar = Provider.of<CarState>(context, listen: true);
    return AppTextFieldAutoComplete(
      controller: stateCar.controllerBrand,
      validator: validator,
      focusNode: stateCar.brandFieldFocusNode,
      suggestions: stateCar.allBrands,
    );
  }
}

class _ModelTextField extends StatelessWidget {
  const _ModelTextField();

  String? validator(String? value) {
    if (value!.isEmpty) {
      return 'Informe o modelo do veículo';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final stateCar = Provider.of<CarState>(context, listen: true);
    return AppTextFieldAutoComplete(
      controller: stateCar.controllerModel,
      validator: validator,
      focusNode: stateCar.modelFieldFocusNode,
      suggestions: stateCar.allModels,
    );
  }
}

class _PlateTextField extends StatelessWidget {
  const _PlateTextField();

  String? validator(String? value) {
    if (value!.isEmpty) {
      return 'Informe a placa do veículo';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final stateCar = Provider.of<CarState>(context, listen: true);
    return AppTextField(
      controller: stateCar.controllerPlate,
      validator: validator,
      hint: 'QTP5F71',
    );
  }
}

class _BuiltYearTextField extends StatelessWidget {
  const _BuiltYearTextField();

  String? validator(String? value) {
    if (value!.isEmpty) {
      return 'Informe o ano que o veiculo foi fabricado';
    }
    if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
      return 'digite apenas números';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final stateCar = Provider.of<CarState>(context, listen: true);
    return AppTextField(
      controller: stateCar.controllerBuiltYear,
      validator: validator,
      hint: '2022',
    );
  }
}

class _ModelYearTextField extends StatelessWidget {
  const _ModelYearTextField();

  String? validator(String? value) {
    if (value!.isEmpty) {
      return 'Informe o ano do modelo do veículo';
    }
    if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
      return 'digite apenas números';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final stateCar = Provider.of<CarState>(context, listen: true);
    return AppTextField(
      controller: stateCar.controllerModelYear,
      validator: validator,
      hint: '2023',
    );
  }
}

class _PriceTextField extends StatelessWidget {
  const _PriceTextField();

  String? validator(String? value) {
    if (double.parse((value!.replaceAll(RegExp(r','), ''))) == 0.00) {
      return 'Preço não pode ser zero';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final stateCar = Provider.of<CarState>(context, listen: true);
    return AppTextField(
      controller: stateCar.controllerPricePaid,
      validator: validator,
      inputType: const TextInputType.numberWithOptions(decimal: true),
    );
  }
}

class _DateTextField extends StatelessWidget {
  const _DateTextField();

  String? validator(String? value) {
    if (value!.isEmpty) {
      return 'Informe a data correta';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final stateCar = Provider.of<CarState>(context, listen: true);
    return AppTextField(
      controller: stateCar.controllerPurchaseDate,
      validator: validator,
      hint: '12/12/2012',
      inputType: TextInputType.datetime,
    );
  }
}
