import 'package:flutter/material.dart';
import 'package:neoclinic/constants/app_colors.dart';

class LogoWidget extends StatelessWidget {
  final double? width;
  final double? height;
  final double size;
  final BoxFit fit;

  const LogoWidget({
    super.key,
    this.size = 80,
    this.width,
    this.height,
    this.fit = BoxFit.contain,
  });

  @override
  Widget build(BuildContext context) {
    final w = width ?? size;
    final h = height ?? size;

    return Image.asset(
      'assets/images/neoclinic_logo.png',
      width: w,
      height: h,
      fit: fit,
      errorBuilder: (_, __, ___) => Image.asset(
        'lib/assets/images/neoclinic_logo.png',
        width: w,
        height: h,
        fit: fit,
        errorBuilder: (_, __, ___) => Icon(
          Icons.local_hospital_rounded,
          color: AppColors.primary,
          size: (w < h ? w : h) * 0.6,
        ),
      ),
    );
  }
}
