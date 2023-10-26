import 'package:cloud_firestore/cloud_firestore.dart';
import 'abstract_firestore_repository.dart';

class FirestoreRepository extends AbstractFirestoreDatabase {
  late final CollectionReference cryptoInfo;
  FirestoreRepository() {
    initFirestore();
  }

  @override
  void initFirestore() {
    cryptoInfo = FirebaseFirestore.instance.collection("CryptoInfo");
  }

  @override
  Future<void> addCrypto(Map<String, dynamic> cryptoCoinsMap) async {
    await cryptoInfo.doc("${DateTime.now()}").set(cryptoCoinsMap);
  }
}
