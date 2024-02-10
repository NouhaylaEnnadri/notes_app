import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(test());
}

class test extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BarcodeScreen(),
    );
  }
}

class BarcodeScreen extends StatefulWidget {
  @override
  _BarcodeScreenState createState() => _BarcodeScreenState();
}

class _BarcodeScreenState extends State<BarcodeScreen> {
  String _scanBarcode = 'Unknown';
  TextEditingController itemIdController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController stockController = TextEditingController();
  TextEditingController priceController = TextEditingController();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final CollectionReference _productCollection = FirebaseFirestore.instance.collection('products');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Product List')),
      body: ProductList(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => scanBarcodeNormal(),
        tooltip: 'Add Product',
        child: Icon(Icons.add),
      ),
    );
  }

  Future<void> scanBarcodeNormal() async {
    String barcodeScanRes;
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
        '#ff6666', 'Cancel', true, ScanMode.BARCODE,
      );
      print(barcodeScanRes);
      _showPopupForm(context);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }

    if (!mounted) return;

    setState(() {
      _scanBarcode = barcodeScanRes;
    });
  }

  void _showPopupForm(BuildContext context) {
    itemIdController.text = _scanBarcode;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add Product'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  controller: itemIdController,
                  enabled: false,
                  cursorColor: Colors.transparent,
                  decoration: InputDecoration(labelText: 'Item ID'),
                ),
                TextField(
                  controller: nameController,
                  decoration: InputDecoration(labelText: 'Product Name'),
                ),
                TextField(
                  controller: descriptionController,
                  decoration: InputDecoration(labelText: 'Description'),
                ),
                TextField(
                  controller: stockController,
                  decoration: InputDecoration(labelText: 'Stock'),
                ),
                TextField(
                  controller: priceController,
                  decoration: InputDecoration(labelText: 'Price'),
                ),
              ],
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () async {
                String name = nameController.text;
                String description = descriptionController.text;
                String stock = stockController.text;
                String price = priceController.text;

                try {
                  await saveDataToFirestore(name, description, stock, price);
                  _showResultDialog(context, 'Success', 'Product added successfully.');
                  // Clear the controllers after adding the product
                  nameController.clear();
                  descriptionController.clear();
                  stockController.clear();
                  priceController.clear();
                } catch (e) {
                  _showResultDialog(context, 'Error', 'Error adding product: $e');
                }

                Navigator.of(context).pop(); // Close the form dialog
              },
              child: Text('Add'),
            ),
          ],
        );
      },
    );
  }

  Future<void> saveDataToFirestore(String name, String description, String stock, String price) async {
    await _productCollection.add({
      'name': name,
      'description': description,
      'stock': stock,
      'price': price,
    });
  }

  void _showResultDialog(BuildContext context, String title, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Column(
            children: [
              Text(message),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Close the result dialog
                },
                child: Text('OK'),
              ),
            ],
          ),
        );
      },
    );
  }
}

class ProductList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('products').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return CircularProgressIndicator();
        }

        var products = snapshot.data!.docs;

        return ListView.builder(
          itemCount: products.length,
          itemBuilder: (context, index) {
            var product = products[index].data() as Map<String, dynamic>;
            return Card(
              child: ListTile(
                title: Text(product['name']),
                subtitle: Text('Stock: ${product['stock']}, Price: ${product['price']}'),
                trailing: IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    _showDeleteConfirmationDialog(context, products[index].id);
                  },
                ),
              ),
            );
          },
        );
      },
    );
  }

  void _showDeleteConfirmationDialog(BuildContext context, String productId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Delete Product'),
          content: Text('Are you sure you want to delete this product?'),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () async {
                await deleteProduct(productId);
                Navigator.of(context).pop(); // Close the confirmation dialog
              },
              child: Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  Future<void> deleteProduct(String productId) async {
    await FirebaseFirestore.instance.collection('product').doc(productId).delete();
  }
}
