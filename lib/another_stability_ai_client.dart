import 'package:another_stability_ai/engine/engine_dto.dart';
import 'package:another_stability_ai/engine/engine_service.dart';
import 'package:another_stability_ai/generation/generation_dto.dart';
import 'package:another_stability_ai/generation/generation_service.dart';
import 'package:another_stability_ai/user/user_dto.dart';
import 'package:another_stability_ai/user/user_service.dart';
import 'package:flutter/foundation.dart';

class StabilityAiClient {
  final String _baseUrl;
  final String _apiKey;
  final bool _secured = true;

  late UserService _userService;
  late EngineService _engineService;
  late GenerationService _generationService;

  StabilityAiClient(
      {required String apiKey, String baseUrl = "api.stability.ai"})
      : _baseUrl = baseUrl,
        _apiKey = apiKey {
    _userService = UserService(baseUrl: _baseUrl, secure: _secured);
    _engineService = EngineService(baseUrl: _baseUrl, secure: _secured);
    _generationService = GenerationService(baseUrl: _baseUrl, secure: _secured);
  }

  ///
  /// Get information about the account associated with the provided API key
  ///
  Future<Account> getAccount({
    String? apiKey,
  }) async {
    return _userService.getAccount(apiKey: apiKey ?? _apiKey);
  }

  ///
  /// Get the credit balance of the account/organization associated with the API key
  ///
  Future<Balance> getBalance({
    String? apiKey,
  }) async {
    return _userService.getBalance(apiKey: apiKey ?? _apiKey);
  }

  ///
  /// Gets the list of engines available.
  ///
  Future<List<Engine>> getEngines({
    String? apiKey,
    String? organization,
    String? clientId,
    String? clientVersion,
  }) async {
    return _engineService.getEngines(
        apiKey: apiKey ?? _apiKey,
        organization: organization,
        clientId: clientId,
        clientVersion: clientVersion);
  }

  ///
  /// Generates an image from the input prompts and returns it
  /// as a base64 string.
  ///
  Future<List<ImageResponse>> generateImageBase64FromText({
    required String engineId,
    required TextToImageRequestParams params,
    String? apiKey,
    String? organization,
    String? clientId,
    String? clientVersion,
  }) async {
    return _generationService.generateImageBase64FromText(
        apiKey: apiKey ?? _apiKey,
        engineId: engineId,
        params: params,
        organization: organization,
        clientId: clientId,
        clientVersion: clientVersion);
  }

  ///
  /// Generates an image from the specified prompt and returns
  /// the set of bytes in PNG format.
  ///
  Future<Uint8List> generateImagePngFromText({
    required String engineId,
    required TextToImageRequestParams params,
    String? apiKey,
    String? organization,
    String? clientId,
    String? clientVersion,
  }) async {
    return _generationService.generateImagePngFromText(
        apiKey: apiKey ?? _apiKey,
        engineId: engineId,
        params: params,
        organization: organization,
        clientId: clientId,
        clientVersion: clientVersion);
  }

  ///
  /// Modify an image based on a text prompt
  ///
  Future<List<ImageResponse>> generateImageBase64FromImage({
    String? apiKey,
    required String engineId,
    required ImageToImageRequestParams params,
    required Uint8List initImage,
    String? organization,
    String? clientId,
    String? clientVersion,
  }) async {
    return _generationService.generateImageBase64FromImage(
        apiKey: apiKey ?? _apiKey,
        engineId: engineId,
        params: params,
        initImage: initImage,
        organization: organization,
        clientId: clientId,
        clientVersion: clientVersion);
  }

  ///
  /// Modify an image based on a text prompt and returns the image PNG bytes.
  ///
  Future<Uint8List> generateImagePngFromImage({
    required String engineId,
    required ImageToImageRequestParams params,
    required Uint8List initImage,
    String? apiKey,
    String? organization,
    String? clientId,
    String? clientVersion,
  }) async {
    return _generationService.generateImagePngFromImage(
        apiKey: apiKey ?? _apiKey,
        engineId: engineId,
        params: params,
        initImage: initImage,
        organization: organization,
        clientId: clientId,
        clientVersion: clientVersion);
  }

  ///
  /// Create a higher resolution version of an input image.
  ///
  /// This operation outputs an image with a maximum pixel count of 4,194,304.
  /// This is equivalent to dimensions such as 2048x2048 and 4096x1024.
  ///
  Future<List<ImageResponse>> upScaleImageBase64({
    required String engineId,
    required ImageUpScaleRequestParams params,
    required Uint8List image,
    String? apiKey,
    String? organization,
    String? clientId,
    String? clientVersion,
  }) async {
    return _generationService.upScaleImageBase64(
        apiKey: apiKey ?? _apiKey,
        engineId: engineId,
        params: params,
        image: image,
        organization: organization,
        clientId: clientId,
        clientVersion: clientVersion);
  }

  ///
  /// Create a higher resolution version of an input image.
  ///
  /// This operation outputs an image with a maximum pixel count of 4,194,304.
  /// This is equivalent to dimensions such as 2048x2048 and 4096x1024.
  /// Returns the image bytes.
  ///
  Future<Uint8List> upScaleImagePng({
    required String engineId,
    required ImageUpScaleRequestParams params,
    required Uint8List image,
    String? apiKey,
    String? organization,
    String? clientId,
    String? clientVersion,
  }) async {
    return _generationService.upScaleImagePng(
        apiKey: apiKey ?? _apiKey,
        engineId: engineId,
        params: params,
        image: image,
        organization: organization,
        clientId: clientId,
        clientVersion: clientVersion);
  }

  ///
  /// Selectively modify portions of an image using a mask
  ///
  Future<List<ImageResponse>> generateImageBase64WithMask({
    String? apiKey,
    required String engineId,
    required ImageMaskingRequestParam params,
    required Uint8List initImage,
    String? organization,
    String? clientId,
    String? clientVersion,
  }) async {
    return _generationService.generateImageBase64WithMask(
        apiKey: apiKey ?? _apiKey,
        engineId: engineId,
        params: params,
        initImage: initImage,
        organization: organization,
        clientId: clientId,
        clientVersion: clientVersion);
  }

  ///
  /// Selectively modify portions of an image using a mask
  /// Returns the bytes of the image PNG
  Future<Uint8List> generateImagePngWithMask({
    required String engineId,
    required ImageMaskingRequestParam params,
    required Uint8List initImage,
    String? apiKey,
    String? organization,
    String? clientId,
    String? clientVersion,
  }) async {
    return _generationService.generateImagePngWithMask(
        apiKey: apiKey ?? _apiKey,
        engineId: engineId,
        params: params,
        initImage: initImage,
        organization: organization,
        clientId: clientId,
        clientVersion: clientVersion);
  }


}
