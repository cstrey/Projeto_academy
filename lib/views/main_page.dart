import 'package:flutter/material.dart';
import 'permanence/carousel.dart';
import 'permanence/menu_drawer.dart';
import 'permanence/text_apresentation.dart';

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
      body: Column(
        children: [
          const Carousel(),
          Padding(
            padding: const EdgeInsets.all(32.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                gradient: const LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [
                    Color(0xff00456A),
                    Color(0xff051937),
                  ],
                ),
              ),
              child: const TextPattern(),
            ),
          ),
        ],
      ),
    );
  }
}
