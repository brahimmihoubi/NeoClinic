import 'package:flutter/material.dart';

class LogoWidget extends StatelessWidget {
  final double size;

  const LogoWidget({super.key, this.size = 120});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'lib/assets/images/neoclinic_logo.png',
      width: size,
      height: size,
      fit: BoxFit.contain,
    );
  }
}
