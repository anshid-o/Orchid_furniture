import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:orchid_furniture/backend/auth/auth.dart';
import 'package:orchid_furniture/constants.dart';

class RegisterPage extends StatelessWidget {
  RegisterPage({super.key});

  TextEditingController _emailController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  Future<void> signUpWithEmailAndPassord() async {
    try {
      await Auth().signUpwithEmailAndPassword(
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
              height: size.height * .05,
            ),
            const Column(
              children: [
                Text(
                  'Registration',
                  style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                ),
                Text(
                  'Please register down below',
                  style: TextStyle(fontSize: 14),
                ),
              ],
            ),
            SizedBox(
              height: size.height * .01,
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
                      controller: _nameController,
                      decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.person),
                          hintText: 'Full name',
                          hintStyle: const TextStyle(height: 3),
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
                      controller: _emailController,
                      decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.email),
                          hintText: 'Email',
                          hintStyle: const TextStyle(height: 3),
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
                              onPressed: () {
                                print('object');
                              },
                              icon: const Icon(Icons.visibility)),
                          hintText: 'Password',
                          hintStyle: const TextStyle(height: 3),
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
                        onPressed: () async {},
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
                    await signUpWithEmailAndPassord();
                    if (Auth().currentUser != null) {
                      Navigator.popAndPushNamed(context, '/main');
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
                    'Register',
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
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.phone),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          'Phone',
                          style: TextStyle(color: col60),
                        ),
                      ],
                    ),
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
                      final gaccount = await google.signIn();

                      if (gaccount != null) {
                        final gauth = await gaccount.authentication;
                        final gcred = GoogleAuthProvider.credential(
                            idToken: gauth.idToken,
                            accessToken: gauth.accessToken);
                        FirebaseAuth.instance.signInWithCredential(gcred);

                        print('done');
                      }
                    } catch (e) {
                      print(e);
                    }
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(Colors.blue[50]),
                    shape: MaterialStatePropertyAll(RoundedRectangleBorder(
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
              ],
            )),
          ],
        ),
      ),
    );
  }
}
