abstract class LoginPresenter {
  Stream get emailErrorStream;
  Stream get passwordErrorStream;
  Stream get ifFormValidStream;
  Stream get ifLoadingStream;
  Stream get mainErrorStream;

  void validateEmail(String email);
  void validatePassword(String password);
  void auth();
}
