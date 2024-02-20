import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

import 'test.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(BarcodeApp());
}

class BarcodeApp extends StatelessWidget {
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

  Future<void> startBarcodeScanStream() async {
    FlutterBarcodeScanner.getBarcodeStreamReceiver(
      '#ff6666', 'Cancel', true, ScanMode.BARCODE,
    )!.listen((barcode) {
      print(barcode);
      _showPopupForm();
    });
  }

  Future<void> scanQR() async {
    String barcodeScanRes;
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
        '#ff6666', 'Cancel', true, ScanMode.QR,
      );
      print(barcodeScanRes);
      _showPopupForm();
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }

    if (!mounted) return;

    setState(() {
      _scanBarcode = barcodeScanRes;
    });
  }

  Future<void> scanBarcodeNormal() async {
    String barcodeScanRes;
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
        '#ff6666', 'Cancel', true, ScanMode.BARCODE,
      );
      print(barcodeScanRes);
      _showPopupForm();
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }

    if (!mounted) return;

    setState(() {
      _scanBarcode = barcodeScanRes;
    });
  }

  void _showPopupForm() {
    itemIdController.text = _scanBarcode;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Item Information'),
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
                  decoration: InputDecoration(labelText: 'Name'),
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
                // Use _scanBarcode directly for the barcode value
                String barcode = _scanBarcode;
                String name = nameController.text;
                String description = descriptionController.text;
                String stock = stockController.text;
                String price = priceController.text;

                try {
                  // Save the data to Firebase Firestore
                  await saveDataToFirestore(barcode, name, description, stock, price);
                  _showResultDialog(context, 'Success', 'Data successfully stored.');
                } catch (e) {
                  _showResultDialog(context, 'Error', 'Error storing data: $e');
                }

                // Close the popup
                Navigator.of(context).pop();
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }

  Future<void> saveDataToFirestore(
      String itemId, String name, String description, String stock, String price,
      ) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    // Replace 'products' with the actual name of your Firestore collection
    CollectionReference productCollection = firestore.collection('products');

    // Add data to Firestore
    await productCollection.add({
      'bareCode': itemId,
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
          content: Text(message),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        initialIndex: 0,
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Gestion de stock'),
            bottom: const TabBar(
              tabs: <Widget>[
                Tab(
                  icon: Icon(Icons.add_shopping_cart),
                  text: "Vendre",
                ),
                Tab(
                  icon: Icon(Icons.list),
                  text: "Stock",
                ),
              ],
            ),
          ),
          body:  TabBarView(
            children: <Widget>[
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    ElevatedButton(
                      onPressed: () => scanBarcodeNormal(),
                      child: Text('Start barcode scan'),
                    ),
                    ElevatedButton(
                      onPressed: () => scanQR(),
                      child: Text('Start QR scan'),
                    ),
                  ],
                ),
              ),
              Center(
                child: ProductList(),
              ),

              // ProductList(),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () => scanBarcodeNormal(),
            tooltip: 'Add Product',
            child: Icon(Icons.add),
          ),
        ),
      ),
    );
  }
}