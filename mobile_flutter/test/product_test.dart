import 'package:flutter_test/flutter_test.dart';

import '../lib/data/product/product_model.dart';
import '../lib/domain/product/entities/product.dart';

void main() {
  group('Product Architecture Tests', () {
    test('Product entity should work correctly', () {
      // Test basic product creation
      final product = Product(
        id: 'test-id',
        name: 'Test Product',
        sku: 'TEST-001',
        reorderThreshold: 5,
      );

      expect(product.id, equals('test-id'));
      expect(product.name, equals('Test Product'));
      expect(product.reorderThreshold, equals(5));
    });

    test('ProductModel should extend Product entity', () {
      // Test model creation
      final product = ProductModel(
        id: 'test-id',
        name: 'Test Product',
        sku: 'TEST-001',
        reorderThreshold: 5,
      );

      expect(product, isA<Product>());
      expect(product.id, equals('test-id'));
      expect(product.name, equals('Test Product'));
    });

    test('ProductModel should handle copyWith correctly', () {
      // Test copyWith functionality
      final original = ProductModel(
        id: 'original-id',
        name: 'Original Product',
        reorderThreshold: 5,
      );

      final modified = original.copyWith(
        name: 'Modified Product',
        reorderThreshold: 10,
      );

      expect(modified.id, equals('original-id'));
      expect(modified.name, equals('Modified Product'));
      expect(modified.reorderThreshold, equals(10));
    });

    test('ProductModel should convert to and from map', () {
      // Test serialization
      final original = ProductModel(
        id: 'test-id',
        name: 'Test Product',
        sku: 'TEST-001',
        reorderThreshold: 5,
      );

      final map = original.toMap();
      final restored = ProductModel.fromMap(map);

      expect(restored.id, equals(original.id));
      expect(restored.name, equals(original.name));
      expect(restored.sku, equals(original.sku));
      expect(restored.reorderThreshold, equals(original.reorderThreshold));
    });

    test('ProductModel should handle createdAt timestamp', () {
      // Test timestamp handling
      final date = DateTime.now();
      final product = ProductModel(
        id: 'test-id',
        name: 'Test Product',
        createdAt: date,
      );

      final map = product.toMap();
      final restored = ProductModel.fromMap(map);

      expect(restored.createdAt, isNotNull);
    });
  });
}
