import 'package:flutter/material.dart';
import 'login_presenter.dart';

import '../../components/components.dart';

class LoginPage extends StatelessWidget {

  final LoginPresenter presenter;
  
  LoginPage(this.presenter);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            LoginHeader(),
            HeadLine(
              text: 'some text',
            ),
            Padding(
              padding: const EdgeInsets.all(28.0),
              child: Form(
                child: Column(
                  children: [
                    StreamBuilder<String>(
                      stream: presenter.emailErrorStream,
                      builder: (context, snapshot) {
                        return TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Email',
                            icon: Icon(
                              Icons.email,
                              color: Theme.of(context).primaryColorLight,
                            ),
                            errorText: (snapshot.data?.isEmpty) == true ? null : snapshot.data,
                          ),
                          keyboardType: TextInputType.emailAddress,
                          onChanged: presenter.validateEmail,
                        );
                      }
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8, bottom: 30),
                      child: 
                      StreamBuilder<String>(
                        stream: presenter.passwordErrorStream,
                        builder: (context, snapshot) {
                          return TextFormField(
                            decoration: InputDecoration(
                                labelText: 'Senha',
                                icon: Icon(Icons.lock, color: Theme.of(context).primaryColorLight),
                              errorText: snapshot.data,
                            ),
                            obscureText: true,
                            onChanged: presenter.validatePassword,
                          );
                        }
                      ),
                    ),
                    RaisedButton(
                      onPressed: null,
                      child: Text('Entrar'.toUpperCase()),
                    ),
                    FlatButton.icon(
                        onPressed: () {},
                        icon: Icon(Icons.person),
                        label: Text('Criar conta'))
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
