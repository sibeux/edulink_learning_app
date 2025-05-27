import 'package:edulink_learning_app/components/color_palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPalette().primary, // samain dengan native splash
      appBar: AppBar(backgroundColor: ColorPalette().primary),
      
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              'assets/images/logos/logo_splash.png', // samain juga
              width: MediaQuery.of(context).size.width * 0.6,
              fit: BoxFit.contain,
            ),
          ],
        ),
      ),
    );
  }
}
