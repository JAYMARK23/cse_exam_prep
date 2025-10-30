import 'package:dartz/dartz.dart';
import '../../core/failure.dart';
import '../entities/product.dart';
import '../repositories/product_repository.dart';

class GetProducts {
  final ProductRepository repository;
  GetProducts(this.repository);

  Future<Either<Failure, List<Product>>> call() async {
    return repository.getProducts();
  }
}