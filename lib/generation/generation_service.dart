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

    var response = await http.post(endpoint,
        headers: headers, body: jsonEncode(params.toJson()));

    if (response.statusCode == 200 || response.statusCode == 201) {
      return ImageResponseListDto.fromJson(
              jsonDecode(const Utf8Decoder().convert(response.bodyBytes)))
          .artifacts;
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

    var response = await http.post(endpoint,
        headers: headers, body: jsonEncode(params.toJson()));

    if (response.statusCode == 200 || response.statusCode == 201) {
      return response.bodyBytes;
    } else {
      var error = ServerError.fromJson(jsonDecode(response.body));
      throw GenerationException(
          statusCode: response.statusCode, message: error.message);
    }
  }

  ///
  /// Modify an image based on a text prompt
  ///
  Future<List<ImageResponse>> generateImageBase64FromImage({
    required String apiKey,
    required String engineId,
    required ImageToImageRequestParams params,
    required Uint8List initImage,
    String? organization,
    String? clientId,
    String? clientVersion,
  }) async {
    Map<String, String> headers = {
      "Authorization": apiKey,
      "Accept": "application/json",
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
      endpoint = Uri.https(baseUrl, "/v1/generation/$engineId/image-to-image");
    } else {
      endpoint = Uri.http(baseUrl, "/v1/generation/$engineId/image-to-image");
    }

    var request = http.MultipartRequest('POST', endpoint)
      ..headers.addAll(headers)
      ..fields.addAll(
          params.toJson().map((key, value) => MapEntry(key, value.toString())))
      ..fields.remove("text_prompts")
      ..files.add(http.MultipartFile.fromBytes("init_image", initImage));

    List<TextPrompt> prompts = params.textPrompts;
    int index = 0;
    for (var element in prompts) {
      request.fields['text_prompts[$index][text]'] = element.text;
      request.fields['text_prompts[$index][weight]'] =
          element.weight.toString();
      index++;
    }
    var response = await request.send();

    if (response.statusCode == 200 || response.statusCode == 201) {
      return ImageResponseListDto.fromJson(jsonDecode(
              const Utf8Decoder().convert(await response.stream.toBytes())))
          .artifacts;
    } else {
      var error = ServerError.fromJson(jsonDecode(
          const Utf8Decoder().convert(await response.stream.toBytes())));
      throw GenerationException(
          statusCode: response.statusCode, message: error.message);
    }
  }

  ///
  /// Modify an image based on a text prompt and returns the image PNG bytes.
  ///
  Future<Uint8List> generateImagePngFromImage({
    required String apiKey,
    required String engineId,
    required ImageToImageRequestParams params,
    required Uint8List initImage,
    String? organization,
    String? clientId,
    String? clientVersion,
  }) async {
    Map<String, String> headers = {
      "Authorization": apiKey,
      "Accept": "image/png",
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
      endpoint = Uri.https(baseUrl, "/v1/generation/$engineId/image-to-image");
    } else {
      endpoint = Uri.http(baseUrl, "/v1/generation/$engineId/image-to-image");
    }

    var request = http.MultipartRequest('POST', endpoint)
      ..headers.addAll(headers)
      ..fields.addAll(
          params.toJson().map((key, value) => MapEntry(key, value.toString())))
      ..fields.remove("text_prompts")
      ..files.add(http.MultipartFile.fromBytes("init_image", initImage));

    List<TextPrompt> prompts = params.textPrompts;
    int index = 0;
    for (var element in prompts) {
      request.fields['text_prompts[$index][text]'] = element.text;
      request.fields['text_prompts[$index][weight]'] =
          element.weight.toString();
      index++;
    }
    var response = await request.send();

    if (response.statusCode == 200 || response.statusCode == 201) {
      return await response.stream.toBytes();
    } else {
      var error = ServerError.fromJson(jsonDecode(
          const Utf8Decoder().convert(await response.stream.toBytes())));
      throw GenerationException(
          statusCode: response.statusCode, message: error.message);
    }
  }

  ///
  /// Create a higher resolution version of an input image.
  ///
  /// This operation outputs an image with a maximum pixel count of 4,194,304.
  /// This is equivalent to dimensions such as 2048x2048 and 4096x1024.
  ///
  Future<List<ImageResponse>> upScaleImageBase64({
    required String apiKey,
    required String engineId,
    required ImageUpScaleRequestParams params,
    required Uint8List image,
    String? organization,
    String? clientId,
    String? clientVersion,
  }) async {
    Map<String, String> headers = {
      "Authorization": apiKey,
      "Accept": "application/json",
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
      endpoint =
          Uri.https(baseUrl, "/v1/generation/$engineId/image-to-image/upscale");
    } else {
      endpoint =
          Uri.http(baseUrl, "/v1/generation/$engineId/image-to-image/upscale");
    }

    var request = http.MultipartRequest('POST', endpoint)
      ..headers.addAll(headers)
      ..fields.addAll(
          params.toJson().map((key, value) => MapEntry(key, value.toString())))
      ..fields.remove("text_prompts")
      ..files.add(http.MultipartFile.fromBytes("image", image));

    List<TextPrompt>? prompts = params.textPrompts;
    if (prompts != null) {
      int index = 0;
      for (var element in prompts) {
        request.fields['text_prompts[$index][text]'] = element.text;
        request.fields['text_prompts[$index][weight]'] =
            element.weight.toString();
        index++;
      }
    }

    var response = await request.send();

    if (response.statusCode == 200 || response.statusCode == 201) {
      return ImageResponseListDto.fromJson(jsonDecode(
              const Utf8Decoder().convert(await response.stream.toBytes())))
          .artifacts;
    } else {
      var error = ServerError.fromJson(jsonDecode(
          const Utf8Decoder().convert(await response.stream.toBytes())));
      throw GenerationException(
          statusCode: response.statusCode, message: error.message);
    }
  }

  ///
  /// Create a higher resolution version of an input image.
  ///
  /// This operation outputs an image with a maximum pixel count of 4,194,304.
  /// This is equivalent to dimensions such as 2048x2048 and 4096x1024.
  /// Returns the image bytes.
  ///
  Future<Uint8List> upScaleImagePng({
    required String apiKey,
    required String engineId,
    required ImageUpScaleRequestParams params,
    required Uint8List image,
    String? organization,
    String? clientId,
    String? clientVersion,
  }) async {
    Map<String, String> headers = {
      "Authorization": apiKey,
      "Accept": "image/png",
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
      endpoint =
          Uri.https(baseUrl, "/v1/generation/$engineId/image-to-image/upscale");
    } else {
      endpoint =
          Uri.http(baseUrl, "/v1/generation/$engineId/image-to-image/upscale");
    }

    var request = http.MultipartRequest('POST', endpoint)
      ..headers.addAll(headers)
      ..fields.addAll(
          params.toJson().map((key, value) => MapEntry(key, value.toString())))
      ..fields.remove("text_prompts")
      ..files.add(http.MultipartFile.fromBytes("image", image));

    List<TextPrompt>? prompts = params.textPrompts;
    if (prompts != null) {
      int index = 0;
      for (var element in prompts) {
        request.fields['text_prompts[$index][text]'] = element.text;
        request.fields['text_prompts[$index][weight]'] =
            element.weight.toString();
        index++;
      }
    }

    var response = await request.send();

    if (response.statusCode == 200 || response.statusCode == 201) {
      return await response.stream.toBytes();
    } else {
      var error = ServerError.fromJson(jsonDecode(
          const Utf8Decoder().convert(await response.stream.toBytes())));
      throw GenerationException(
          statusCode: response.statusCode, message: error.message);
    }
  }

  ///
  /// Selectively modify portions of an image using a mask
  ///
  Future<List<ImageResponse>> generateImageBase64WithMask({
    required String apiKey,
    required String engineId,
    required ImageMaskingRequestParam params,
    required Uint8List initImage,
    String? organization,
    String? clientId,
    String? clientVersion,
  }) async {
    Map<String, String> headers = {
      "Authorization": apiKey,
      "Accept": "application/json",
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
      endpoint =
          Uri.https(baseUrl, "/v1/generation/$engineId/image-to-image/masking");
    } else {
      endpoint =
          Uri.http(baseUrl, "/v1/generation/$engineId/image-to-image/masking");
    }

    var request = http.MultipartRequest('POST', endpoint)
      ..headers.addAll(headers)
      ..fields.addAll(
          params.toJson().map((key, value) => MapEntry(key, value.toString())))
      ..fields.remove("text_prompts")
      ..files.add(http.MultipartFile.fromBytes("init_image", initImage));

    if(params.maskImage != null) {
      request.files.add(http.MultipartFile.fromBytes("mask_image", params.maskImage!));
    }

    List<TextPrompt> prompts = params.textPrompts;
    int index = 0;
    for (var element in prompts) {
      request.fields['text_prompts[$index][text]'] = element.text;
      request.fields['text_prompts[$index][weight]'] =
          element.weight.toString();
      index++;
    }

    var response = await request.send();

    if (response.statusCode == 200 || response.statusCode == 201) {
      return ImageResponseListDto.fromJson(jsonDecode(
              const Utf8Decoder().convert(await response.stream.toBytes())))
          .artifacts;
    } else {
      var error = ServerError.fromJson(jsonDecode(
          const Utf8Decoder().convert(await response.stream.toBytes())));
      throw GenerationException(
          statusCode: response.statusCode, message: error.message);
    }
  }

  ///
  /// Selectively modify portions of an image using a mask
  /// Returns the bytes of the image PNG
  Future<Uint8List> generateImagePngWithMask({
    required String apiKey,
    required String engineId,
    required ImageMaskingRequestParam params,
    required Uint8List initImage,
    String? organization,
    String? clientId,
    String? clientVersion,
  }) async {
    Map<String, String> headers = {
      "Authorization": apiKey,
      "Accept": "image/png",
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
      endpoint =
          Uri.https(baseUrl, "/v1/generation/$engineId/image-to-image/masking");
    } else {
      endpoint =
          Uri.http(baseUrl, "/v1/generation/$engineId/image-to-image/masking");
    }

    var request = http.MultipartRequest('POST', endpoint)
      ..headers.addAll(headers)
      ..fields.addAll(
          params.toJson().map((key, value) => MapEntry(key, value.toString())))
      ..fields.remove("text_prompts")
      ..files.add(http.MultipartFile.fromBytes("init_image", initImage));

    if(params.maskImage != null) {
      request.files.add(http.MultipartFile.fromBytes("mask_image", params.maskImage!));
    }

    List<TextPrompt> prompts = params.textPrompts;
    int index = 0;
    for (var element in prompts) {
      request.fields['text_prompts[$index][text]'] = element.text;
      request.fields['text_prompts[$index][weight]'] =
          element.weight.toString();
      index++;
    }

    var response = await request.send();

    if (response.statusCode == 200 || response.statusCode == 201) {
      return await response.stream.toBytes();
    } else {
      var error = ServerError.fromJson(jsonDecode(
          const Utf8Decoder().convert(await response.stream.toBytes())));
      throw GenerationException(
          statusCode: response.statusCode, message: error.message);
    }
  }
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
