import 'package:ForDev/ui/helpers/helpers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../signup_presenter.dart';

class PasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final presenter = Provider.of<SignUpPresenter>(context);
    return  TextFormField(
          decoration: InputDecoration(
            labelText: R.strings.password,
            icon: Icon(Icons.lock, color: Theme.of(context).primaryColorLight),
            errorText: null,
          ),
          obscureText: true,
          onChanged: presenter.validatePassword,
      );
  }
}