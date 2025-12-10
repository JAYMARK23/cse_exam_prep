import 'package:dartz/dartz.dart';

import '../entities/product.dart';
import '../repositories/product_repository.dart';
import '../../core/failure.dart';

class GetProducts {
  final ProductRepository repository;

  GetProducts(this.repository);

  Future<Either<Failure, List<Product>>> call() async {
    return await repository.getProducts();
  }
}

class GetProductById {
  final ProductRepository repository;

  GetProductById(this.repository);

  Future<Either<Failure, Product>> call(String id) async {
    return await repository.getProductById(id);
  }
}

class AddProduct {
  final ProductRepository repository;

  AddProduct(this.repository);

  Future<Either<Failure, Product>> call(Product product) async {
    return await repository.addProduct(product);
  }
}

class UpdateProduct {
  final ProductRepository repository;

  UpdateProduct(this.repository);

  Future<Either<Failure, Product>> call(Product product) async {
    return await repository.updateProduct(product);
  }
}

class DeleteProduct {
  final ProductRepository repository;

  DeleteProduct(this.repository);

  Future<Either<Failure, Unit>> call(String id) async {
    return await repository.deleteProduct(id);
  }
}

class SetReorderThreshold {
  final ProductRepository repository;

  SetReorderThreshold(this.repository);

  Future<Either<Failure, Product>> call(String productId, int threshold) async {
    return await repository.setReorderThreshold(productId, threshold);
  }
}
