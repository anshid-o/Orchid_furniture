import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:clay_containers/clay_containers.dart';
import 'package:orchid_furniture/constants.dart';
import 'package:orchid_furniture/widgets/image_preview.dart';

class EconomicDetailsPage extends StatefulWidget {
  @override
  _EconomicDetailsPageState createState() => _EconomicDetailsPageState();
}

class _EconomicDetailsPageState extends State<EconomicDetailsPage> {
  Future<List<Map<String, dynamic>>> _fetchProductDetails() async {
    QuerySnapshot productSnapshot =
        await FirebaseFirestore.instance.collection('products').get();
    QuerySnapshot salesSnapshot =
        await FirebaseFirestore.instance.collection('sales').get();

    List<Map<String, dynamic>> productList = productSnapshot.docs.map((doc) {
      var data = doc.data() as Map<String, dynamic>;
      data['productId'] = doc.id;
      data['soldStock'] = 0;
      data['soldAmount'] = 0.0;
      data['totalProfit'] = 0.0;
      return data;
    }).toList();

    for (var sale in salesSnapshot.docs) {
      var saleData = sale.data() as Map<String, dynamic>;
      var productId = saleData['productId'];
      var product = productList.firstWhere((p) => p['productId'] == productId);

      product['soldStock'] += saleData['itemCount'];
      product['soldAmount'] += product['sellPrice'];
      // print(
      //     '${product['sellPrice']} - ${product['price']} * ${saleData['itemCount']}');
      product['totalProfit'] +=
          ((product['sellPrice'] - product['price']) * saleData['itemCount']);
    }

    return productList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightWoodcol,
      appBar: AppBar(
        backgroundColor: lightWoodcol,
        title: const Text('Economic Details'),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _fetchProductDetails(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          var productList = snapshot.data!;
          productList.forEach(
            (element) {
              print(element['totalProfit']);
            },
          );
          double companyTotalProfit = productList.fold(
              0.0, (sum, product) => sum + product['totalProfit']);
          double totalCostRemainingProducts = productList.fold(0.0,
              (sum, product) => sum + (product['price'] * product['stock']));
          int totalStockSold = productList.fold(
              0,
              (sum, product) =>
                  sum + int.parse(product['soldStock'].toString()));
          int totalStockRemaining = productList.fold(0,
              (sum, product) => sum + int.parse(product['stock'].toString()));

          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: ClayContainer(
                  color: lightWoodcol,
                  borderRadius: 15,
                  depth: 20,
                  spread: 5,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Company Total Profit: \$${companyTotalProfit.toStringAsFixed(2)}',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          'Total Cost of Remaining Products: \$${totalCostRemainingProducts.toStringAsFixed(2)}',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.red,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          'Total Stock Sold: $totalStockSold',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          'Total Stock Remaining: $totalStockRemaining',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.orange,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: productList.length,
                  itemBuilder: (context, index) {
                    var product = productList[index];

                    return Card(
                      color: Colors.white,
                      margin: const EdgeInsets.all(10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      elevation: 5,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ListTile(
                            leading: InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ImageViewPage(
                                      imageUrl: product['url'],
                                      heroTag: product['url'],
                                    ),
                                  ),
                                );
                              },
                              child: Hero(
                                tag: product['url'],
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(15),
                                  child: Image.network(
                                    product['url'],
                                    fit: BoxFit.cover,
                                    width: 80,
                                    height: 80,
                                  ),
                                ),
                              ),
                            ),
                            title: Text(
                              product['name'],
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Text(
                              'Purchase Price: \$${product['price']}',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey[700],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16.0, vertical: 8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Sold Stock: ${product['soldStock']}',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.grey[700],
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  'Sold Amount: \$${product['soldAmount']}',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.grey[700],
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  'Total Profit: \$${(product['soldStock'] * (product['soldAmount'] - product['price'])).toStringAsFixed(2)}',
                                  style: const TextStyle(
                                    fontSize: 16,
                                    color: Colors.green,
                                  ),
                                ),
                                Text(
                                  'Total Cost of remining: \$${(product['stock'] * product['price']).toStringAsFixed(2)}',
                                  style: const TextStyle(
                                    fontSize: 16,
                                    color: Colors.red,
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  'Remaining Stock: ${product['stock']}',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.grey[700],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
