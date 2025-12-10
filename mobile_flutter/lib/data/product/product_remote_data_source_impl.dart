import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';

import 'product_model.dart';
import 'product_remote_data_source.dart';

class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
  final FirebaseFirestore firestore;

  ProductRemoteDataSourceImpl({required this.firestore});

  CollectionReference get _productsCollection =>
      firestore.collection('products');

  @override
  Future<List<ProductModel>> getProducts() async {
    try {
      final QuerySnapshot snapshot = await _productsCollection.get();
      return snapshot.docs
          .map(
              (doc) => ProductModel.fromMap(doc.data() as Map<String, dynamic>))
          .toList();
    } catch (e) {
      throw Exception('Failed to fetch products: $e');
    }
  }

  @override
  Future<ProductModel> getProductById(String id) async {
    try {
      final DocumentSnapshot doc = await _productsCollection.doc(id).get();
      if (!doc.exists) {
        throw Exception('Product not found');
      }
      return ProductModel.fromMap(doc.data() as Map<String, dynamic>);
    } catch (e) {
      throw Exception('Failed to fetch product: $e');
    }
  }

  @override
  Future<ProductModel> addProduct(ProductModel product) async {
    try {
      // If no ID is provided, generate one
      final String productId =
          product.id.isEmpty ? _productsCollection.doc().id : product.id;

      final Map<String, dynamic> productData = product.toMap();
      productData['id'] = productId; // Ensure ID is in the data

      await _productsCollection.doc(productId).set(productData);

      return product.copyWith(id: productId);
    } catch (e) {
      throw Exception('Failed to add product: $e');
    }
  }

  @override
  Future<ProductModel> updateProduct(ProductModel product) async {
    try {
      if (product.id.isEmpty) {
        throw Exception('Product ID is required for update');
      }

      final Map<String, dynamic> productData = product.toMap();

      await _productsCollection.doc(product.id).update(productData);

      return product;
    } catch (e) {
      throw Exception('Failed to update product: $e');
    }
  }

  @override
  Future<Unit> deleteProduct(String id) async {
    try {
      await _productsCollection.doc(id).delete();
      return unit;
    } catch (e) {
      throw Exception('Failed to delete product: $e');
    }
  }

  @override
  Future<ProductModel> setReorderThreshold(
      String productId, int threshold) async {
    try {
      await _productsCollection.doc(productId).update({
        'reorderThreshold': threshold,
      });

      // Return the updated product
      return getProductById(productId);
    } catch (e) {
      throw Exception('Failed to set reorder threshold: $e');
    }
  }
}
