import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:orchid_furniture/backend/auth/auth.dart';
import 'package:orchid_furniture/constants.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  Future<void> signInWithEmailAndPassord() async {
    try {
      await Auth().signInwithEmailAndPassword(
          email: _emailController.text, password: _passwordController.text);
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: col30,
        body: ListView(
          children: [
            SizedBox(
              width: size.width,
              height: size.height * .08,
            ),
            const Column(
              children: [
                Text(
                  'Welcome Back!',
                  style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                ),
                Text(
                  'Please enter your account here',
                  style: TextStyle(fontSize: 14),
                ),
              ],
            ),
            SizedBox(
              height: size.height * .05,
            ),
            Form(
                child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.blue[50],
                        borderRadius: BorderRadius.circular(10)),
                    height: size.height * .075,
                    child: TextFormField(
                      controller: _emailController,
                      decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.email),
                          hintText: 'Email',
                          hintStyle: TextStyle(height: 3),
                          border: InputBorder.none),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.blue[50],
                        borderRadius: BorderRadius.circular(10)),
                    height: size.height * .075,
                    child: TextFormField(
                      controller: _passwordController,
                      decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.lock),
                          suffixIcon: IconButton(
                              onPressed: () {},
                              icon: const Icon(Icons.visibility)),
                          hintText: 'Password',
                          hintStyle: TextStyle(height: 3),
                          border: InputBorder.none),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () {
                          if (_emailController.text.isEmpty) {
                            Fluttertoast.showToast(msg: 'Enter email in box');
                          }
                          FirebaseAuth.instance.sendPasswordResetEmail(
                              email: _emailController.text);
                          Fluttertoast.showToast(
                              msg: 'Reset link sent to your mail');
                        },
                        child: const Text(
                          'Forgot password?',
                          style: TextStyle(
                              color: col60, fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  ),
                ),
                ElevatedButton(
                  onPressed: () async {
                    await signInWithEmailAndPassord();
                    if (Auth().currentUser!.emailVerified) {
                      Navigator.popAndPushNamed(context, '/main');
                    } else {
                      Fluttertoast.showToast(msg: 'verify Email before login');
                      await Auth().currentUser!.sendEmailVerification();
                    }
                  },
                  style: ButtonStyle(
                    minimumSize: WidgetStatePropertyAll(
                        Size(size.width * .9, size.width * .15)),
                    backgroundColor: const WidgetStatePropertyAll(col60),
                    shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      side:
                          const BorderSide(color: Colors.white), // Border color
                    )),
                  ),
                  child: const Text(
                    'LOGIN',
                    style: TextStyle(color: col30),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(12.0),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Divider(
                          color: Colors.black,
                          thickness: 1,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.0),
                        child: Text('Or continue with'),
                      ),
                      Expanded(
                        child: Divider(
                          color: Colors.black,
                          thickness: 1,
                        ),
                      ),
                    ],
                  ),
                ),
                ElevatedButton(
                  onPressed: () {},
                  style: ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(Colors.blue[50]),
                    shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      side:
                          const BorderSide(color: Colors.white), // Border color
                    )),
                  ),
                  child: SizedBox(
                    width: size.width * .8,
                    height: size.height * .075,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/f.png',
                          height: 25,
                        ),
                        const SizedBox(
                          width: 1,
                        ),
                        const Text(
                          'Facebook',
                          style: TextStyle(color: col60),
                        ),
                      ],
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () async {
                    final google = GoogleSignIn();
                    try {
                      await google.signOut();
                      final gaccount = await google.signIn();

                      if (gaccount != null) {
                        final gauth = await gaccount.authentication;
                        final gcred = GoogleAuthProvider.credential(
                            idToken: gauth.idToken,
                            accessToken: gauth.accessToken);
                        await FirebaseAuth.instance.signInWithCredential(gcred);

                        Navigator.popAndPushNamed(context, '/main');
                      }
                    } catch (e) {
                      print(e);
                    }
                  },
                  style: ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(Colors.blue[50]),
                    shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      side:
                          const BorderSide(color: Colors.white), // Border color
                    )),
                  ),
                  child: SizedBox(
                    width: size.width * .8,
                    height: size.height * .075,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/g.png',
                          height: 20,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        const Text(
                          'Google',
                          style: TextStyle(color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                ),
                IconButton(
                    onPressed: () {
                      Auth().signOut();
                    },
                    icon: Icon(Icons.logout_outlined))
              ],
            )),
          ],
        ),
      ),
    );
  }
}
