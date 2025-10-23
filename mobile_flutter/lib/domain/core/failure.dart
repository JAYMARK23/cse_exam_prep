import 'package:equatable/equatable.dart';

/// Base Failure type for domain errors
abstract class Failure extends Equatable {
  final String message;

  const Failure(this.message);

  @override
  List<Object?> get props => [message];
}
