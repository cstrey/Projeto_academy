import 'package:flutter/material.dart';

/// Declaration of a widget class named [AppHeader]
/// that extends StatelessWidget.
class AppHeader extends StatelessWidget {
  /// Define a constructor [AppHeader].
  const AppHeader({
    super.key,
    required this.header,
    this.fontWeight,
    this.fontSize,
  });

  /// Declares a final variable [header] that is
  /// expected to hold a String.
  final String header;

  /// Declares a final variable [fontWeight] that is
  /// expected to hold a FontWeight can be null.
  final FontWeight? fontWeight;

  /// Declares a final variable [fontSize] that is
  /// expected to hold a double can be null.
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
