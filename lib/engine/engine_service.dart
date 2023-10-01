import 'dart:convert';

import 'package:another_stability_ai/engine/engine_dto.dart';
import 'package:another_stability_ai/error_models.dart';
import 'package:http/http.dart' as http;

class EngineService {
  final String baseUrl;
  final bool secure;

  EngineService({required this.baseUrl, required this.secure});

  ///
  /// Gets the list of engines available.
  ///
  Future<List<Engine>> getEngines({
    required String apiKey,
    String? organization,
    String? clientId,
    String? clientVersion,
  }) async {
    Map<String, String> headers = {
      "Authorization": apiKey,
      'Content-Type': 'application/json',
      "Access-Control-Allow-Origin": "*", // Required for CORS support to work
    };

    if (organization != null) {
      headers.putIfAbsent("Organization", () => organization);
    }

    if (clientId != null) {
      headers.putIfAbsent("Stability-Client-ID", () => clientId);
    }

    if (clientVersion != null) {
      headers.putIfAbsent("Stability-Client-Version", () => clientVersion);
    }

    Uri endpoint;
    if (secure) {
      endpoint = Uri.https(baseUrl, "/v1/engines/list");
    } else {
      endpoint = Uri.http(baseUrl, "/v1/engines/list");
    }

    var response = await http.get(endpoint, headers: headers);

    if (response.statusCode == 200 || response.statusCode == 201) {
      return (jsonDecode(const Utf8Decoder().convert(response.bodyBytes))
              as List)
          .map<Engine>((e) => Engine.fromJson(e))
          .toList();
    } else {
      var error = ServerError.fromJson(jsonDecode(response.body));
      throw EngineException(
          statusCode: response.statusCode, message: error.message);
    }
  }
}

///
/// Exception related to the Engine Service
///
class EngineException implements Exception {
  final String? message;
  final int statusCode;

  EngineException({required this.statusCode, this.message});

  @override
  String toString() {
    return "EngineException: $statusCode - $message";
  }
}
