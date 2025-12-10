import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';

import 'product_remote_data_source.dart';
import 'product_model.dart';

class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
  final FirebaseFirestore firestore;
  ProductRemoteDataSourceImpl(this.firestore);

  CollectionReference get _col => firestore.collection('products');

  @override
  Future<ProductModel> addProduct(ProductModel product) async {
    final id = product.id.isNotEmpty ? product.id : _col.doc().id;
    final docRef = _col.doc(id);
    final map = product.toMap()..['id'] = id;
    await docRef.set(map);
    final snapshot = await docRef.get();
    final data = snapshot.data() as Map<String, dynamic>;
    data['id'] = snapshot.id;
    return ProductModel.fromMap(data);
  }

  @override
  Future<Unit> deleteProduct(String id) async {
    await _col.doc(id).delete();
    return unit;
  }

  @override
  Future<ProductModel> getProductById(String id) async {
    final snapshot = await _col.doc(id).get();
    if (!snapshot.exists) throw Exception('Product not found');
    final map = snapshot.data() as Map<String, dynamic>;
    map['id'] = snapshot.id;
    return ProductModel.fromMap(map);
  }

  @override
  Future<List<ProductModel>> getProducts() async {
    final snap = await _col.get();
    return snap.docs.map((d) {
      final map = d.data() as Map<String, dynamic>;
      map['id'] = d.id;
      return ProductModel.fromMap(map);
    }).toList();
  }

  @override
  Future<ProductModel> updateProduct(ProductModel product) async {
    final docRef = _col.doc(product.id);
    final map = product.toMap()..['id'] = product.id;
    await docRef.update(map);
    final snapshot = await docRef.get();
    final data = snapshot.data() as Map<String, dynamic>;
    data['id'] = snapshot.id;
    return ProductModel.fromMap(data);
  }

  @override
  Future<ProductModel> setReorderThreshold(
      String productId, int threshold) async {
    final docRef = _col.doc(productId);
    await docRef.update({'reorderThreshold': threshold});
    final snapshot = await docRef.get();
    if (!snapshot.exists) throw Exception('Product not found');
    final map = snapshot.data() as Map<String, dynamic>;
    map['id'] = snapshot.id;
    return ProductModel.fromMap(map);
  }
}
