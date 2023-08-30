import 'package:flutter/material.dart';
import 'permanence/menu.dart';

class MainPage extends StatelessWidget {
  const MainPage({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
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
      drawer: const DrawerMenu(),
      body: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [],
      ),
    );
  }
}
