import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vpn/utils/constants.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 2), () {
      // context.go('/home');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            color: Colors.black,
          ),
          Column(mainAxisSize: MainAxisSize.min, children: [
            Image.asset(
              'assets/images/splash.png',
              width: 150,
              height: 150,
            ),
            const SizedBox(height: 20),
            const Text(
              kSplashText,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w100,
                letterSpacing: 10,
                color: Colors.white,
              ),
            )
          ])
        ],
      ),
    );
  }
}
