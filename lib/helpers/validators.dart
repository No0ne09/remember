import 'package:form_validator/form_validator.dart';

final emailValidator = ValidationBuilder(localeName: 'pl').email().build();
final usernameValidator = ValidationBuilder(localeName: 'pl').build();
final registerPasswordValidator = ValidationBuilder(localeName: 'pl').build();
