import 'package:flutter/material.dart';

class BaseTextFormField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final Function(String) validation;
  final bool isObscuredText;

  const BaseTextFormField({
    Key key,
    this.hintText,
    this.controller,
    this.validation,
    this.isObscuredText = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: isObscuredText,
      key: key,
      validator: (value) => validation(value),
      controller: controller,
      decoration: new InputDecoration(
          border: new OutlineInputBorder(
            borderRadius: const BorderRadius.all(
              const Radius.circular(30.0),
            ),
          ),
          filled: true,
          hintStyle: new TextStyle(
            color: Colors.grey[800],
          ),
          hintText: hintText,
          fillColor: Colors.white70),
    );
  }
}
