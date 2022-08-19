import 'package:ForDev/domain/entities/entities.dart';
import 'package:ForDev/domain/helpers/helpers.dart';
import 'package:ForDev/domain/usecases/usecases.dart';
import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:mockito/mockito.dart';

import 'package:test/test.dart';

class LocalSaveCurrentAccount implements SaveCurrentAccount {
  final SaveSecureCacheStorage saveSecureCacheStorage;

  LocalSaveCurrentAccount({@required this.saveSecureCacheStorage});

  Future<void> save(AccountEntity account) async {
    try {
      await saveSecureCacheStorage.saveSecure(
          key: 'token', value: account.token);
    } catch (error) {
      throw DomainError.unexpected;
    }
  }
}

abstract class SaveSecureCacheStorage {
  Future<void> saveSecure({@required String key, @required String value});
}

class SaveSecureCacheStorageSpy extends Mock implements SaveSecureCacheStorage {
}

void main() {
  LocalSaveCurrentAccount sut;
  SaveSecureCacheStorageSpy saveSecureCacheStorageSpy;
  AccountEntity account;

  setUp(() {
    saveSecureCacheStorageSpy = SaveSecureCacheStorageSpy();
    sut = LocalSaveCurrentAccount(
        saveSecureCacheStorage: saveSecureCacheStorageSpy);
    account = AccountEntity(faker.guid.guid());
  });
  test('Should call SaveSecureCacheStorage with correct values', () async {
    await sut.save(account);

    verify(saveSecureCacheStorageSpy.saveSecure(
        key: 'token', value: account.token));
  });

  test('Should throw UnexpecteError SaveSecureCacheStorage throws', () async {
    when(saveSecureCacheStorageSpy.saveSecure(
            key: anyNamed('key'), value: anyNamed('value')))
        .thenThrow(Exception());

    final future = sut.save(account);

    expect(future, throwsA(DomainError.unexpected));
  });
}
