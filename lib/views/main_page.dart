import 'package:flutter/material.dart';
import 'carousel.dart';
import 'permanence/menu.dart';

class MainPage extends StatelessWidget {
  const MainPage({
    super.key,
  });

  final String title = 'Anderson Automóveis';

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
        children: [
          Carousel(),
        ],
      ),
    );
  }
}
