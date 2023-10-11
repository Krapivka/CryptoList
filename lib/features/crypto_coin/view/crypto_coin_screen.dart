import 'package:auto_route/annotations.dart';
import 'package:crypto_coins_list/repositories/crypto_coins/abstract_coins_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import '../bloc/crypto_coin_bloc.dart';

@RoutePage()
class CryptoCoinScreen extends StatefulWidget {
  const CryptoCoinScreen({
    super.key,
    required this.coinName,
  });

  final String coinName;
  @override
  State<CryptoCoinScreen> createState() => _CryptoCoinScreenState();
}

class _CryptoCoinScreenState extends State<CryptoCoinScreen> {
  final _cryptoListbloc = CryptoCoinBloc(GetIt.I<AbstractCoinsRepository>());

  @override
  void initState() {
    _cryptoListbloc.add(LoadCryptoCoinDetail(coinName: widget.coinName));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
        appBar: AppBar(),
        body: BlocBuilder<CryptoCoinBloc, CryptoCoinState>(
            bloc: _cryptoListbloc,
            builder: (context, state) {
              if (state is CryptoCoinLoading) {
                return const Center(child: CircularProgressIndicator());
              }
              if (state is CryptoCoinLoaded) {
                final details = state.coin.details;
                return Center(
                  child: Container(
                    padding: const EdgeInsets.all(15),
                    width: MediaQuery.of(context).size.width / 1.01,
                    child: Column(children: <Widget>[
                      Image.network(
                        details.fullImageUrl,
                        height: 180,
                        width: 180,
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      Container(
                        width: double.infinity,
                        height: 50,
                        decoration: BoxDecoration(
                            color: Colors.black54,
                            borderRadius: BorderRadius.circular(15)),
                        child: Center(
                          child: Text(
                            state.coin.name,
                            style: theme.textTheme.bodyMedium,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Column(
                        children: <Widget>[
                          Container(
                            width: double.infinity,
                            height: 50,
                            decoration: BoxDecoration(
                                color: Colors.black54,
                                borderRadius: BorderRadius.circular(15)),
                            child: Center(
                                child: Text(
                                    "${details.priceInUSD.toString()} \$")),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 15, horizontal: 25),
                              width: double.infinity,
                              height: 100,
                              decoration: BoxDecoration(
                                  color: Colors.black54,
                                  borderRadius: BorderRadius.circular(15)),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      const Text("Hight 24 hour: "),
                                      Flexible(
                                          child: Text(
                                              "${details.hight24hour} \$")),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      const Text("Low 24 hour: "),
                                      Flexible(
                                          child:
                                              Text("${details.low24hour} \$")),
                                    ],
                                  ),
                                ],
                              ))
                        ],
                      ),
                    ]),
                  ),
                );
              }
              if (state is CryptoCoinLoadingFailed) {
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
                            _cryptoListbloc
                                .add(LoadCryptoCoinDetail(coinName: ''));
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
            }));
  }
}
