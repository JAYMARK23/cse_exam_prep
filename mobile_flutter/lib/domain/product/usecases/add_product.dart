import 'package:dartz/dartz.dart';
import '../../core/failure.dart';
import '../entities/product.dart';
import '../repositories/product_repository.dart';

class AddProduct {
  final ProductRepository repository;
  AddProduct(this.repository);

  Future<Either<Failure, Product>> call(Product product) async {
    return repository.addProduct(product);
  }
}