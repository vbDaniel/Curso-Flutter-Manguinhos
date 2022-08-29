import 'dart:async';

import 'package:ForDev/ui/helpers/errors/ui_error.dart';
import 'package:ForDev/ui/helpers/helpers.dart';
import 'package:ForDev/ui/pages/signup/signup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mockito/mockito.dart';


class SignUpPresenterSpy extends Mock implements SignUpPresenter {}

void main() {
  SignUpPresenter presenter;
  StreamController<UiError> emailErrorController;
  StreamController<UiError> passwordErrorController;
  StreamController<UiError> mainErrorController;
  StreamController<String> navigateToController;
  StreamController<bool> isFormValidController;
  StreamController<bool> isLoadingController;

  void initStreams() {
    emailErrorController = StreamController<UiError>();
    passwordErrorController = StreamController<UiError>();
    mainErrorController = StreamController<UiError>();
    navigateToController = StreamController<String>();
    isFormValidController = StreamController<bool>();
    isLoadingController = StreamController<bool>();
  }

  void mockStreams() {
    when(presenter.emailErrorStream)
        .thenAnswer((_) => emailErrorController.stream);
    when(presenter.passwordErrorStream)
        .thenAnswer((_) => passwordErrorController.stream);
    when(presenter.mainErrorStream)
        .thenAnswer((_) => mainErrorController.stream);
    when(presenter.navigationToStream)
        .thenAnswer((_) => navigateToController.stream);
    when(presenter.isFormValidStream)
        .thenAnswer((_) => isFormValidController.stream);
    when(presenter.isLoadingStream)
        .thenAnswer((_) => isLoadingController.stream);
  }

  void closeStreams() {
    emailErrorController.close();
    passwordErrorController.close();
    mainErrorController.close();
    navigateToController.close();
    isFormValidController.close();
    isLoadingController.close();
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

}
