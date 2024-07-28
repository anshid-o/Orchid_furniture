import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:orchid_furniture/constants.dart';
import 'package:orchid_furniture/widgets/home_card.dart';

class ProductListPage extends StatefulWidget {
  ProductListPage({super.key, required this.categ});
  String categ;
  @override
  State<ProductListPage> createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  final List<Map<String, dynamic>> products = [];
  final List<String> pids = [];
  getProducts() async {
    await FirebaseFirestore.instance
        .collection('products')
        .where('category', isEqualTo: widget.categ)
        .orderBy('time')
        .get()
        .then(
      (value) {
        value.docs.forEach(
          (element) {
            setState(() {
              products.add(element.data());
              pids.add(element.id);
            });
          },
        );
      },
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    getProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.categ} Products'),
        backgroundColor: lightWoodcol,
      ),
      body: products.length == 0
          ? Column(
              children: [
                gap20,
                Lottie.asset('assets/empty.json'),
                Text(
                  'No ${widget.categ} added',
                  style: TextStyle(fontSize: isPhone ? 18 : 26),
                )
              ],
            )
          : ListView.builder(
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];
                return ProductCard(
                  onDelete: () async {
                    await FirebaseFirestore.instance
                        .collection('products')
                        .doc(pids[index])
                        .delete();
                    setState(() {
                      products.removeAt(index);
                      pids.removeAt(index);
                    });
                  },
                  onEdit: () => _editProduct(
                      context,
                      product['name'],
                      product['desc'],
                      double.parse(product['price'].toString()),
                      product['stock'],
                      index),
                  stock: product['stock'],
                  heroTag: index.toString(),
                  phone: '9048011615',
                  categ: widget.categ,
                  imageUrl: product['url'],
                  name: product['name'],
                  description: product['desc'],
                  price: double.parse(product['price'].toString()),
                );
              },
            ),
    );
  }

  void _editProduct(BuildContext context, String name, String description,
      double price, int stock, int index) {
    TextEditingController nameController = TextEditingController(text: name);
    TextEditingController descriptionController =
        TextEditingController(text: description);
    TextEditingController priceController =
        TextEditingController(text: price.toString());
    TextEditingController stockController =
        TextEditingController(text: stock.toString());

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Edit Product'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: InputDecoration(labelText: 'Name'),
              ),
              TextField(
                controller: descriptionController,
                decoration: InputDecoration(labelText: 'Description'),
              ),
              TextField(
                controller: priceController,
                decoration: InputDecoration(labelText: 'Price'),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: stockController,
                decoration: InputDecoration(labelText: 'Stock'),
                keyboardType: TextInputType.number,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                // Check if priceController value is an int, convert to double if so
                double parsedPrice =
                    double.tryParse(priceController.text) ?? 0.0;
                int parsedStock = int.tryParse(stockController.text) ?? 0;

                // Update Firestore
                await FirebaseFirestore.instance
                    .collection('products')
                    .doc(pids[index])
                    .update({
                  'name': nameController.text,
                  'description': descriptionController.text,
                  'price': parsedPrice,
                  'stock': parsedStock,
                });

                // Call update function or update state

                Navigator.pop(context);
                setState(() {
                  products[index]['name'] = nameController.text;
                  products[index]['desc'] = descriptionController.text;
                  products[index]['price'] = parsedPrice;
                  products[index]['stock'] = parsedStock;
                });
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }
}
