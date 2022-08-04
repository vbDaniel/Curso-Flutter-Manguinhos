
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../login_presenter.dart';
import '../../pages.dart';

class EnterImput extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {

    final presenter = Provider.of<LoginPresenter>(context);

    return StreamBuilder<bool>(
      stream: presenter.ifFormValidStream,
      builder: (context, snapshot) {
        return RaisedButton(
          onPressed: snapshot.data == true
              ? presenter.auth
              : null,
          child: Text('Entrar'.toUpperCase()),
        );
      }
    );
  }
}