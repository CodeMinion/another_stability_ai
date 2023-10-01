
# Another Stability AI

The another_stability_ai package is a Flutter package for the Stability AI APIs. It exposes the APIs via the StabilityAiClient.

## Features

The following table includes details about the level at which all the APIs are supported in this package.

| API        | Support Percentage |
|------------|--------------------|
| User       | 100%               |
| Engines    | 100%               |
| Generation | 100%               |

## Getting started

This package implements the Stability AI APIs defined in this document https://platform.stability.ai/docs/api-reference

For information about the parameters and results refer to their reference docs.

## Usage

To use this package you'll first need to initialize the client using your public API keys. Once the client is initialized all the supported API calls are available through it.

```dart  
String apiKey = "<Stability AI API KEY>";  
final StabilityAiClient client = StabilityAiClient(apiKey: apiKey);

// Read account details
Account userAccount = await client.getAccount();

// Read available engines list
List<Engine> engines = await client.getEngines();

// Define the prompt for generating an image
TextPrompt prompt = TextPrompt(text: "Generate an image of a wizard like in a fantasy show.");
TextToImageRequestParams requestParams = TextToImageRequestParams(stylePreset: StylePreset.anime, textPrompts: [prompt]);

// Request the image in Base64 Format
List<ImageResponse> images = await client.generateImageBase64FromText(engineId: "stable-diffusion-v1-5", params: requestParams);

// Request the image as a PNG bytes
Uint8List pngBytes = await client.generateImagePngFromText(engineId: "stable-diffusion-v1-5", params: requestParams);

// Request image generation with an image as a source.
TextPrompt prompt = TextPrompt(text: "I want the background to include a dragon");
ImageToImageRequestParams requestParams = ImageToImageRequestParams.imageStrength(stylePreset: StylePreset.anime, textPrompts: [prompt]);
List<ImageResponse> images = await client.generateImageBase64FromImage(engineId: "stable-diffusion-v1-5", initImage: File("result.png").readAsBytesSync() , params: requestParams);
    
// Upscale image request.
ImageUpScaleRequestParams requestParams = ImageUpScaleRequestParams.realESRGANUpscale(scale: ScaleUpscaleParam(dimension: ScaleDimension.width, value: 1024));
List<ImageResponse> images = await client.upScaleImageBase64(engineId: "esrgan-v1-x2plus", image: File("result.png").readAsBytesSync() , params: requestParams);

// Image masking request.
ImageMaskingRequestParam requestParams = ImageMaskingRequestParam.maskImageWhite(textPrompts: [prompt], maskImage: File("mask.png").readAsBytesSync(), stylePreset: StylePreset.anime);
List<ImageResponse> images = await client.generateImageBase64WithMask(engineId: "stable-inpainting-512-v2-0", initImage: File("result.png").readAsBytesSync() , params: requestParams);
     
```  

  