import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:faker/faker.dart';
import 'package:mockito/mockito.dart';

import 'package:treinamento_flutter/ui/pages/login/login_pages.dart';
import 'package:treinamento_flutter/ui/pages/login/login_presenter.dart';

class LoginPresenterSpy extends Mock implements LoginPresenter {}

void main() {
  LoginPresenter presenter;
  StreamController<String> emailErrorController;
  StreamController<String> passwordErrorController;
  StreamController<bool> ifFormValidErrorController;
  StreamController<bool> ifLoadingController;

  Future<void> loadPage(WidgetTester tester) async {
    presenter = LoginPresenterSpy();

    emailErrorController = StreamController<String>();
    passwordErrorController = StreamController<String>();
    ifFormValidErrorController = StreamController<bool>();
    ifLoadingController = StreamController<bool>();

    when(presenter.emailErrorStream)
        .thenAnswer((_) => emailErrorController.stream);
    when(presenter.passwordErrorStream)
        .thenAnswer((_) => passwordErrorController.stream);
    when(presenter.ifFormValidStream)
        .thenAnswer((_) => ifFormValidErrorController.stream);
    when(presenter.ifLoadingStream)
        .thenAnswer((_) => ifLoadingController.stream);

    final loginPage = MaterialApp(home: LoginPage(presenter));
    await tester.pumpWidget(loginPage);
  }

  tearDown(() {
    emailErrorController.close();
    passwordErrorController.close();
    ifFormValidErrorController.close();
    ifLoadingController.close();
  });
  testWidgets('Should load with correct initial state',
      (WidgetTester tester) async {
    await loadPage(tester);

    final emailTextChildren = find.descendant(
        of: find.bySemanticsLabel('Email'), matching: find.byType(Text));
    expect(emailTextChildren, findsOneWidget,
        reason:
            'When a TextFormField has only one text child means it has no errors, since one of childs is always the label text');

    final passwordTextChildren = find.descendant(
        of: find.bySemanticsLabel('Senha'), matching: find.byType(Text));
    expect(emailTextChildren, findsOneWidget,
        reason:
            'When a TextFormField has only one text child means it has no errors, since one of childs is always the label text');

    final button = tester.widget<RaisedButton>(find.byType(RaisedButton));
    expect(button.onPressed, null);

    expect(find.byType(CircularProgressIndicator), findsNothing);
  });

  testWidgets('Shoul call validate with correct values',
      (WidgetTester tester) async {
    await loadPage(tester); //carrega a tela

    final email = faker.internet.email();
    await tester.enterText(find.bySemanticsLabel('Email'), email);
    verify(presenter.validateEmail(email));

    final password = faker.internet.password();
    await tester.enterText(find.bySemanticsLabel('Senha'), password);
    verify(presenter.validatePassword(password));
  });

  testWidgets('Shoul present error id email is invalid',
      (WidgetTester tester) async {
    await loadPage(tester);

    emailErrorController.add('any error');
    await tester.pump(); //força uma renderizacao nos componetes necessarios

    expect(find.text('any error'), findsOneWidget);
  });

  testWidgets('Shoul present no error id email is invalid',
      (WidgetTester tester) async {
    await loadPage(tester);

    emailErrorController.add(null);
    await tester.pump(); //força uma renderizacao nos componetes necessarios

    expect(
      find.descendant(
          of: find.bySemanticsLabel('Email'), matching: find.byType(Text)),
      findsOneWidget,
    );
  });
  testWidgets('Shoul present no error id email is invalid',
      (WidgetTester tester) async {
    await loadPage(tester);

    emailErrorController.add('');
    await tester.pump(); //força uma renderizacao nos componetes necessarios

    expect(
      find.descendant(
          of: find.bySemanticsLabel('Email'), matching: find.byType(Text)),
      findsOneWidget,
    );
  });

  testWidgets('Shoul present no error id password is invalid',
      (WidgetTester tester) async {
    await loadPage(tester);

    passwordErrorController.add('any error');
    await tester.pump(); //força uma renderizacao nos componetes necessarios

    expect(find.text('any error'), findsOneWidget);
  });

  testWidgets('Shoul present no error id password is invalid',
      (WidgetTester tester) async {
    await loadPage(tester);

    passwordErrorController.add(null);
    await tester.pump(); //força uma renderizacao nos componetes necessarios

    expect(
      find.descendant(
          of: find.bySemanticsLabel('Senha'), matching: find.byType(Text)),
      findsOneWidget,
    );
  });
  testWidgets('Shoul present no error id password is invalid',
      (WidgetTester tester) async {
    await loadPage(tester);

    passwordErrorController.add('');
    await tester.pump(); //força uma renderizacao nos componetes necessarios

    expect(
      find.descendant(
          of: find.bySemanticsLabel('Senha'), matching: find.byType(Text)),
      findsOneWidget,
    );
  });

  testWidgets('Shoul enable form button is form valid',
      (WidgetTester tester) async {
    await loadPage(tester);

    ifFormValidErrorController.add(true);
    await tester.pump(); //força uma renderizacao nos componetes necessarios

    expect(tester.widget<RaisedButton>(find.byType(RaisedButton)).onPressed,
        isNotNull);
  });

  testWidgets('Shoul enable form button is form valid',
      (WidgetTester tester) async {
    await loadPage(tester);

    ifFormValidErrorController.add(false);
    await tester.pump(); //força uma renderizacao nos componetes necessarios

    expect(
        tester.widget<RaisedButton>(find.byType(RaisedButton)).onPressed, null);
  });

  testWidgets('Shoul call authentication on form submit ',
      (WidgetTester tester) async {
    await loadPage(tester);

    ifFormValidErrorController.add(true);

    await tester.pump(); //força uma renderizacao nos componetes necessarios
    await tester.tap(find.byType(RaisedButton));
    await tester.pump();

    verifyNever(presenter.auth()); //possivel nova formataçao verificar dps
  });

  testWidgets('Shoul present loading', (WidgetTester tester) async {
    await loadPage(tester);

    ifLoadingController.add(true);
    await tester.pump(); //força uma renderizacao nos componetes necessarios

    expect(
      find.byType(CircularProgressIndicator),
      findsOneWidget,
    );
  });


  testWidgets('Shoul hide loading', (WidgetTester tester) async {
    await loadPage(tester);

    ifLoadingController.add(true);
    await tester.pump();
    ifLoadingController.add(false);
    await tester.pump(); //força uma renderizacao nos componetes necessarios

    expect(
      find.byType(CircularProgressIndicator),
      findsNothing,
    );
  });
}

