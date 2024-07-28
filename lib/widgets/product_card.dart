import 'package:flutter/material.dart';
import 'package:orchid_furniture/constants.dart';
import 'package:orchid_furniture/widgets/image_preview.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;

class ProductCard extends StatefulWidget {
  final String imageUrl;
  final String name;
  final int len;
  final int soldCount;
  final int width;
  final String description;
  final double price;
  final String phone;
  final String categ;
  final String heroTag; // Unique tag for Hero animation
  final int stock; // New property for available stock
  final VoidCallback onDelete; // Callback to delete product
  final VoidCallback onEdit; // Callback to edit product

  ProductCard({
    required this.imageUrl,
    this.len = 0,
    this.width = 0,
    this.soldCount = 0,
    required this.name,
    required this.categ,
    required this.description,
    required this.price,
    required this.phone,
    required this.heroTag,
    required this.stock, // Include stock in the constructor
    required this.onDelete,
    required this.onEdit,
  });

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  Future<void> _shareProduct() async {
    final urlPreviewer = widget.imageUrl;
    final response = await http.get(Uri.parse(urlPreviewer));
    final bytes = response.bodyBytes;

    final tempDir = await getTemporaryDirectory();
    final fileName = '${widget.name}.jpg';
    final path = '${tempDir.path}/$fileName';

    await File(path).writeAsBytes(bytes);
    final shareText = 'Check out this amazing furniture!\n\n'
        'Name: ${widget.name}\n'
        'Category: ${widget.categ}\n'
        'Description: ${widget.description}\n'
        'Price: \$${widget.price.toStringAsFixed(2)}\n'
        'Available Stock: ${widget.stock}\n\n'
        'Contact us at: ${widget.phone}';

    await Share.shareFiles(
      [path],
      text: shareText,
    );
  }

  Future<void> _makeCall() async {
    final phoneNumber = '+91${widget.phone}';
    final url = Uri(scheme: 'tel', path: phoneNumber);
    if (await canLaunch(url.toString())) {
      await launch(url.toString());
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 5,
      margin: EdgeInsets.all(10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ImageViewPage(
                    imageUrl: widget.imageUrl,
                    heroTag: widget.heroTag,
                  ),
                ),
              );
            },
            child: Hero(
              tag: widget.heroTag,
              child: ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
                child: Image.network(
                  widget.imageUrl,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: 150,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.name,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  widget.description,
                  style: TextStyle(
                    color: Colors.grey[700],
                  ),
                ),
                SizedBox(height: 10),
                widget.len != 0
                    ? Text(
                        'Size: ${widget.len} X ${widget.width} (cm)',
                        style: TextStyle(
                          color: Colors.grey[700],
                        ),
                      )
                    : SizedBox(),
                Text(
                  '\$${widget.price}',
                  style: TextStyle(
                    color: Colors.green,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                widget.soldCount != 0
                    ? Text(
                        'Sold Count: ${widget.soldCount}', // Display stock information
                        style: TextStyle(
                          color: Colors.green,
                          fontSize: 14,
                        ),
                      )
                    : SizedBox(),
                Text(
                  'Available Stock: ${widget.stock}', // Display stock information
                  style: TextStyle(
                    color: widget.stock > 5 ? col60 : Colors.red,
                    fontSize: 14,
                  ),
                ),
                Row(
                  children: [
                    IconButton(
                      onPressed: _shareProduct,
                      icon: Icon(Icons.share, color: Colors.blue),
                      tooltip: 'Share',
                    ),
                    IconButton(
                      onPressed: _makeCall,
                      icon: Icon(Icons.call, color: Colors.green),
                      tooltip: 'Call',
                    ),
                    Spacer(),
                    IconButton(
                      onPressed: widget.onEdit,
                      icon: Icon(Icons.edit, color: Colors.orange),
                      tooltip: 'Edit',
                    ),
                    IconButton(
                      onPressed: widget.onDelete,
                      icon: Icon(Icons.delete, color: Colors.red),
                      tooltip: 'Delete',
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
