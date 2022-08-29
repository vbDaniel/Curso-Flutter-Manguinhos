import 'dart:async';

import 'package:ForDev/ui/helpers/errors/ui_error.dart';
import 'package:ForDev/ui/helpers/helpers.dart';
import 'package:ForDev/ui/pages/signup/signup.dart';
import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mockito/mockito.dart';


class SignUpPresenterSpy extends Mock implements SignUpPresenter {}

void main() {
  SignUpPresenter presenter;
  StreamController<UiError> nameErrorController;
  StreamController<UiError> emailErrorController;
  StreamController<UiError> passwordErrorController;
  StreamController<UiError> passwordConfirmationErrorController;

  void initStreams() {
    nameErrorController = StreamController<UiError>();
    emailErrorController = StreamController<UiError>();
    passwordErrorController = StreamController<UiError>();
    passwordConfirmationErrorController = StreamController<UiError>();
  }

  void mockStreams() {
    when(presenter.emailErrorStream)
        .thenAnswer((_) => emailErrorController.stream);
    when(presenter.passwordErrorStream)
        .thenAnswer((_) => passwordErrorController.stream);
    when(presenter.nameErrorStream)
        .thenAnswer((_) => nameErrorController.stream);
    when(presenter.passwordConfirmationErrorStream)
        .thenAnswer((_) => passwordConfirmationErrorController.stream);
  }

  void closeStreams() {
    nameErrorController.close();
    emailErrorController.close();
    passwordErrorController.close();
    passwordConfirmationErrorController.close();
  }

  Future<void> loadPage(WidgetTester tester) async {
    presenter = SignUpPresenterSpy();
    initStreams();
    mockStreams();
    final signUpPage = GetMaterialApp(
      initialRoute: '/signup',
      getPages: [
        GetPage(name: '/signup', page: () => SignUpPage(presenter)),
      ],
    );
    await tester.pumpWidget(signUpPage);
  }

  tearDown(() {
    closeStreams();
  });

  testWidgets('Should load with correct initial state',
      (WidgetTester tester) async {
    await loadPage(tester);

    final nameTextChildren = find.descendant(
      of: find.bySemanticsLabel(R.strings.name), 
      matching: find.byType(Text)
    );
    expect(
      nameTextChildren, 
      findsOneWidget,
      reason:'when a TextFormField has only one text child, means it has no errors, since one of the childs is always the label text'
    );


    final emailTextChildren = find.descendant(
      of: find.bySemanticsLabel(R.strings.email), 
      matching: find.byType(Text)
    );
    expect(emailTextChildren, findsOneWidget,
        reason:
            'when a TextFormField has only one text child, means it has no errors, since one of the childs is always the label text');

    final passwordTextChildren = find.descendant(
      of: find.bySemanticsLabel(R.strings.password),
      matching: find.byType(Text)
    );
    expect(
      passwordTextChildren, 
      findsOneWidget,
      reason: 'when a TextFormField has only one text child, means it has no errors, since one of the childs is always the label text'
    );

    final passwordConfirmationTextChildren = find.descendant(
      of: find.bySemanticsLabel(R.strings.confirmPassword), 
      matching: find.byType(Text)
    );
    expect(
      passwordConfirmationTextChildren, 
      findsOneWidget,
      reason:'when a TextFormField has only one text child, means it has no errors, since one of the childs is always the label text'
    );



    final button = tester.widget<RaisedButton>(find.byType(RaisedButton));
    expect(button.onPressed, null);
    expect(find.byType(CircularProgressIndicator), findsNothing);
  });

  testWidgets('Should call validate with correct values',
      (WidgetTester tester) async {
    await loadPage(tester);

    final name = faker.person.name();
    await tester.enterText(find.bySemanticsLabel(R.strings.name), name);
    verify(presenter.validateName(name));

    final email = faker.internet.email();
    await tester.enterText(find.bySemanticsLabel(R.strings.email), email);
    verify(presenter.validateEmail(email));

    final password = faker.internet.password();
    await tester.enterText(find.bySemanticsLabel(R.strings.password), password);
    verify(presenter.validatePassword(password));

    await tester.enterText(find.bySemanticsLabel(R.strings.confirmPassword), password);
    verify(presenter.validatePasswordConfirmation(password));
  });

}
