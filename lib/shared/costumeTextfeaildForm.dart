// ignore_for_file: file_names, camel_case_types, non_constant_identifier_names

import 'package:flutter/material.dart';

class myTextfeaildForm extends StatelessWidget {
  final FormFieldValidator<String>? validator;
  final FormFieldSetter<String>? OnSaved;
  final TextInputType KeyboardType;
  final InputBorder? border;
  final double heighFactor;
  final double WidthFactor;
  final EdgeInsets? contentPadding;
  final double? paddingHorizontalFactor;
  final double? paddingVerticalFactor;
  final TextEditingController? controller;
  const myTextfeaildForm({
    super.key,
    this.validator,
    required this.OnSaved,
    this.KeyboardType = TextInputType.text,
    this.border,
    this.heighFactor = 0.07,
    this.WidthFactor = 0.9,
    this.contentPadding,
    this.paddingHorizontalFactor,
    this.paddingVerticalFactor,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final EdgeInsets calculatedPadding = contentPadding ??
        EdgeInsets.symmetric(
          horizontal: (paddingHorizontalFactor ?? 0.003) * screenHeight,
          vertical: (paddingVerticalFactor ?? 0.017) * screenWidth,
        );
    return SizedBox(
      height: screenHeight * heighFactor,
      width: screenWidth * WidthFactor,
      child: TextFormField(
        controller: controller,
        keyboardType: KeyboardType,
        decoration: InputDecoration(
          enabledBorder: border ??
              const UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.grey),
              ),
          focusedBorder: border ??
              const UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.grey),
              ),
          errorBorder: border ??
              const UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.red),
              ),
          focusedErrorBorder: border ??
              const UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.red),
              ),
          contentPadding: calculatedPadding,
          /*EdgeInsets.symmetric(
              horizontal: screenHeight * 0.003, vertical: screenWidth * 0.017),*/
        ),
        validator: validator,
        onSaved: OnSaved,
      ),
    );
  }
}
