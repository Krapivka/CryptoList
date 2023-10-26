import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto_coins_list/firebase_options.dart';
import 'package:crypto_coins_list/repositories/crypto_coins/abstract_coins_repository.dart';
import 'package:crypto_coins_list/repositories/crypto_coins/crypto_coins.dart';
import 'package:crypto_coins_list/repositories/crypto_coins/models/models.dart';
import 'package:crypto_coins_list/repositories/firestore_database/abstract_firestore_repository.dart';
import 'package:crypto_coins_list/repositories/firestore_database/firestore_repository.dart';
import 'package:dio/dio.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:talker_bloc_logger/talker_bloc_logger.dart';
import 'package:talker_dio_logger/talker_dio_logger.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'crypto_coins_list_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final a = await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  final collection = FirebaseFirestore.instance.collection("CryptoInfo");
  final talker = TalkerFlutter.init();
  GetIt.I.registerSingleton(talker);
  GetIt.I<Talker>().debug("Talker started...");
  //creating when our feature register first

  talker.info(a.options.projectId);
  const cryptoCoinsBoxName = 'crypto_coins_box';

  await Hive.initFlutter();
  Hive.registerAdapter(CryptoCoinDetailAdapter());
  Hive.registerAdapter(CryptoCoinAdapter());

  final cryptoCoinsBox = await Hive.openBox<CryptoCoin>(cryptoCoinsBoxName);
  collection
      .doc("${DateTime.now()}")
      .set({"Message": "Пользователь выполнил вход в приложение"});
  final dio = Dio();
  dio.interceptors.add(
    TalkerDioLogger(
      talker: talker,
      settings: const TalkerDioLoggerSettings(
        printResponseHeaders: true,
        printResponseData: true,
      ),
    ),
  );

  Bloc.observer = TalkerBlocObserver(
    settings: const TalkerBlocLoggerSettings(
      printEventFullData: false,
      printStateFullData: false,
    ),
  );

  //GetIt.I.registerSingleton<AbstractFirestoreDatabase>(() => FirestoreRepository);

  GetIt.I.registerLazySingleton<AbstractCoinsRepository>(
      () => CryptoCoinRepository(dio: dio, cryptoCoinsBox: cryptoCoinsBox));

  FlutterError.onError =
      ((details) => GetIt.I<Talker>().handle(details.exception, details.stack));
  // runZonedGuarded(() =>
  runApp(const CryptoCoinsListApp());
  // ),
  //     (e, st) => GetIt.I<Talker>().handle(e, st));
}
