import 'dart:convert';

import 'package:dio/dio.dart';
import '../../core/api.dart';
import '../models/product/product_model.dart';

class ProductRepository {
  final _api = Api();

  Future<ProductModel> addProduct(
      {required String title,
      required String category,
      required String description,
      required String price}) async {
    try {
      Response response = await _api.sendRequest.post(
        "/product",
        data: jsonEncode(
          {
            "title": title,
            "category": category,
            "description": description,
            "price": price
          },
        ),
      );

      ApiResponse apiResponse = ApiResponse.fromResponse(response);

      // Handling unsuccessful response
      if (!apiResponse.success) {
        throw apiResponse.message.toString();
      }

      return ProductModel.fromJson(apiResponse.data);
    } catch (ex) {
      rethrow;
    }
  }

  Future<List<ProductModel>> fetchAllProducts() async {
    try {
      Response response = await _api.sendRequest.get("/product");

      ApiResponse apiResponse = ApiResponse.fromResponse(response);

      if (!apiResponse.success) {
        throw apiResponse.message.toString();
      }

      return (apiResponse.data as List<dynamic>)
          .map((json) => ProductModel.fromJson(json))
          .toList();
    } catch (ex) {
      rethrow;
    }
  }

  Future<List<ProductModel>> fetchProductsByCategory(String categoryId) async {
    try {
      Response response =
          await _api.sendRequest.get("/product/category/$categoryId");

      ApiResponse apiResponse = ApiResponse.fromResponse(response);

      if (!apiResponse.success) {
        throw apiResponse.message.toString();
      }

      return (apiResponse.data as List<dynamic>)
          .map((json) => ProductModel.fromJson(json))
          .toList();
    } catch (ex) {
      rethrow;
    }
  }

  Future<List<ProductModel>> fetchProductsById(String userId) async {
    try {
      Response response =
          await _api.sendRequest.get("/product/category/$userId");

      ApiResponse apiResponse = ApiResponse.fromResponse(response);

      if (!apiResponse.success) {
        throw apiResponse.message.toString();
      }

      return (apiResponse.data as List<dynamic>)
          .map((json) => ProductModel.fromJson(json))
          .toList();
    } catch (ex) {
      rethrow;
    }
  }

  Future<List<ProductModel>> deleteProduct(String productId) async {
    try {
      Map<String, dynamic> data = {"product": productId};

      Response response =
          await _api.sendRequest.delete("/product", data: jsonEncode(data));

      ApiResponse apiResponse = ApiResponse.fromResponse(response);

      if (!apiResponse.success) {
        throw apiResponse.message.toString();
      }

      return (apiResponse.data as List<dynamic>)
          .map((json) => ProductModel.fromJson(json))
          .toList();
    } catch (ex) {
      rethrow;
    }
  }
}
