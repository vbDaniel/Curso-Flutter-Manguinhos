import 'package:ForDev/ui/helpers/errors/ui_error.dart';

abstract class SignUpPresenter {
  Stream<UiError> get emailErrorStream;
  Stream<UiError> get passwordErrorStream;
  Stream<UiError> get nameErrorStream;
  Stream<UiError> get passwordConfirmationErrorStream;

  void validateName(String name);
  void validateEmail(String email);
  void validatePassword(String password);
  void validatePasswordConfirmation(String passwordConfirmation);
}
