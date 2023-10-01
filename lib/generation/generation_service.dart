import 'dart:convert';
import 'dart:typed_data';

import 'package:another_stability_ai/error_models.dart';
import 'package:another_stability_ai/generation/generation_dto.dart';
import 'package:http/http.dart' as http;

class GenerationService {
  final String baseUrl;
  final bool secure;

  GenerationService({required this.baseUrl, required this.secure});

  ///
  /// Generates an image from the input prompts and returns it
  /// as a base64 string.
  ///
  Future<List<ImageResponse>> generateImageBase64FromText({
    required String apiKey,
    required String engineId,
    required TextToImageRequestParams params,
    String? organization,
    String? clientId,
    String? clientVersion,
  }) async {
    Map<String, String> headers = {
      "Accept": "application/json",
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
      endpoint = Uri.https(baseUrl, "/v1/generation/$engineId/text-to-image");
    } else {
      endpoint = Uri.http(baseUrl, "/v1/generation/$engineId/text-to-image");
    }

    var response = await http.post(endpoint, headers: headers, body: jsonEncode(params.toJson()));

    if (response.statusCode == 200 || response.statusCode == 201) {
      return ImageResponseListDto.fromJson(jsonDecode(const Utf8Decoder().convert(response.bodyBytes))).artifacts;
    } else {
      var error = ServerError.fromJson(jsonDecode(response.body));
      throw GenerationException(
          statusCode: response.statusCode, message: error.message);
    }
  }

  ///
  /// Generates an image from the specified prompt and returns
  /// the set of bytes in PNG format.
  ///
  Future<Uint8List> generateImagePngFromText({
    required String apiKey,
    required String engineId,
    required TextToImageRequestParams params,
    String? organization,
    String? clientId,
    String? clientVersion,
  }) async {
    Map<String, String> headers = {
      "Accept": "image/png",
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
      endpoint = Uri.https(baseUrl, "/v1/generation/$engineId/text-to-image");
    } else {
      endpoint = Uri.http(baseUrl, "/v1/generation/$engineId/text-to-image");
    }

    var response = await http.post(endpoint, headers: headers, body: jsonEncode(params.toJson()));

    if (response.statusCode == 200 || response.statusCode == 201) {
      return response.bodyBytes;
    } else {
      var error = ServerError.fromJson(jsonDecode(response.body));
      throw GenerationException(
          statusCode: response.statusCode, message: error.message);
    }
  }

  // TODO image-to-image
  // TODO image-to-image/upscale
  // TODO image-to-image/masking

}

///
/// Exception related to the Generation Service
///
class GenerationException implements Exception {
  final String? message;
  final int statusCode;

  GenerationException({required this.statusCode, this.message});

  @override
  String toString() {
    return "GenerationException: $statusCode - $message";
  }
}