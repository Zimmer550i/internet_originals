import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class Svg extends StatelessWidget {
  final String asset;
  final Color? color;
  final double? width;
  final double? height;
  const Svg({
    super.key,
    required this.asset,
    this.color,
    this.height = 24,
    this.width = 24,
  });

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      asset,
      height: height,
      width: width,
      colorFilter:
          color != null ? ColorFilter.mode(color!, BlendMode.srcIn) : null,
    );
  }
}
