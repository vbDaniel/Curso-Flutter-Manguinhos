import 'package:ForDev/data/cache/cache.dart';
import 'package:ForDev/data/usecases/usecases.dart';

import 'package:ForDev/domain/entities/entities.dart';
import 'package:ForDev/domain/helpers/helpers.dart';

import 'package:faker/faker.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

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

  void mockError() {
    when(saveSecureCacheStorageSpy.saveSecure(
            key: anyNamed('key'), value: anyNamed('value')))
        .thenThrow(Exception());
  }

  test('Should call SaveSecureCacheStorage with correct values', () async {
    await sut.save(account);

    verify(saveSecureCacheStorageSpy.saveSecure(
        key: 'token', value: account.token));
  });

  test('Should throw UnexpecteError SaveSecureCacheStorage throws', () async {
    mockError();

    final future = sut.save(account);

    expect(future, throwsA(DomainError.unexpected));
  });
}
