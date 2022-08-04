import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'login_presenter.dart';

import '../../components/components.dart';
import 'components/components.dart';

class LoginPage extends StatefulWidget {
  final LoginPresenter presenter;

  LoginPage(this.presenter);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  void dispose() {
    super.dispose();
    widget.presenter.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(
        builder: (context) {
          widget.presenter.ifLoadingStream.listen((isLoading) {
            if (isLoading) {
              showLoading(context);
            } else {
              hideLoading(context);
            }
          });

          widget.presenter.mainErrorStream.listen((error) {
            if (error != null) {
              showErrorMessage(context, error);
            }
          });

          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                LoginHeader(),
                HeadLine(
                  text: 'some text',
                ),
                Padding(
                  padding: const EdgeInsets.all(28.0),
                  child: Provider(
                    create: (_) => widget.presenter ,
                    child: Form(
                      child: Column(
                        children: [
                          EmailImput(),
                          Padding(
                            padding: const EdgeInsets.only(top: 8, bottom: 30),
                            child: PasswordImput(),
                          ),
                          EnterImput(),
                          FlatButton.icon(
                              onPressed: () {},
                              icon: Icon(Icons.person),
                              label: Text('Criar conta')),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}


