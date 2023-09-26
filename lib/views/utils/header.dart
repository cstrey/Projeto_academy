import 'package:flutter/material.dart';

class AppHeader extends StatelessWidget {
  const AppHeader({
    super.key,
    required this.header,
    this.fontWeight,
    this.fontSize,
  });

  final String header;
  final FontWeight? fontWeight;
  final double? fontSize;

  @override
  Widget build(BuildContext context) {
    return Text(
      header,
      textScaleFactor: fontSize ?? 1.2,
      style: TextStyle(
        fontWeight: fontWeight ?? FontWeight.w600,
      ),
    );
  }
}
