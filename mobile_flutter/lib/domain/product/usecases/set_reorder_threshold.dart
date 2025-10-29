import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../core/failure.dart';
import '../entities/product.dart';
import '../repositories/product_repository.dart';

/// Params holder for SetReorderThreshold use case.
/// Keeping params as an Equatable value object makes tests cleaner.
class SetReorderThresholdParams extends Equatable {
  final String productId;
  final int threshold;

  const SetReorderThresholdParams({
    required this.productId,
    required this.threshold,
  });

  @override
  List<Object?> get props => [productId, threshold];
}

class SetReorderThreshold {
  final ProductRepository repository;
  SetReorderThreshold(this.repository);

  Future<Either<Failure, Product>> call(SetReorderThresholdParams params) async {
    return repository.setReorderThreshold(params.productId, params.threshold);
  }
}