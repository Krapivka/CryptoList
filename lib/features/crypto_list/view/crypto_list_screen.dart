import 'dart:async';

import 'package:auto_route/annotations.dart';
import 'package:crypto_coins_list/features/crypto_list/bloc/crypto_list_bloc.dart';
import 'package:crypto_coins_list/repositories/crypto_coins/abstract_coins_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import '../widgets/widgets.dart';

@RoutePage()
class CryptoListScreen extends StatefulWidget {
  const CryptoListScreen({
    super.key,
  });

  @override
  State<CryptoListScreen> createState() => _CryptoListScreenState();
}

class _CryptoListScreenState extends State<CryptoListScreen> {
  final _cryptoListbloc = CryptoListBloc(GetIt.I<AbstractCoinsRepository>());
  @override
  void initState() {
    _cryptoListbloc.add(LoadCryptoList());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Crypto Coins List"),
        centerTitle: true,
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          final completer = Completer();
          _cryptoListbloc.add(LoadCryptoList(completer: completer));
          return completer.future;
        },
        child: BlocBuilder<CryptoListBloc, CryptoListState>(
            bloc: _cryptoListbloc,
            builder: (context, state) {
              if (state is CryptoListLoading) {
                return const Center(child: CircularProgressIndicator());
              }
              if (state is CryptoListLoaded) {
                return ListView.separated(
                  separatorBuilder: (context, i) => Divider(
                    color: theme.dividerColor,
                  ),
                  itemCount: state.coinsList.length,
                  itemBuilder: (context, i) => CryptoCoinTile(
                    coinName: state.coinsList[i].name.toString(),
                    price: state.coinsList[i].details.priceInUSD,
                    imgUrl: state.coinsList[i].details.fullImageUrl,
                  ),
                );
              }
              if (state is CryptoListLoadingFailed) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Something went wrong",
                        style: theme.textTheme.bodyMedium,
                      ),
                      Text(
                        "Please try again later",
                        style: theme.textTheme.bodySmall,
                      ),
                      TextButton(
                          onPressed: () async {
                            _cryptoListbloc.add(LoadCryptoList());
                          },
                          child: const Text(
                            "Try again",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ))
                    ],
                  ),
                );
              }
              return const SizedBox();
            }),
      ),
    );
  }
}
