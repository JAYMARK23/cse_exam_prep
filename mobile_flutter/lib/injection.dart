import 'package:cloud_firestore/cloud_firestore.dart';

import 'data/product/product_remote_data_source_impl.dart';
import 'data/product/product_remote_data_source.dart';
import 'data/product/product_repository_impl.dart';
import 'domain/product/repositories/product_repository.dart';
import 'domain/product/usecases/product_usecases.dart';

// Simple dependency injection container
class ServiceLocator {
  static final ServiceLocator _instance = ServiceLocator._internal();
  factory ServiceLocator() => _instance;
  ServiceLocator._internal();

  late final FirebaseFirestore _firestore;
  late final ProductRemoteDataSource _remoteDataSource;
  late final ProductRepository _repository;
  late final GetProducts _getProducts;
  late final GetProductById _getProductById;
  late final AddProduct _addProduct;
  late final UpdateProduct _updateProduct;
  late final DeleteProduct _deleteProduct;
  late final SetReorderThreshold _setReorderThreshold;

  void init() {
    // Firebase
    _firestore = FirebaseFirestore.instance;

    // Data sources
    _remoteDataSource = ProductRemoteDataSourceImpl(firestore: _firestore);

    // Repositories
    _repository = ProductRepositoryImpl(_remoteDataSource);

    // Use cases
    _getProducts = GetProducts(_repository);
    _getProductById = GetProductById(_repository);
    _addProduct = AddProduct(_repository);
    _updateProduct = UpdateProduct(_repository);
    _deleteProduct = DeleteProduct(_repository);
    _setReorderThreshold = SetReorderThreshold(_repository);
  }

  // Getters for accessing services
  FirebaseFirestore get firestore => _firestore;
  ProductRemoteDataSource get remoteDataSource => _remoteDataSource;
  ProductRepository get repository => _repository;
  GetProducts get getProducts => _getProducts;
  GetProductById get getProductById => _getProductById;
  AddProduct get addProduct => _addProduct;
  UpdateProduct get updateProduct => _updateProduct;
  DeleteProduct get deleteProduct => _deleteProduct;
  SetReorderThreshold get setReorderThreshold => _setReorderThreshold;
}

// Global instance
final sl = ServiceLocator();
