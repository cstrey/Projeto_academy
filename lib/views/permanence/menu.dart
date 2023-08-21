import 'package:flutter/material.dart';
import 'package:projeto_lince/main.dart';
import 'package:provider/provider.dart';

class DrawerMenu extends StatelessWidget {
  //dados que vem do banco de dados
  final String shopName;
  final String cnpj;
  final String profilePicture;

  const DrawerMenu(
      {super.key,
      required this.shopName,
      required this.cnpj,
      required this.profilePicture});

  Text showTittle(String texto) {
    return Text(
      texto,
      style: const TextStyle(fontSize: 18),
    );
  }

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<MyState>(context);
    return Drawer(
      child: Center(
        child: ListView(
          children: [
            //informações do usuario
            UserAccountsDrawerHeader(
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
              accountName: Text(shopName),
              accountEmail: Text(cnpj),
              currentAccountPicture: CircleAvatar(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(40),
                  child: const Icon(Icons.account_circle),
                ),
              ),
            ),
            //home
            ListTile(
              title: showTittle('Home'),
              subtitle: const Text('Pagina Inicial'),
              leading: const Icon(Icons.home),
              iconColor: mainColor,

              //ir para a Home
              onTap: () {},
            ),

            //Gerencia
            ListTile(
              title: showTittle('Gerenciar'),
              subtitle: const Text('Gerenciar Vendas'),
              leading: const Icon(Icons.sell),
              iconColor: mainColor,

              //ir para a gerencia de vendas
              onTap: () {},
            ),

            //configurações
            ListTile(
              title: showTittle('Configurações'),
              subtitle: const Text('Fazer ajustes na conta'),
              leading: const Icon(Icons.brightness_7),
              iconColor: mainColor,

              //ir para a Configuraçoes
              onTap: () {},
            ),

            //logout
            ListTile(
              title: showTittle('Logout'),
              subtitle: const Text('Sair do aplicativo'),
              leading: const Icon(Icons.logout),
              iconColor: mainColor,

              //ir para a pagina inicial
              onTap: () {},
            ),
            IconButton(
              alignment: Alignment.bottomLeft,
              onPressed: () => state.toggleTheme(),
              icon: Icon(
                state.ligthMode ? Icons.dark_mode : Icons.light_mode,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
