import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:crypto_coins_list/router/router.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CryptoCoinTile extends StatelessWidget {
  const CryptoCoinTile(
      {super.key,
      required this.coinName,
      required this.price,
      required this.imgUrl});
  final String imgUrl;
  final double price;
  final String coinName;
  @override
  Widget build(BuildContext context) {
    return ListTile(
        leading: CachedNetworkImage(
            imageUrl: imgUrl,
            height: 50,
            width: 50,
            placeholder: ((context, imgUrl) =>
                const CircularProgressIndicator())),
        title: Text(
          coinName,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        subtitle: Text(
          "$price\$",
          style: Theme.of(context).textTheme.bodySmall,
        ),
        trailing: const Icon(Icons.arrow_forward_ios),
        onTap: () {
          AutoRouter.of(context).push(CryptoCoinRoute(coinName: coinName));
        }
        // Navigator.of(context).pushNamed(
        // '/coin',
        // arguments: coinName,
        );
  }
}
