import 'dart:convert';
import 'package:dio/dio.dart';
import '../../core/api.dart';
import '../models/user/user_model.dart';

class UserRepository {
  final _api = Api();

  Future<UserModel> createAccount({
    required String email,
    required String password,
    required String fullName,
    required String phoneNumber,
    required String address,
    required String city,
  }) async {
    try {
      Response response = await _api.sendRequest.post("/user/createAccount",
          data: jsonEncode({
            "email": email,
            "password": password,
            "fullName": fullName,
            "phoneNumber": phoneNumber,
            "address": address,
            "city": city,
          }));

      ApiResponse apiResponse = ApiResponse.fromResponse(response);

      if (!apiResponse.success) {
        throw apiResponse.message.toString();
      }

      return UserModel.fromJson(apiResponse.data);
    } catch (ex) {
      rethrow;
    }
  }

  Future<List<UserModel>> fetchAllUsers() async {
    try {
      Response response = await _api.sendRequest.get("/user");

      ApiResponse apiResponse = ApiResponse.fromResponse(response);

      if (!apiResponse.success) {
        throw apiResponse.message.toString();
      }

      return (apiResponse.data as List<dynamic>)
          .map((json) => UserModel.fromJson(json))
          .toList();
    } catch (ex) {
      rethrow;
    }
  }

  Future<UserModel> signIn(
      {required String email, required String password}) async {
    try {
      Response response = await _api.sendRequest.post("/user/signIn",
          data: jsonEncode({"email": email, "password": password}));

      ApiResponse apiResponse = ApiResponse.fromResponse(response);

      if (!apiResponse.success) {
        throw apiResponse.message.toString();
      }

      return UserModel.fromJson(apiResponse.data);
    } catch (ex) {
      rethrow;
    }
  }

  Future<UserModel> updateUser(UserModel userModel) async {
    try {
      Response response = await _api.sendRequest
          .put("/user/${userModel.sId}", data: jsonEncode(userModel.toJson()));

      ApiResponse apiResponse = ApiResponse.fromResponse(response);

      if (!apiResponse.success) {
        throw apiResponse.message.toString();
      }

      return UserModel.fromJson(apiResponse.data);
    } catch (ex) {
      rethrow;
    }
  }

  Future<UserModel> changePassword(UserModel userModel) async {
    try {
      Response response = await _api.sendRequest.put(
          "/user/${userModel.sId}/changePassword",
          data: jsonEncode(userModel.toJson()));

      ApiResponse apiResponse = ApiResponse.fromResponse(response);

      if (!apiResponse.success) {
        throw apiResponse.message.toString();
      }

      return UserModel.fromJson(apiResponse.data);
    } catch (ex) {
      rethrow;
    }
  }

  Future<void> removeUser(String userId) async {
    try {
      // Send DELETE request to remove user
      Response response = await _api.sendRequest.delete("/user/$userId");

      // Check if the response is successful
      if (response.statusCode == 200) {
        // If successful, no need to return any data
        return;
      } else {
        // If not successful, handle the error
        throw "Failed to remove user: ${response.statusCode}";
      }
    } catch (ex) {
      // Rethrow the exception to be caught at a higher level
      rethrow;
    }
  }
}
