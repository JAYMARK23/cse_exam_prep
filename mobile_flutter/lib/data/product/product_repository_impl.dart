import 'package:dartz/dartz.dart';

import '../../domain/core/failure.dart';
import '../../domain/product/entities/product.dart';
import '../../domain/product/repositories/product_repository.dart';
import '../core/data_failure.dart';
import 'product_model.dart';
import 'product_remote_data_source.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteDataSource remote;
  ProductRepositoryImpl(this.remote);

  @override
  Future<Either<Failure, Product>> addProduct(Product product) async {
    try {
      final model = await remote.addProduct(product as ProductModel);
      return Right(model);
    } catch (e) {
      return Left(DataFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteProduct(String id) async {
    try {
      final res = await remote.deleteProduct(id);
      return Right(res);
    } catch (e) {
      return Left(DataFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Product>> getProductById(String id) async {
    try {
      final model = await remote.getProductById(id);
      return Right(model);
    } catch (e) {
      return Left(DataFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Product>>> getProducts() async {
    try {
      final list = await remote.getProducts();
      return Right(list);
    } catch (e) {
      return Left(DataFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Product>> updateProduct(Product product) async {
    try {
      final model = await remote.updateProduct(product as ProductModel);
      return Right(model);
    } catch (e) {
      return Left(DataFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Product>> setReorderThreshold(String productId, int threshold) async {
    try {
      final model = await remote.setReorderThreshold(productId, threshold);
      return Right(model);
    } catch (e) {
      return Left(DataFailure(e.toString()));
    }
  }
}
