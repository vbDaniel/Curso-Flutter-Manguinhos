import 'package:ForDev/domain/entities/entities.dart';

abstract class SaveCurrentAccount {
  Future<void> save(AccountEntity account);
}
