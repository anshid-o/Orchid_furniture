import 'package:flutter/material.dart';
import 'package:orchid_furniture/constants.dart';
import 'dart:async';
import 'package:orchid_furniture/entry/starter_page.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  double _opacity = 0.0; // Initial opacity set to 0.0 for fade-in effect

  @override
  void initState() {
    super.initState();

    // Start the fade-in effect immediately
    Timer(const Duration(milliseconds: 500), () {
      setState(() {
        _opacity = 1.0;
      });
    });

    // Start the fade-out effect after 1.5 seconds (allowing for the fade-in to complete first)
    Timer(const Duration(seconds: 2), () {
      setState(() {
        _opacity = 0.0;
      });
    });

    // Navigate to the next page after 2.5 seconds
    Future.delayed(const Duration(seconds: 2, milliseconds: 500), () {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => StarterPage(), // Replace with your target page
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    if (MediaQuery.of(context).size.height < 950) {
      setState(() {
        isPhone = true;
      });
    }
    return Scaffold(
      backgroundColor: Colors.black,
      body: AnimatedOpacity(
        opacity: _opacity,
        duration: const Duration(seconds: 1),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // App Logo
              Image.asset(
                'assets/logof.png',
                height: isPhone ? 150 : 250,
              ), // Replace with your logo widget
            ],
          ),
        ),
      ),
    );
  }
}
