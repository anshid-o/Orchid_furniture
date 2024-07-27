import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:orchid_furniture/backend/auth/auth.dart';
import 'package:orchid_furniture/constants.dart';

class AddAddress extends StatelessWidget {
  AddAddress({super.key, required this.p1, required this.p2});
  List<int> p1;
  List<String> p2;

  TextEditingController _place = TextEditingController();
  TextEditingController _name = TextEditingController();
  TextEditingController _price = TextEditingController();
  TextEditingController _pincode = TextEditingController();
  TextEditingController _phone = TextEditingController();
  TextEditingController _other = TextEditingController();
  TextEditingController _sqft = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: col5,
      appBar: AppBar(
        backgroundColor: col5,
        titleSpacing: size.width * .2,
        title: const Text(
          'Contact details',
          style: TextStyle(
              fontSize: 20, color: col60, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Container(
          decoration: BoxDecoration(
              color: col30, borderRadius: BorderRadius.circular(10)),
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: ListView(
                children: [
                  gap20,
                  const Text(
                    'Name',
                    style: TextStyle(fontSize: 16),
                  ),
                  gap10,
                  TextFormField(
                    controller: _name,
                    keyboardType: TextInputType.name,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please Enter name';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        hintText: 'Property name',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12))),
                  ),
                  gap20,
                  const Text(
                    'Price',
                    style: TextStyle(fontSize: 16),
                  ),
                  gap10,
                  TextFormField(
                    controller: _price,
                    keyboardType: TextInputType.name,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please Enter Amount to be paid';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        hintText: 'Enter Price',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12))),
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
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please Enter location';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        hintText: 'Enter Location',
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
                    controller: _pincode,
                    keyboardType: TextInputType.name,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please Enter pincode';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        hintText: 'Enter Pincode',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12))),
                  ),
                  gap20,
                  const Text(
                    'Phone',
                    style: TextStyle(fontSize: 16),
                  ),
                  gap10,
                  TextFormField(
                    controller: _phone,
                    keyboardType: TextInputType.name,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please Enter contact number';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        hintText: 'Contact Number',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12))),
                  ),
                  gap20,
                  const Text(
                    'Square feet',
                    style: TextStyle(fontSize: 16),
                  ),
                  gap10,
                  TextFormField(
                    controller: _sqft,
                    keyboardType: TextInputType.name,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please Enter sqft';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        hintText: 'Enter Total sqft',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12))),
                  ),
                  gap20,
                  const Text(
                    'Other',
                    style: TextStyle(fontSize: 16),
                  ),
                  gap10,
                  TextFormField(
                    maxLines: 3,
                    controller: _other,
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                        hintText: 'Other details',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12))),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: size.width * .2, vertical: 10),
                    child: ElevatedButton(
                        style: const ButtonStyle(
                            backgroundColor: WidgetStatePropertyAll(col10)),
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            await FirebaseFirestore.instance
                                .collection("Posts")
                                .add({
                              'bassic': p1,
                              'images': p2,
                              'name': _name.text,
                              'place': _place.text,
                              'price': _price.text,
                              'phone': _phone.text,
                              'pincode': _pincode.text,
                              'sqft': _sqft.text,
                              'other': _other.text,
                              'uid': Auth().currentUser!.uid,
                              'time': DateTime.now()
                            });

                            Navigator.pop(context);
                          }
                        },
                        child: const Text(
                          'Post',
                          style: TextStyle(
                              color: col30,
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                        )),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
