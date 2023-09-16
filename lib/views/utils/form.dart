import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class FormPattern extends StatelessWidget {
  final String labelText;
  final TextEditingController controler;
  final TextInputType keyboardType;
  final String? Function(String?) validator;
  final bool? obscureText;
  final MaskTextInputFormatter? mask;

  const FormPattern({
    super.key,
    required this.controler,
    required this.labelText,
    required this.keyboardType,
    required this.validator,
    this.obscureText,
    this.mask,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        controller: controler,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: labelText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
        ),
        inputFormatters: (mask != null) ? [mask!] : null,
        validator: validator,
      ),
    );
  }
}