import 'dart:convert';

import 'package:another_stability_ai/error_models.dart';
import 'package:another_stability_ai/user/user_dto.dart';
import 'package:http/http.dart' as http;


class UserService {

  final String baseUrl;
  final bool secure;

  UserService({required this.baseUrl, required this.secure});

  ///
  /// Get information about the account associated with the provided API key
  ///
  Future<Account> getAccount({
    required String apiKey,
  }) async {

    Map<String, String> headers = {
      "Authorization": apiKey,
      'Content-Type': 'application/json',
      "Access-Control-Allow-Origin": "*", // Required for CORS support to work
    };


    Uri endpoint;
    if(secure) {
      endpoint = Uri.https(
          baseUrl, "/v1/user/account");
    }
    else {
      endpoint = Uri.http(
          baseUrl, "/v1/user/account");
    }

    var response = await
    http.get(endpoint, headers: headers);

    if (response.statusCode == 200 || response.statusCode == 201) {
      return Account.fromJson(jsonDecode(const Utf8Decoder().convert(response.bodyBytes)));
    }
    else {
      var error = ServerError.fromJson(jsonDecode(response.body));
      throw UserException(statusCode: response.statusCode, message: error.message);
    }
  }


  ///
  /// Get the credit balance of the account/organization associated with the API key
  ///
  Future<Balance> getBalance({
    required String apiKey,
  }) async {

    Map<String, String> headers = {
      "Authorization": apiKey,
      'Content-Type': 'application/json',
      "Access-Control-Allow-Origin": "*", // Required for CORS support to work
    };


    Uri endpoint;
    if(secure) {
      endpoint = Uri.https(
          baseUrl, "/v1/user/balance");
    }
    else {
      endpoint = Uri.http(
          baseUrl, "/v1/user/balance");
    }

    var response = await
    http.get(endpoint, headers: headers);

    if (response.statusCode == 200 || response.statusCode == 201) {
      return Balance.fromJson(jsonDecode(const Utf8Decoder().convert(response.bodyBytes)));
    }
    else {
      var error = ServerError.fromJson(jsonDecode(response.body));
      throw UserException(statusCode: response.statusCode, message: error.message);
    }
  }


}

///
/// Exception related to the User Service
///
class UserException implements Exception {
  final String? message;
  final int statusCode;

  UserException({required this.statusCode, this.message});

  @override
  String toString() {
    return "UserException: $statusCode - $message";
  }
}