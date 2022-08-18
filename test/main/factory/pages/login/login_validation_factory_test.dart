import 'package:ForDev/main/factories/pages/pages.dart';

import 'package:ForDev/validation/validators/validators.dart';
import 'package:test/test.dart';

void main() {
  test('Should return the correct validation', () {
    final validations = makeLoginValidations();

    expect(validations, [
      RequiredFieldValidation('email'),
      EmailValidation('email'),
      RequiredFieldValidation('password')
    ]);
  });
}
