import 'package:ForDev/ui/helpers/helpers.dart';

enum UiError {
  requiredField, 
  invalidField,
  unexpected,
  invalidCredentials,
  emailInUse
}

extension UiErrorExtension on UiError {
  String get description {
    switch(this) {
      case UiError.requiredField: return R.strings.msgRequiredField;
      case UiError.invalidField: return R.strings.msgInvalidField;
      case UiError.invalidCredentials: return R.strings.msgInvalidCredential;
      case UiError.emailInUse: return R.strings.msgEmailInUse;

      default: return R.strings.msgUnexpecteddError;
    }
  }
}