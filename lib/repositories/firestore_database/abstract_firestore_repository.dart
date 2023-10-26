import 'package:crypto_coins_list/repositories/crypto_coins/models/models.dart';

abstract class AbstractFirestoreDatabase {
  void initFirestore();
  Future<void> addCrypto(Map<String, CryptoCoin> cryptoCoinsMap) async {}
}
