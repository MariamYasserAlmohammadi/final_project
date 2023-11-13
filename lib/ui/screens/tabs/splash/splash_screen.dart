import 'package:flutter/material.dart';

import '../../home_screen.dart';

class SplashScreen extends StatefulWidget {
  static const String routeName ="splashScreen";
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2),(){
      Navigator.pushReplacementNamed(context, HomeScreen.routeName);
    });
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Image.asset('assets/images/splash.png',
      height:MediaQuery.of(context).size.height,
     width:MediaQuery.of(context).size.width,
      ),
    );
  }
}
