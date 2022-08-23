import 'package:ForDev/domain/entities/entities.dart';

abstract class loadCurrentAccount {
  Future<AccountEntity> load();
}
