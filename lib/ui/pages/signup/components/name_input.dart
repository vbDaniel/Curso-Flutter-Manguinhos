import '../../../helpers/helpers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../signup_presenter.dart';

class NameInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final presenter = Provider.of<SignUpPresenter>(context);
    return TextFormField(
          decoration: InputDecoration(
            labelText: R.strings.name,
            icon: Icon(Icons.person, color: Theme.of(context).primaryColorLight),
            errorText:  null,
          ),
          keyboardType: TextInputType.name,
          onChanged: presenter.validateEmail,
      );
  }
}