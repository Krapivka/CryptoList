import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'crypto_coin_detail.g.dart';

@HiveType(typeId: 1)
@JsonSerializable()
class CryptoCoinDetail extends Equatable {
  const CryptoCoinDetail({
    required this.priceInUSD,
    required this.imgUrl,
    required this.hight24hour,
    required this.low24hour,
  });
  @HiveField(0)
  @JsonKey(name: "PRICE")
  final double priceInUSD;
  @HiveField(1)
  @JsonKey(name: "IMAGEURL")
  final String imgUrl;

  String get fullImageUrl => 'https://www.cryptocompare.com/$imgUrl';
  @HiveField(2)
  @JsonKey(name: "HIGH24HOUR")
  final double hight24hour;
  @HiveField(3)
  @JsonKey(name: "LOW24HOUR")
  final double low24hour;

  factory CryptoCoinDetail.fromJson(Map<String, dynamic> json) =>
      _$CryptoCoinDetailFromJson(json);

  Map<String, dynamic> toJson() => _$CryptoCoinDetailToJson(this);

  @override
  List<Object?> get props => [priceInUSD, imgUrl, hight24hour, low24hour];
}
