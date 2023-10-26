import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'crypto_coin_detail.dart';

part 'crypto_coin.g.dart';

@HiveType(typeId: 2)
@JsonSerializable()
class CryptoCoin extends Equatable {
  @HiveField(0)
  final String name;
  @HiveField(1)
  final CryptoCoinDetail details;
  const CryptoCoin({
    required this.name,
    required this.details,
  });

  factory CryptoCoin.fromJson(Map<String, dynamic> json) =>
      _$CryptoCoinFromJson(json);

  Map<String, dynamic> toJson() => _$CryptoCoinToJson(this);

  @override
  List<Object?> get props => [name, details];
}
