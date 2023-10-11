part of 'crypto_coin_bloc.dart';

abstract class CryptoCoinEvent extends Equatable {}

class LoadCryptoCoinDetail extends CryptoCoinEvent {
  LoadCryptoCoinDetail({this.completer, required this.coinName});
  final String coinName;
  final Completer? completer;

  @override
  List<Object?> get props => [completer];
}
