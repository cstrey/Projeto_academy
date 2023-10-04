import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controller/sales_controller.dart';
import '../models/user.dart';
import 'show_users.dart';
import 'utils/form.dart';
import 'utils/header.dart';
import 'utils/menu_drawer.dart';

class RegisterSalePage extends StatelessWidget {
  const RegisterSalePage({super.key});

  @override
  Widget build(BuildContext context) {
    final userlogged = ModalRoute.of(context)!.settings.arguments as User;
    final stateSale = Provider.of<SaleState>(context);
    stateSale.setLoggedUser(userlogged);
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
        title: const Text('Registre Uma Venda'),
      ),
      drawer: const DrawerMenu(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: stateSale.formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const AppHeader(header: 'Nome do comprador'),
                const Padding(
                  padding: EdgeInsets.all(8),
                  child: _NameTextField(),
                ),
                const AppHeader(header: 'CPF do comprador'),
                const Padding(
                  padding: EdgeInsets.all(8),
                  child: _CpfTextField(),
                ),
                const AppHeader(header: 'Sold Date'),
                const Padding(
                  padding: EdgeInsets.all(8),
                  child: _DateTextField(),
                ),
                const AppHeader(header: 'Valor da Venda'),
                const Padding(
                  padding: EdgeInsets.all(8),
                  child: _PriceTextField(),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () async {
                      if (stateSale.formKey.currentState!.validate()) {
                        return;
                      }
                      if (stateSale.oldSale != null) {
                        stateSale.updateSale;
                        await stateSale.update();
                      } else {
                        await stateSale.insert();
                      }
                      if (context.mounted) {
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ShowUsers(),
                          ),
                        );
                      }
                    },
                    child: const Text('Cadastrar'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _NameTextField extends StatelessWidget {
  const _NameTextField();

  String? validator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor, informe um nome válido.';
    } else if (value.length > 120) {
      return 'Nome deve ter menos de 120 caracteres';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final stateSale = Provider.of<SaleState>(context);
    return AppTextField(
      controller: stateSale.controllerCustumerName,
      validator: validator,
      hint: 'Anderson',
    );
  }
}

class _CpfTextField extends StatelessWidget {
  const _CpfTextField();

  String? validator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor, informe um CNPJ válido.';
    } else if (value.length < 14 || value.length > 14) {
      return 'cpf deve conter 11 digitos';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final stateSale = Provider.of<SaleState>(context);
    return AppTextField(
      controller: stateSale.controllerCustomerCpf,
      validator: validator,
      hint: '541.245.270-12',
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
    final stateSale = Provider.of<SaleState>(context, listen: true);
    return AppTextField(
      controller: stateSale.controllerSoldDate,
      validator: validator,
      hint: '12/12/2012',
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
    final stateSale = Provider.of<SaleState>(context, listen: true);
    return AppTextField(
      controller: stateSale.controllerPriceSold,
      validator: validator,
      inputType: const TextInputType.numberWithOptions(decimal: true),
    );
  }
}
