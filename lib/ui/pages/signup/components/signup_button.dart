import 'package:ForDev/ui/helpers/helpers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../signup_presenter.dart';

class SignUpButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final presenter = Provider.of<SignUpPresenter>(context);
    return RaisedButton(
          onPressed: null,
          child: Text(R.strings.addAccount.toUpperCase()),
      );
  }
}