import 'package:dartz/dartz.dart';

import 'product_model.dart';

abstract class ProductRemoteDataSource {
  Future<List<ProductModel>> getProducts();
  Future<ProductModel> getProductById(String id);
  Future<ProductModel> addProduct(ProductModel product);
  Future<ProductModel> updateProduct(ProductModel product);
  Future<Unit> deleteProduct(String id);
  Future<ProductModel> setReorderThreshold(String productId, int threshold);
}
