import 'package:flutter_test/flutter_test.dart';
import 'package:treinamento_flutter/validation/protocols/field_validation.dart';

class EmailValidation implements FieldValidation {
  final String field;

  EmailValidation(this.field);

  String validate(String value) {
    return null;
  }
}

void main() {
  test('Should return null if email is empty', () {
    final sut = EmailValidation('any_field');

    expect(sut.validate(''), null);
  });

   test('Should return null if email is null', () {
    final sut = EmailValidation('any_field');

    expect(sut.validate(null), null);
  });
}
