import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:orchid_furniture/backend/auth/auth.dart';
import 'package:orchid_furniture/constants.dart';

class PersonalDetailsPage extends StatefulWidget {
  PersonalDetailsPage({super.key});

  @override
  State<PersonalDetailsPage> createState() => _PersonalDetailsPageState();
}

class _PersonalDetailsPageState extends State<PersonalDetailsPage> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _name = TextEditingController();
  TextEditingController _age = TextEditingController();
  TextEditingController _place = TextEditingController();
  TextEditingController _pin = TextEditingController();

  int _stype = 0;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: col5,
      appBar: AppBar(
        backgroundColor: col5,
        titleSpacing: size.width * .2,
        title: const Text(
          'Personal Details',
          style: TextStyle(
              fontSize: 20, color: col60, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Container(
          decoration: BoxDecoration(
              color: col30, borderRadius: BorderRadius.circular(10)),
          child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: ListView(
              children: [
                gap20,
                const Text(
                  'Email',
                  style: TextStyle(fontSize: 16),
                ),
                gap10,
                TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                      hintText: 'Your Email',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12))),
                ),
                gap20,
                const Text(
                  'Full Name',
                  style: TextStyle(fontSize: 16),
                ),
                gap10,
                TextFormField(
                  controller: _name,
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                      hintText: 'Your name',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12))),
                ),
                gap20,
                const Text(
                  'Age',
                  style: TextStyle(fontSize: 16),
                ),
                gap10,
                TextFormField(
                  controller: _age,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      hintText: 'Your age',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12))),
                ),
                gap20,
                const Text(
                  'Gender',
                  style: TextStyle(fontSize: 16),
                ),
                gap10,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        if (_stype == 0 || _stype != 1) {
                          setState(() {
                            _stype = 1;
                          });
                        } else {
                          setState(() {
                            _stype = 0;
                          });
                        }
                      },
                      style: ButtonStyle(
                        minimumSize: WidgetStatePropertyAll(Size(30, 40)),
                        backgroundColor: const WidgetStatePropertyAll(col30),
                        shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          side: BorderSide(
                              color: _stype == 1
                                  ? col60
                                  : Colors.white), // Border color
                        )),
                      ),
                      child: const Text('Male'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (_stype == 0 || _stype != 2) {
                          setState(() {
                            _stype = 2;
                          });
                        } else {
                          setState(() {
                            _stype = 0;
                          });
                        }
                      },
                      style: ButtonStyle(
                        minimumSize: WidgetStatePropertyAll(Size(30, 40)),
                        backgroundColor: const WidgetStatePropertyAll(col30),
                        shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          side: BorderSide(
                              color: _stype == 2
                                  ? col60
                                  : Colors.white), // Border color
                        )),
                      ),
                      child: const Text('Female'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (_stype == 0 || _stype != 3) {
                          setState(() {
                            _stype = 3;
                          });
                        } else {
                          setState(() {
                            _stype = 0;
                          });
                        }
                      },
                      style: ButtonStyle(
                        minimumSize: WidgetStatePropertyAll(Size(30, 40)),
                        backgroundColor: const WidgetStatePropertyAll(col30),
                        shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          side: BorderSide(
                              color: _stype == 3
                                  ? col60
                                  : Colors.white), // Border color
                        )),
                      ),
                      child: const Text('Other'),
                    ),
                  ],
                ),
                gap20,
                const Text(
                  'Place',
                  style: TextStyle(fontSize: 16),
                ),
                gap10,
                TextFormField(
                  controller: _place,
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                      hintText: 'Your Place',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12))),
                ),
                gap20,
                const Text(
                  'PinCode',
                  style: TextStyle(fontSize: 16),
                ),
                gap10,
                TextFormField(
                  controller: _pin,
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                      hintText: 'Your pincode',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12))),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: size.width * .2, vertical: 10),
                  child: ElevatedButton(
                      style: const ButtonStyle(
                          backgroundColor: WidgetStatePropertyAll(col30)),
                      onPressed: () {
                        FirebaseFirestore.instance
                            .collection("Users")
                            .doc(Auth().currentUser!.uid)
                            .set({
                          'name': _name.text,
                          'place': _place.text,
                          'age': _age.text,
                          'pin': _pin.text,
                          'email': _emailController.text,
                          'gender': _stype,
                          'time': DateTime.now()
                        });
                        Navigator.pop(context);
                      },
                      child: const Text('Save')),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
