import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:provider/provider.dart';
import '../controller/cars_controller.dart';
import 'show_cars.dart';
import 'utils/choose_take_photo.dart';
import 'utils/form.dart';
import 'utils/menu_drawer.dart';
import 'utils/photo_list.dart';

class RegisterCarsPage extends StatelessWidget {
  const RegisterCarsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final stateCar = Provider.of<CarState>(context);
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
                FormPattern(
                  controler: stateCar.controllerModel,
                  labelText: 'Modelo do Veículo',
                  keyboardType: TextInputType.text,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, informe um modelo válido.';
                    }
                    return null;
                  },
                ),
                FormPattern(
                  controler: stateCar.controllerPlate,
                  labelText: 'Placa',
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, informe uma Placa válida.';
                    }
                    return null;
                  },
                ),
                FormPattern(
                  controler: stateCar.controllerBrand,
                  labelText: 'Marca',
                  keyboardType: TextInputType.text,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, informe uma Marca válida.';
                    }
                    return null;
                  },
                ),
                FormPattern(
                  controler: stateCar.controllerBuiltYear,
                  labelText: 'Ano de Fabricação',
                  keyboardType: TextInputType.text,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, informe um Ano válido.';
                    }
                    return null;
                  },
                ),
                FormPattern(
                  controler: stateCar.controllerModelYear,
                  labelText: 'Ano do Modelo',
                  keyboardType: TextInputType.text,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, informe um Ano válido.';
                    }
                    return null;
                  },
                ),
                FormPattern(
                  controler: stateCar.controllerPricePaid,
                  labelText: 'Preço Pago',
                  keyboardType: TextInputType.text,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, informe um Valor válido.';
                    }
                    return null;
                  },
                ),
                FormPattern(
                  controler: stateCar.controllerPurchaseDate,
                  labelText: 'Data da Compra',
                  keyboardType: TextInputType.text,
                  mask: MaskTextInputFormatter(mask: '##/##/####'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, informe uma Data válida.';
                    }
                    return null;
                  },
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
                    if (stateCar.formKey.currentState!.validate()) {
                      if (stateCar.oldCar != null) {
                        stateCar.updateCar;
                        await stateCar.update();
                      } else {
                        await stateCar.insert();
                      }
                      if (context.mounted) {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ShowCars(),
                          ),
                        );
                      }
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
