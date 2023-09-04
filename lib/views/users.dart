import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controller/db_controller.dart';
import 'permanence/menu.dart';

class ShowUsers extends StatelessWidget {
  const ShowUsers({
    super.key,
  });

  final String title = 'Anderson Automóveis';

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => UserState(),
      child: Consumer<UserState>(
        builder: (_, stateUser, __) {
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
            body: ListView.builder(
              itemCount: stateUser.listUser.length,
              itemBuilder: (context, index) {
                final user = stateUser.listUser[index];
                return ListTile(
                  leading: Text(user.id.toString()),
                  title: Text(user.name),
                  subtitle: Text(user.cnpj.toString()),
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
