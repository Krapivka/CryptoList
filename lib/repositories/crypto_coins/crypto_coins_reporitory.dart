import 'package:crypto_coins_list/repositories/crypto_coins/abstract_coins_repository.dart';
import 'package:crypto_coins_list/repositories/firestore_database/firestore_repository.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:talker_flutter/talker_flutter.dart';

import 'models/models.dart';

class CryptoCoinRepository implements AbstractCoinsRepository {
  final Dio dio;
  final Box<CryptoCoin> cryptoCoinsBox;
  CryptoCoinRepository({required this.cryptoCoinsBox, required this.dio});

  @override
  Future<List<CryptoCoin>> getCoinsList() async {
    var cryptoCoinsList = <CryptoCoin>[];
    try {
      cryptoCoinsList = await _fetchCoinsListFromApi();
      final cryptoCoinsMap = {for (var e in cryptoCoinsList) e.name: e};
      await cryptoCoinsBox.putAll(cryptoCoinsMap);
    } catch (e, st) {
      GetIt.I<Talker>().handle(e, st);
      cryptoCoinsList = cryptoCoinsBox.values.toList();
    }
    cryptoCoinsList
        .sort((a, b) => b.details.priceInUSD.compareTo(a.details.priceInUSD));
    return cryptoCoinsList;
  }

  Future<List<CryptoCoin>> _fetchCoinsListFromApi() async {
    final response = await Dio().get(
        'https://min-api.cryptocompare.com/data/pricemultifull?fsyms=BTC,ETH,BNB,AVAX,AID,ACCN,DOV,CAG&tsyms=USD');
    final data = response.data as Map<String, dynamic>;
    final dataRaw = data['RAW'] as Map<String, dynamic>;
    final cryptoCoinList = dataRaw.entries.map((e) {
      final usdData =
          ((e.value as Map<String, dynamic>)['USD']) as Map<String, dynamic>;
      final details = CryptoCoinDetail.fromJson(usdData);
      return CryptoCoin(
        name: e.key,
        details: details,
      );
    }).toList();
    return cryptoCoinList;
  }

  @override
  Future<CryptoCoin> getCoinDetail(String coinName) async {
    try {
      final coin = await _fetchCoinDetailFromApi(coinName);
      cryptoCoinsBox.put(coinName, coin);
      return coin;
    } catch (e, st) {
      GetIt.I<Talker>().handle(e, st);

      return cryptoCoinsBox.get(coinName)!;
    }
  }

  Future<CryptoCoin> _fetchCoinDetailFromApi(String coinName) async {
    final response = await Dio().get(
        'https://min-api.cryptocompare.com/data/pricemultifull?fsyms=$coinName&tsyms=USD');
    final data = response.data as Map<String, dynamic>;
    final dataRaw = data['RAW'] as Map<String, dynamic>;
    final dataCoin = ((dataRaw)[coinName]) as Map<String, dynamic>;
    final usdData = ((dataCoin)["USD"]) as Map<String, dynamic>;
    // FirestoreRepository()
    //     .addCryptoCoin(usdData)
    //     .then((value) => GetIt.I.get<Talker>().info("CryptoCoin added"))
    //     .catchError((error) =>
    //         GetIt.I.get<Talker>().error("Failed to CryptoCoin: $error"));
    // ;
    final details = CryptoCoinDetail.fromJson(usdData);

    return CryptoCoin(
      name: coinName,
      details: details,
    );
  }
}
