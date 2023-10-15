import 'package:flutter/material.dart';
import '../main.dart';
import 'utils/carousel.dart';
import 'utils/menu_drawer.dart';
import 'utils/text_apresentation.dart';

/// Declaration of a widget class named [MainPage]
/// that extends StatelessWidget.
class MainPage extends StatelessWidget {
  /// Define a constructor [MainPage].
  const MainPage({
    super.key,
  });

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
        title: const Text(title),
      ),
      drawer: const DrawerMenu(),
      body: SingleChildScrollView(
        child: Column(
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
                )),
          ],
        ),
      ),
    );
  }
}
