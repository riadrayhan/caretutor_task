import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo/authentication/log.dart';


class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  AnimationController? _controller;
  Animation<double>? _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );

    _animation = CurvedAnimation(parent: _controller!, curve: Curves.easeIn)
      ..addListener(() {
        setState(() {});
      });

    _controller!.forward();

    _navigateToHome();
  }

  void _navigateToHome() {
    Future.delayed(Duration(seconds: 4), () {
      Navigator.push(context, MaterialPageRoute(builder: (context) => SignInScreen(),));
    });
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Customize this color as needed
      body: Center(
        child: Opacity(
          opacity: _animation!.value,
          child: Image.asset('assets/splash.png'), // Your logo or image here
        ),
      ),
    );
  }
}
