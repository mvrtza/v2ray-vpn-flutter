import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vpn_v2ray_full/utils/constants.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 8), () {
      context.go('/home');
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
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column( mainAxisSize: MainAxisSize.min, children: [
              Container( width: 72, height: 72, decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.white),),
              const SizedBox(height: 20),
              const Text(
                kSplashText,
                style: TextStyle(
                  fontSize: 8,
                  fontWeight: FontWeight.w300,
                  letterSpacing: 4,
                  color: Colors.white,
                ),
              )
            ]),
          )
        ],
      ),
    );
  }
}
