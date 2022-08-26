import 'package:equatable/equatable.dart';

import '../../presentation/protocols/validation.dart';
import '../protocols/protocols.dart';

class RequiredFieldValidation extends Equatable implements FieldValidation {
  final String field;

  List get props => [this.field];

  RequiredFieldValidation(this.field);

  ValidationError validate(String value) {
    return value?.isNotEmpty == true ? null : ValidationError.requiredField;
  }
}
