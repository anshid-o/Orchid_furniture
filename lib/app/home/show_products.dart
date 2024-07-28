import 'package:quickalert/quickalert.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:orchid_furniture/constants.dart';
import 'package:orchid_furniture/widgets/product_card.dart';

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
    if (widget.categ == 'All') {
      await FirebaseFirestore.instance
          .collection('products')
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
    } else {
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
  }

  Map<String, int> mysoldStockCounts = {};
  Future<void> fetchSoldStockCounts() async {
    QuerySnapshot salesSnapshot =
        await FirebaseFirestore.instance.collection('sales').get();

    Map<String, int> soldStockCounts = {};

    for (var sale in salesSnapshot.docs) {
      var saleData = sale.data() as Map<String, dynamic>;
      var productId = saleData['productId'];
      var itemCount =
          saleData['itemCount'] as num; // Ensure itemCount is treated as num

      if (soldStockCounts.containsKey(productId)) {
        soldStockCounts[productId] =
            soldStockCounts[productId]! + itemCount.toInt();
      } else {
        soldStockCounts[productId] = itemCount.toInt();
      }
    }
    setState(() {
      mysoldStockCounts = soldStockCounts;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    getProducts();
    fetchSoldStockCounts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightWoodcol,
      appBar: AppBar(
        title: Text('${widget.categ} Products'),
        backgroundColor: lightWoodcol,
      ),
      body: products.length == 0
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
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
                  soldCount: mysoldStockCounts.containsKey(pids[index])
                      ? mysoldStockCounts[pids[index]]!
                      : 0,
                  onDelete: () async {
                    QuickAlert.show(
                      context: context,
                      type: QuickAlertType.confirm,
                      title: 'Confirm',
                      text: 'Are you sure you want to delete?',
                      cancelBtnText: 'No',
                      confirmBtnText: 'Yes',
                      onConfirmBtnTap: () async {
                        await FirebaseFirestore.instance
                            .collection('products')
                            .doc(pids[index])
                            .delete();
                        setState(() {
                          products.removeAt(index);
                          pids.removeAt(index);
                        });
                      },
                      onCancelBtnTap: () {
                        Navigator.pop(context);
                      },
                    );
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
                  len: product['length'],
                  width: product['width'],
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
