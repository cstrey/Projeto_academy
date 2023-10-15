import 'package:flutter/material.dart';

/// Declaration of a widget class named [AppTextField]
/// that extends StatelessWidget.
class AppTextField extends StatelessWidget {
  /// Define a constructor [AppTextField].
  const AppTextField({
    super.key,
    required this.controller,
    required this.validator,
    this.inputType,
    this.hint,
    this.icon,
    this.obscureText,
    this.obscureTextButton,
    this.readOnly,
  });

  /// Declares a final variable [controller] that is
  /// expected to hold a TextEditingController.
  final TextEditingController controller;

  /// Declares a final variable [inputType] that is
  /// expected to hold a TextInputType.
  final TextInputType? inputType;

  /// Declares a final variable [hint] that is
  /// expected to hold a String.
  final String? hint;

  /// Declares a final variable [validator] that is
  /// expected to hold a String that can be null.
  final String? Function(String?)? validator;

  /// Declares a final variable [icon] that is
  /// expected to hold a Icon that can be null.
  final Icon? icon;

  /// Declares a final variable [obscureText] that is
  /// expected to hold a bool that can be null.
  final bool? obscureText;

  /// Declares a final variable [obscureTextButton] that is
  /// expected to hold a IconButton that can be null.
  final IconButton? obscureTextButton;

  /// Declares a final variable [readOnly] that is
  /// expected to hold a bool that can be null.
  final bool? readOnly;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText ?? false,
      keyboardType: inputType ?? TextInputType.text,
      readOnly: readOnly ?? false,
      decoration: InputDecoration(
        hintText: hint ?? 'Digite aqui',
        prefixIcon: icon,
        suffixIcon: obscureTextButton,
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
        ),
      ),
      validator: validator,
    );
  }
}
