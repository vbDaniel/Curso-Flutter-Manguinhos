import 'dart:async';

import 'package:ForDev/ui/helpers/errors/ui_error.dart';
import 'package:get/state_manager.dart';
import 'package:meta/meta.dart';

import '../protocols/protocols.dart';

class GetxSigUpPresenter extends GetxController {
  final Validation validation;

  var _nameError = Rx<UiError>();
  var _emailError = Rx<UiError>();
  var _passwordError = Rx<UiError>();
  var _passwordConfimationError = Rx<UiError>();
  var _isFormValid = false.obs;

  Stream<UiError> get nameErrorStream => _nameError.stream;
  Stream<UiError> get emailErrorStream => _emailError.stream;
  Stream<UiError> get passwordErrorStream => _passwordError.stream;
  Stream<UiError> get passwordConfirmationErrorStream => _passwordConfimationError.stream;

  Stream<bool> get isFormValidStream => _isFormValid.stream;

  GetxSigUpPresenter({
    @required this.validation,
  });

  void validateEmail(String email) {
    _emailError.value = _validateField(field: 'email', value: email);
    _validateForm();
  }

  void validateName(String name) {
    _nameError.value = _validateField(field: 'name', value: name);
    _validateForm();
  }

  void validatePassword(String password) {
    _passwordError.value = _validateField(field: 'password', value: password);
    _validateForm();
  }

   void validatePasswordConfirmation(String password) {
    _passwordConfimationError.value = _validateField(field: 'password', value: password);
    _validateForm();
  }

  UiError _validateField({String field, String value}) {
    final error = validation.validate(field: field, value: value);
    switch (error) {
      case ValidationError.invalidField:
        return UiError.invalidField;
      case ValidationError.requiredField:
        return UiError.requiredField;
      default:
        return null;
    }
  }

  void _validateForm() {
    _isFormValid.value = false;
  }
}
