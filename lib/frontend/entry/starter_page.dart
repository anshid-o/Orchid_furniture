import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:orchid_furniture/constants.dart';
import 'package:orchid_furniture/frontend/app/main_page.dart';

class StarterPage extends StatelessWidget {
  StarterPage({super.key});

  ValueNotifier<bool> buttonClickedTimes = ValueNotifier(false);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Lottie.asset('assets/diamond.json', height: 400),
            SizedBox(
              width: size.width,
              height: 20,
            ),
            SizedBox(
              height: size.height * .025,
            ),
            const Text(
              'Welcome to ORCHID',
              style: TextStyle(
                  color: col30,
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Raleway'),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  vertical: 30.0, horizontal: size.width * .08),
              child: const Text(
                'Where Elegance Meets Craftsmanship. Your Perfect Furniture, Just a Tap Away. ',
                style: TextStyle(
                    color: col30,
                    fontSize: 26,
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
                            builder: (context) => MainPage(),
                          ));
                    },
                    child: Lottie.asset(
                      'assets/tap.json',
                      height: 100,
                      animate: bval,
                    ));
              },
            )
          ],
        ),
      ),
    );
  }
}
