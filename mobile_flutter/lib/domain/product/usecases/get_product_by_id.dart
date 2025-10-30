import 'package:dartz/dartz.dart';
import '../../core/failure.dart';
import '../entities/product.dart';
import '../repositories/product_repository.dart';

class GetProductById {
  final ProductRepository repository;
  GetProductById(this.repository);

  Future<Either<Failure, Product>> call(String id) async {
    return repository.getProductById(id);
  }
}