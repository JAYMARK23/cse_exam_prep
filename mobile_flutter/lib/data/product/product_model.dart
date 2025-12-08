import 'package:cloud_firestore/cloud_firestore.dart';

import '../../domain/product/entities/product.dart';

class ProductModel extends Product {
  const ProductModel({
    required String id,
    required String name,
    String? sku,
    String? barcode,
    String? category,
    int reorderThreshold = 0,
    String? supplierId,
    String? imageUrl,
    String? notes,
    DateTime? createdAt,
  }) : super(
          id: id,
          name: name,
          sku: sku,
          barcode: barcode,
          category: category,
          reorderThreshold: reorderThreshold,
          supplierId: supplierId,
          imageUrl: imageUrl,
          notes: notes,
          createdAt: createdAt,
        );

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    DateTime? created;
    final ts = map['createdAt'];
    if (ts is Timestamp) {
      created = ts.toDate();
    } else if (ts is String) {
      created = DateTime.tryParse(ts);
    } else if (ts is int) {
      created = DateTime.fromMillisecondsSinceEpoch(ts);
    }

    return ProductModel(
      id: (map['id'] ?? map['uid'] ?? '') as String,
      name: (map['name'] ?? '') as String,
      sku: map['sku'] as String?,
      barcode: map['barcode'] as String?,
      category: map['category'] as String?,
      reorderThreshold: (map['reorderThreshold'] as num?)?.toInt() ?? 0,
      supplierId: map['supplierId'] as String?,
      imageUrl: map['imageUrl'] as String?,
      notes: map['notes'] as String?,
      createdAt: created,
    );
  }

  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{
      'id': id,
      'name': name,
      'sku': sku,
      'barcode': barcode,
      'category': category,
      'reorderThreshold': reorderThreshold,
      'supplierId': supplierId,
      'imageUrl': imageUrl,
      'notes': notes,
    };
    if (createdAt != null) {
      map['createdAt'] = Timestamp.fromDate(createdAt!);
    }
    return map;
  }
}
