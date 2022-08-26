import 'package:ForDev/domain/usecases/add_Account.dart';
import 'package:meta/meta.dart';

import '../../http/http.dart';


class RemoteAddAccount{
  final HttpClient httpClient;
  final String url;

  RemoteAddAccount({
    @required this.httpClient,
    @required this.url
  });

  Future<void> add(AddAccountParams params) async {
    final body = RemoteAddAccountParams.fromDomain(params).toJson();
    await await httpClient.request(url: url, method: 'post', body: body);
  }
}

class RemoteAddAccountParams {
  final String name;
  final String email;
  final String password;
  final String passwordConfimation;

  RemoteAddAccountParams({
    @required this.name,
    @required this.email,
    @required this.password,
    @required this.passwordConfimation,
  });

  factory RemoteAddAccountParams.fromDomain(AddAccountParams params) => 
    RemoteAddAccountParams(
      name: params.name,
      email: params.email,
      password: params.password, 
      passwordConfimation: params.passwordConfirmation);

  Map toJson() => {
    'name': name,
    'email': email, 
    'password': password, 
    'passwordConfirmation': passwordConfimation
  };
}