import 'package:flutter/material.dart';

class FieldForm extends StatelessWidget {
  String label;
  bool isPasword;
  TextEditingController controller;
  bool? isForm = true;

  FieldForm(
      {
      required this.label,
      required this.isPasword,
      required this.controller,
      this.isForm,
      super.key
    }
  );

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enabled: this.isForm,
      obscureText: isPasword,
      controller: controller,
      decoration: InputDecoration(
      filled: true, fillColor: Colors.white, labelText: label),
    );
  }
}
