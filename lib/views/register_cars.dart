import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:provider/provider.dart';
import '../controller/cars_controller.dart';
import '../controller/theme_controller.dart';
import 'show_cars.dart';
import 'utils/form.dart';
import 'utils/menu_drawer.dart';

class RegisterCarsPage extends StatelessWidget {
  RegisterCarsPage({super.key});

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<MyState>(context);
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
        actions: [
          IconButton(
            onPressed: state.toggleTheme,
            icon: Icon(
              state.ligthMode ? Icons.dark_mode : Icons.light_mode,
            ),
          ),
        ],
      ),
      drawer: const DrawerMenu(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
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
                  controler: stateCar.controllerPhoto,
                  labelText: 'Foto',
                  keyboardType: TextInputType.text,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, informe uma Foto válida.';
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
                  mask: MaskTextInputFormatter(mask: '##/##/####/##:##:##'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, informe uma Data válida.';
                    }
                    return null;
                  },
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
                      Navigator.push(
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
