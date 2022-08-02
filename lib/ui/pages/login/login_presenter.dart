abstract class LoginPresenter {
  Stream<String> get emailErrorStream;
  Stream<String> get passwordErrorStream;
  Stream<String> get mainErrorStream;
  Stream<bool> get ifFormValidStream;
  Stream<bool> get ifLoadingStream;

  void validateEmail(String email);
  void validatePassword(String password);
  Future<void> auth();
  void dispose();
}
