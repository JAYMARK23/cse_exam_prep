import 'package:equatable/equatable.dart';

class Product extends Equatable {
  final String id;
  final String name;
  final String? sku;
  final String? barcode;
  final String? category;
  final int reorderThreshold;
  final String? supplierId;
  final String? imageUrl;
  final String? notes;
  final DateTime? createdAt;

  const Product({
    required this.id,
    required this.name,
    this.sku,
    this.barcode,
    this.category,
    this.reorderThreshold = 0,
    this.supplierId,
    this.imageUrl,
    this.notes,
    this.createdAt,
  });

  Product copyWith({
    String? id,
    String? name,
    String? sku,
    String? barcode,
    String? category,
    int? reorderThreshold,
    String? supplierId,
    String? imageUrl,
    String? notes,
    DateTime? createdAt,
  }) {
    return Product(
      id: id ?? this.id,
      name: name ?? this.name,
      sku: sku ?? this.sku,
      barcode: barcode ?? this.barcode,
      category: category ?? this.category,
      reorderThreshold: reorderThreshold ?? this.reorderThreshold,
      supplierId: supplierId ?? this.supplierId,
      imageUrl: imageUrl ?? this.imageUrl,
      notes: notes ?? this.notes,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
        sku,
        barcode,
        category,
        reorderThreshold,
        supplierId,
        imageUrl,
        notes,
        createdAt,
      ];
}