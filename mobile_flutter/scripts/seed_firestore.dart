import 'package:flutter/widgets.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../lib/firebase_options.dart';

// Simple Firestore seeder for UAT. Run this with the Flutter tool, for example:
// flutter pub run flutter_launcher_name:main  (or run as a simple dart entry from an IDE using the Flutter runtime)

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Route Firestore calls to the local emulator at localhost:8080 when running option B.
  // You can override by setting the FIRESTORE_EMULATOR_HOST environment variable
  // in the form host:port (e.g. localhost:8080).
  final emulatorEnv = const String.fromEnvironment('FIRESTORE_EMULATOR_HOST');
  if (emulatorEnv.isNotEmpty) {
    final parts = emulatorEnv.split(':');
    final host = parts.isNotEmpty ? parts[0] : 'localhost';
    final port = parts.length > 1 ? int.tryParse(parts[1]) ?? 8080 : 8080;
    FirebaseFirestore.instance.useFirestoreEmulator(host, port);
    print('Using Firestore emulator at $host:$port');
  } else {
    // Default to localhost:8080 for convenience when running locally
    FirebaseFirestore.instance.useFirestoreEmulator('localhost', 8080);
    print('Using Firestore emulator at localhost:8080');
  }

  final firestore = FirebaseFirestore.instance;
  print('Starting Firestore seed...');

  try {
    final supplierRef = await firestore.collection('suppliers').add({
      'name': 'Acme Supplies',
      'contact': 'acme@example.com',
      'phone': '1234567890',
      'createdAt': FieldValue.serverTimestamp(),
    });
    print('Created supplier ${supplierRef.id}');

    final productRef = await firestore.collection('products').add({
      'name': 'Paper Towels',
      'sku': 'PT-001',
      'barcode': 'PT001',
      'category': 'Cleaning',
      'reorderThreshold': 5,
      'supplierId': supplierRef.id,
      'imageUrl': null,
      'notes': 'UAT seed product',
      'createdAt': FieldValue.serverTimestamp(),
    });
    print('Created product ${productRef.id}');

    await firestore.collection('stocks').add({
      'productId': productRef.id,
      'change': 10,
      'type': 'in',
      'note': 'Initial stock',
      'createdAt': FieldValue.serverTimestamp(),
    });
    print('Created initial stock for product ${productRef.id}');

    print('Firestore seed complete');
  } catch (e) {
    print('Error during seeding: $e');
  }
}
