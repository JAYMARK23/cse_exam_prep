import 'package:dartz/dartz.dart';
import '../../core/failure.dart';
import '../entities/product.dart';
import '../repositories/product_repository.dart';

class UpdateProduct {
  final ProductRepository repository;
  UpdateProduct(this.repository);

  Future<Either<Failure, Product>> call(Product product) async {
    return repository.updateProduct(product);
  }
}