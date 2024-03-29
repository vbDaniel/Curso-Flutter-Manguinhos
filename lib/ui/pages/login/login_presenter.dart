import 'package:ForDev/ui/helpers/errors/ui_error.dart';



abstract class LoginPresenter {
  Stream<UiError> get emailErrorStream;
  Stream<UiError> get passwordErrorStream;
  Stream<UiError> get mainErrorStream;
  Stream<String> get navigationToStream;
  Stream<bool> get isFormValidStream;
  Stream<bool> get isLoadingStream;

  void validateEmail(String email);
  void validatePassword(String password);
  Future<void> auth();
  void dispose();
}