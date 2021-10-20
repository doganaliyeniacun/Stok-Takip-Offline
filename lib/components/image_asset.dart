import 'package:flutter/material.dart';
import 'package:stok_takip_offline/utils/const/const.dart';

class CenterImage extends StatelessWidget {
  const CenterImage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      AppConstructor.stockImg,
      fit: BoxFit.contain,
    );
  }
}