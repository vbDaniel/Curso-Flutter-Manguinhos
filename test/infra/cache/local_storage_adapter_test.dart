import 'package:mockito/mockito.dart';
import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:ForDev/infra/cache/cache.dart';

class FlutteSecureStorageSpy extends Mock implements FlutterSecureStorage {}

void main() {
  FlutteSecureStorageSpy secureStorage;
  LocalStorageAdapter sut;
  String key;
  String value;

  setUp(() {
    secureStorage = FlutteSecureStorageSpy();
    sut = LocalStorageAdapter(secureStorage: secureStorage);
    key = faker.lorem.word();
    value = faker.guid.guid();
  });

  group('saveSecure', () {
    void mockSaveSecureError() {
      when(secureStorage.write(key: anyNamed('key'), value: anyNamed('value')))
          .thenThrow(Exception());
    }

    test('Should call save secure with correct values', () async {
      await sut.saveSecure(key: key, value: value);

      verify(secureStorage.write(key: key, value: value));
    });

    test('Should throw if save secure throws', () async {
      mockSaveSecureError();
      final future = sut.saveSecure(key: key, value: value);

      expect(future, throwsA(isA<Exception>()));
    });
  });

  group('fetchSecure', () {
    PostExpectation mockFetchSecureCall() =>
        when(secureStorage.read(key: anyNamed('key')));

    void mockFetchSecure() {
      mockFetchSecureCall().thenAnswer((_) async => value);
    }

    void mockFetchSecureError() {
      mockFetchSecureCall().thenThrow(Exception());
    }

    setUp(() {
      mockFetchSecure();
    });

    test('Should call fetch secure with correct values', () async {
      await sut.fetchSecure(key);

      verify(secureStorage.read(key: key));
    });
    test('Should return correct calue on success', () async {
      final fetchedValue = await sut.fetchSecure(key);

      expect(fetchedValue, value);
    });

    test('Should throw if fetch secure throws', () async {
      mockFetchSecureError();
      final future = sut.fetchSecure(key);

      expect(future, throwsA(isA<Exception>()));
    });
  });
}
