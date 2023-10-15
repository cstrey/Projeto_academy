import 'package:easy_autocomplete/easy_autocomplete.dart';
import 'package:flutter/material.dart';

/// Declaration of a widget class named [AppTextFieldAutoComplete]
/// that extends StatelessWidget.
class AppTextFieldAutoComplete extends StatelessWidget {
  /// Define a constructor [AppTextFieldAutoComplete].
  const AppTextFieldAutoComplete({
    required this.suggestions,
    required this.controller,
    this.validator,
    this.focusNode,
    super.key,
  });

  /// Declares a variable [suggestions] with the type List<String>.
  final List<String> suggestions;

  /// Declares a variable [controller] with the type TextEditingController.
  final TextEditingController controller;

  /// Declares a variable [validator] with the type String that can be null.
  final String? Function(String?)? validator;

  /// Declares a variable [focusNode] with the type FocusNode that can be null.
  final FocusNode? focusNode;

  @override
  Widget build(BuildContext context) {
    return EasyAutocomplete(
      suggestions: suggestions,
      validator: validator,
      focusNode: focusNode,
      onChanged: (value) => controller,
      controller: controller,
      decoration: const InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
        ),
      ),
    );
  }
}
