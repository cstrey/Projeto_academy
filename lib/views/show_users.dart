import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controller/user_controller.dart';
import 'register_page.dart';
import 'utils/menu_drawer.dart';

class ShowUsers extends StatelessWidget {
  const ShowUsers({
    super.key,
  });

  final String title = 'Anderson Automóveis';

  @override
  Widget build(BuildContext context) {
    final stateUser = Provider.of<UserState>(context);
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
            title: Text(user.name),
            subtitle: Text(user.cnpj.toString()),
            trailing: IntrinsicWidth(
              child: Row(
                children: [
                  IconButton(
                    onPressed: () async {
                      stateUser.updateUser(user);
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ChangeNotifierProvider.value(
                            value: stateUser,
                            child: const RegisterPage(),
                          ),
                        ),
                      );
                    },
                    icon: const Icon(
                      Icons.edit,
                    ),
                  ),
                  IconButton(
                    onPressed: () async {
                      await stateUser.delete(user);
                    },
                    icon: const Icon(
                      Icons.delete,
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
  }
}
