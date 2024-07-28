import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:orchid_furniture/constants.dart';
import 'package:orchid_furniture/app/main_page.dart';

class StarterPage extends StatefulWidget {
  StarterPage({super.key});

  @override
  _StarterPageState createState() => _StarterPageState();
}

class _StarterPageState extends State<StarterPage> {
  ValueNotifier<bool> buttonClickedTimes = ValueNotifier(false);
  double _opacity = 0.0;

  @override
  void initState() {
    super.initState();
    // Start the fade-in effect after 1 second
    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        _opacity = 1.0;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    if (size.height < 950) {
      setState(() {
        isPhone = true;
      });
    }
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: AnimatedOpacity(
          opacity: _opacity,
          duration:
              const Duration(seconds: 2), // Duration of the fade-in effect
          curve: Curves.easeIn, // Curve for the fade-in effect
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Lottie.asset('assets/diamond.json',
                  height: isPhone ? 200 : 400, frameRate: const FrameRate(60)),
              SizedBox(
                width: size.width,
                height: 20,
              ),
              SizedBox(
                height: size.height * .025,
              ),
              Text(
                'Welcome to ORCHID',
                style: TextStyle(
                    color: col30,
                    fontSize: isPhone ? 24 : 36,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Raleway'),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    vertical: 30.0, horizontal: size.width * .08),
                child: Text(
                  'Where Elegance Meets Craftsmanship. Your Perfect Furniture, Just a Tap Away. ',
                  style: TextStyle(
                      color: col30,
                      fontSize: isPhone ? 18 : 26,
                      fontFamily: 'Quicksand',
                      fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
              ValueListenableBuilder(
                valueListenable: buttonClickedTimes,
                builder: (BuildContext context, bool bval, Widget? child) {
                  return GestureDetector(
                    onTap: () async {
                      buttonClickedTimes.value = true;
                      await Future.delayed(const Duration(seconds: 3));
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const MainPage(),
                        ),
                      );
                    },
                    child: Lottie.asset('assets/tap.json',
                        height: isPhone ? 75 : 100,
                        animate: bval,
                        frameRate: const FrameRate(60)),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
