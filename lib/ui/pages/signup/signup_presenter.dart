import 'package:ForDev/ui/helpers/errors/ui_error.dart';

abstract class SignUpPresenter {
  Stream<UiError> get emailErrorStream;
  Stream<UiError> get passwordErrorStream;
  Stream<UiError> get nameErrorStream;
  Stream<UiError> get passwordConfirmationErrorStream;
  Stream<UiError> get mainErrorStream;
  Stream<bool> get isFormValidStream;
  Stream<bool> get isLoadingStream;
  Stream<String> get navigateToStream;

  void validateName(String name);
  void validateEmail(String email);
  void validatePassword(String password);
  void validatePasswordConfirmation(String passwordConfirmation);

  Future<void> signUp();
}
