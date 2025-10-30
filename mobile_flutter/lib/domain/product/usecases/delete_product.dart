import 'package:dartz/dartz.dart';
import '../../core/failure.dart';
import '../repositories/product_repository.dart';

class DeleteProduct {
  final ProductRepository repository;
  DeleteProduct(this.repository);

  Future<Either<Failure, Unit>> call(String id) async {
    return repository.deleteProduct(id);
  }
}