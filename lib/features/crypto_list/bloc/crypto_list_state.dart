part of 'crypto_list_bloc.dart';

abstract class CryptoListState extends Equatable {}

class CryptoListInitial extends CryptoListState {
  @override
  List<Object?> get props => [];
}

class CryptoListLoading extends CryptoListState {
  @override
  List<Object?> get props => [];
}

class CryptoListLoaded extends CryptoListState {
  final List<CryptoCoin> coinsList;

  CryptoListLoaded(this.coinsList);

  @override
  List<Object?> get props => [coinsList];
}

class CryptoListLoadingFailed extends CryptoListState {
  final Object? exception;

  CryptoListLoadingFailed(this.exception);
  @override
  List<Object?> get props => [exception];
}
