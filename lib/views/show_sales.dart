import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../controller/main_controller.dart';
import '../controller/sales_controller.dart';
import '../models/sales.dart';
import 'register_cars.dart';
import 'utils/menu_drawer.dart';

class ShowSales extends StatelessWidget {
  const ShowSales({
    super.key,
    this.sale,
  });

  final String title = 'Anderson Automóveis';
  final Sale? sale;

  @override
  Widget build(BuildContext context) {
    final numberFormatter = NumberFormat('###,###,###.00');
    final state = Provider.of<MyState>(context);
    return ChangeNotifierProvider(
      create: (context) => SaleState(state.loggedUser!),
      child: Consumer<SaleState>(
        builder: (context, stateSale, value) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.transparent,
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
              title: Text(title),
            ),
            body: stateSale.loading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : ListView.builder(
                    itemCount: stateSale.listSale.length,
                    itemBuilder: (context, index) {
                      final sale = stateSale.listSale[index];
                      return ListTile(
                        title: Text(
                          '${sale.businessCut}'
                          ' ${sale.dealershipCut}'
                          ' ${sale.safetyCut}',
                        ),
                        subtitle: Text(
                          'R\$${numberFormatter.format(sale.priceSold)}',
                        ),
                        trailing: IntrinsicWidth(
                          child: Row(
                            children: [
                              IconButton(
                                onPressed: () async {
                                  stateSale.updateSale(sale);
                                  await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          ChangeNotifierProvider.value(
                                        value: stateSale,
                                        child: const RegisterCarsPage(),
                                      ),
                                    ),
                                  );
                                },
                                icon: const Icon(
                                  Icons.edit,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
            drawer: const DrawerMenu(),
          );
        },
      ),
    );
  }
}
