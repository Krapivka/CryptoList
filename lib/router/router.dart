import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import '../features/crypto_coin/crypto_coin.dart';
import '../features/crypto_list/crypto_list.dart';

// final routes = {
//   '/': (context) => const CryptoListScreen(title: 'Crypto Coins List'),
//   '/coin': (context) => const CryptoCoinScreen(),
// };
part 'router.gr.dart';

@AutoRouterConfig()
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: CryptoListRoute.page, path: '/'),
        AutoRoute(page: CryptoCoinRoute.page),
      ];
}
