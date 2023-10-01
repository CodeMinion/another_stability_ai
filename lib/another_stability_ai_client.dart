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

// TODO image-to-image
// TODO image-to-image/upscale
// TODO image-to-image/masking

}
