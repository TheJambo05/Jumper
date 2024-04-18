import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import '../../core/api.dart';
import '../models/product/product_model.dart';

class ProductRepository {
  final Api _api = Api();

  /// Adds a product with the option to upload an image.
  Future<ProductModel> addProduct({
    required String title,
    required String category,
    required String description,
    required String price,
    File? images,
  }) async {
    try {
      FormData formData = FormData.fromMap({
        "title": title,
        "category": category,
        "description": description,
        "price": price,
      });

      if (images != null) {
        formData.files.add(MapEntry(
          "images",
          await MultipartFile.fromFile(
            images.path,
            filename: images.path.split('/').last,
          ),
        ));
      }

      Response response =
          await _api.sendRequest.post("/product", data: formData);
      var apiResponse = ApiResponse.fromResponse(response);

      if (!apiResponse.success) {
        throw Exception(apiResponse.message.toString());
      }

      return ProductModel.fromJson(apiResponse.data);
    } catch (e) {
      rethrow;
    }
  }

  /// Fetches all products.
  Future<List<ProductModel>> fetchAllProducts() async {
    try {
      Response response = await _api.sendRequest.get("/product");
      var apiResponse = ApiResponse.fromResponse(response);

      if (!apiResponse.success) {
        throw Exception(apiResponse.message.toString());
      }

      return (apiResponse.data as List<dynamic>)
          .map((json) => ProductModel.fromJson(json))
          .toList();
    } catch (e) {
      rethrow;
    }
  }

  /// Fetches products by category ID.
  Future<List<ProductModel>> fetchProductsByCategory(String categoryId) async {
    try {
      Response response =
          await _api.sendRequest.get("/product/category/$categoryId");
      var apiResponse = ApiResponse.fromResponse(response);

      if (!apiResponse.success) {
        throw Exception(apiResponse.message.toString());
      }

      return (apiResponse.data as List<dynamic>)
          .map((json) => ProductModel.fromJson(json))
          .toList();
    } catch (e) {
      rethrow;
    }
  }

  /// Fetches products by user ID.
  Future<List<ProductModel>> fetchProductsByUserId(String userId) async {
    try {
      Response response = await _api.sendRequest.get("/product/user/$userId");
      var apiResponse = ApiResponse.fromResponse(response);

      if (!apiResponse.success) {
        throw Exception(apiResponse.message.toString());
      }

      return (apiResponse.data as List<dynamic>)
          .map((json) => ProductModel.fromJson(json))
          .toList();
    } catch (e) {
      rethrow;
    }
  }

  /// Deletes a product by ID and returns the list of remaining products.
  Future<List<ProductModel>> deleteProduct(String productId) async {
    try {
      Response response = await _api.sendRequest.delete("/product/$productId");
      var apiResponse = ApiResponse.fromResponse(response);

      if (!apiResponse.success) {
        throw Exception(apiResponse.message.toString());
      }

      return (apiResponse.data as List<dynamic>)
          .map((json) => ProductModel.fromJson(json))
          .toList();
    } catch (e) {
      rethrow;
    }
  }
}
