import 'package:flutter/material.dart';
import 'package:form_validator/form_validator.dart';

final emailValidator = ValidationBuilder(localeName: 'pl').email().build();
final basicValidator = ValidationBuilder(localeName: 'pl')
    .add(
      (value) => value.toString().trim().isEmpty
          ? "To pole nie może zawierać samych spacji"
          : null,
    )
    .build();
String? Function(String?) createPasswordValidator(
    TextEditingController passwordController) {
  return ValidationBuilder(localeName: 'pl')
      .minLength(8)
      .add((value) {
        return value == passwordController.text
            ? null
            : 'Hasła muszą być takie same';
      })
      .add(
        (value) => value.toString().contains((' '))
            ? "Hasło nie może zawierać spacji"
            : null,
      )
      .build();
}
