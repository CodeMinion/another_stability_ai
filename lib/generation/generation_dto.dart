import 'package:json_annotation/json_annotation.dart';

part 'generation_dto.g.dart';

@JsonSerializable(includeIfNull: false)
class TextToImageRequestParams {

  /// Height of the image in pixels. Must be in increments of 64 and pass the following validation:
  ///
  /// For 512 engines: 262,144 ≤ height * width ≤ 1,048,576
  /// For 768 engines: 589,824 ≤ height * width ≤ 1,048,576
  /// For SDXL Beta: can be as low as 128 and as high as 896 as long as width
  /// is not greater than 512. If width is greater than 512 then this can be at most 512.
  /// For SDXL v0.9: valid dimensions are 1024x1024, 1152x896, 1216x832,
  /// 1344x768, 1536x640, 640x1536, 768x1344, 832x1216, or 896x1152
  /// For SDXL v1.0: valid dimensions are the same as SDXL v0.9
  int height;

  /// Width of the image in pixels. Must be in increments of 64 and pass the following validation:
  ///
  /// For 512 engines: 262,144 ≤ height * width ≤ 1,048,576
  /// For 768 engines: 589,824 ≤ height * width ≤ 1,048,576
  /// For SDXL Beta: can be as low as 128 and as high as 896 as long as
  /// height is not greater than 512. If height is greater than 512 then
  /// this can be at most 512.
  /// For SDXL v0.9: valid dimensions are 1024x1024, 1152x896, 1216x832,
  /// 1344x768, 1536x640, 640x1536, 768x1344, 832x1216, or 896x1152
  /// For SDXL v1.0: valid dimensions are the same as SDXL v0.9
  int width;

  @JsonKey(name: "text_prompts")
  List<TextPrompt> textPrompts;

  /// How strictly the diffusion process adheres to the prompt text
  /// (higher values keep your image closer to your prompt)
  @JsonKey(name: "cfg_scale")
  int cfgScale;

  @JsonKey(name: "clip_guidance_preset")
  ClipGuidancePreset clipGuidancePreset;

  /// Which sampler to use for the diffusion process.
  /// If this value is omitted we'll automatically select an
  /// appropriate sampler for you.
  Sampler? sampler;

  /// Number of images to generate
  int samples;

  /// Random noise seed (omit this option or use 0 for a random seed)
  int seed;

  /// Number of diffusion steps to run
  int steps;

  /// Pass in a style preset to guide the image model towards a
  /// particular style. This list of style presets is subject to change.
  @JsonKey(name: "style_preset")
  StylePreset stylePreset;

  TextToImageRequestParams(
      {this.width = 512, this.height = 512, required this.textPrompts, this.cfgScale = 7, this.clipGuidancePreset = ClipGuidancePreset
          .none, this.sampler, this.samples = 1, this.seed = 0, this.steps = 50, required this.stylePreset });

  factory TextToImageRequestParams.fromJson(Map<String, dynamic> json) =>
      _$TextToImageRequestParamsFromJson(json);

  Map<String, dynamic> toJson() => _$TextToImageRequestParamsToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}


@JsonSerializable(includeIfNull: false)
class TextPrompt {
  String text;
  double weight;

  TextPrompt({required this.text, this.weight = 0.5});

  factory TextPrompt.fromJson(Map<String, dynamic> json) =>
      _$TextPromptFromJson(json);

  Map<String, dynamic> toJson() => _$TextPromptToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}

@JsonSerializable(includeIfNull: false)
class ImageToImageRequestParams {

  @JsonKey(name: "text_prompts")
  List<TextPrompt> textPrompts;

  /// Image used to initialize the diffusion process, in lieu of random noise.
  //@JsonKey(name: "init_image")
  //Uint8List initImage;

  /// Whether to use image_strength or step_schedule_* to
  /// control how much influence the init_image has on the result.
  @JsonKey(name: "init_image_mode")
  InitImageMode initImageMode;

  @JsonKey(name: "image_strength")
  double imageStrength = 0.35;

  ///
  /// number (StepScheduleStart) [ 0 .. 1 ]
  /// Skips a proportion of the start of the diffusion steps,
  /// allowing the init_image to influence the final generated
  /// image. Lower values will result in more influence from the
  /// init_image, while higher values will result in more influence
  /// from the diffusion steps. (e.g. a value of 0 would simply return
  /// you the init_image, where a value of 1 would return you a completely
  /// different image.)
  @JsonKey(name: "step_schedule_start")
  double stepScheduleStart;

  /// Skips a proportion of the end of the diffusion steps, allowing
  /// the init_image to influence the final generated image. Lower
  /// values will result in more influence from the init_image,
  /// while higher values will result in more influence from the
  /// diffusion steps.
  @JsonKey(name: "step_schedule_end")
  double stepScheduleEnd;

  /// How strictly the diffusion process adheres to
  /// the prompt text (higher values keep your image closer to your prompt)
  @JsonKey(name: "cfg_scale")
  int cfgScale;

  @JsonKey(name: "clip_guidance_preset")
  ClipGuidancePreset clipGuidancePreset;

  /// Which sampler to use for the diffusion process.
  /// If this value is omitted we'll automatically select an
  /// appropriate sampler for you.
  Sampler? sampler;

  /// Number of images to generate
  int samples;

  /// Random noise seed (omit this option or use 0 for a random seed)
  int seed;

  /// Number of diffusion steps to run
  int steps;

  /// Pass in a style preset to guide the image model towards a particular
  /// style. This list of style presets is subject to change.
  @JsonKey(name: "style_preset")
  StylePreset stylePreset;

  ImageToImageRequestParams(
      {this.initImageMode = InitImageMode.imageStrength, this.imageStrength = 0.35,
        this.stepScheduleStart = 0.65, this.stepScheduleEnd = 0,
        required this.textPrompts, this.cfgScale = 7, this.clipGuidancePreset = ClipGuidancePreset
          .none, this.sampler, this.samples = 1, this.seed = 0, this.steps = 50, required this.stylePreset });

  factory ImageToImageRequestParams.fromJson(Map<String, dynamic> json) =>
      _$ImageToImageRequestParamsFromJson(json);

  Map<String, dynamic> toJson() => _$ImageToImageRequestParamsToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}

@JsonSerializable(includeIfNull: false)
class RealESRGANUpscaleRequestParams {

  int width;
  int height;

  RealESRGANUpscaleRequestParams({required this.width, required this.height});

  factory RealESRGANUpscaleRequestParams.fromJson(Map<String, dynamic> json) =>
      _$RealESRGANUpscaleRequestParamsFromJson(json);

  Map<String, dynamic> toJson() => _$RealESRGANUpscaleRequestParamsToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}

@JsonSerializable(includeIfNull: false)
class LatentUpscalerUpscaleRequestParams {

  int width;
  int height;

  @JsonKey(name: "text_prompts")
  List<TextPrompt> textPrompts;

  /// Random noise seed (omit this option or use 0 for a random seed)
  int seed;

  /// Number of diffusion steps to run
  int steps;

  /// How strictly the diffusion process adheres to
  /// the prompt text (higher values keep your image closer to your prompt)
  @JsonKey(name: "cfg_scale")
  int cfgScale;


  LatentUpscalerUpscaleRequestParams({required this.width, required this.height, required this.textPrompts, this.seed = 0, this.steps = 50, this.cfgScale = 7});

  factory LatentUpscalerUpscaleRequestParams.fromJson(Map<String, dynamic> json) =>
      _$LatentUpscalerUpscaleRequestParamsFromJson(json);

  Map<String, dynamic> toJson() => _$LatentUpscalerUpscaleRequestParamsToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}

@JsonSerializable(includeIfNull: false)
class ImageToImageUpscaleRequestParams {

  @JsonKey(name: "text_prompts")
  List<TextPrompt> textPrompts;

  /// Image used to initialize the diffusion process, in lieu of random noise.
  //@JsonKey(name: "init_image")
  //Uint8List initImage;

  @JsonKey(name: "mask_source")
  MaskSource maskSource;

  //@JsonKey(name: "mask_image")
  //Uint8List maskImage;

  /// How strictly the diffusion process adheres to
  /// the prompt text (higher values keep your image closer to your prompt)
  @JsonKey(name: "cfg_scale")
  int cfgScale;

  @JsonKey(name: "clip_guidance_preset")
  ClipGuidancePreset clipGuidancePreset;

  /// Which sampler to use for the diffusion process.
  /// If this value is omitted we'll automatically select an
  /// appropriate sampler for you.
  Sampler? sampler;

  /// Number of images to generate
  int samples;

  /// Random noise seed (omit this option or use 0 for a random seed)
  int seed;

  /// Number of diffusion steps to run
  int steps;

  /// Pass in a style preset to guide the image model towards a particular
  /// style. This list of style presets is subject to change.
  @JsonKey(name: "style_preset")
  StylePreset stylePreset;

  ImageToImageUpscaleRequestParams(
      {this.maskSource = MaskSource.maskImageBlack,
        required this.textPrompts, this.cfgScale = 7, this.clipGuidancePreset = ClipGuidancePreset
          .none, this.sampler, this.samples = 1, this.seed = 0, this.steps = 50, required this.stylePreset });

  factory ImageToImageUpscaleRequestParams.fromJson(Map<String, dynamic> json) =>
      _$ImageToImageUpscaleRequestParamsFromJson(json);

  Map<String, dynamic> toJson() => _$ImageToImageUpscaleRequestParamsToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}

@JsonSerializable(includeIfNull: false)
class ImageResponse {

  String? base64;
  FinishReason finishReason;
  int seed;

  ImageResponse({required this.seed, required this.finishReason, this.base64});

  factory ImageResponse.fromJson(Map<String, dynamic> json) =>
      _$ImageResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ImageResponseToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}

@JsonSerializable(includeIfNull: false)
class ImageResponseListDto {
  List<ImageResponse> artifacts;

  ImageResponseListDto({required this.artifacts});

  factory ImageResponseListDto.fromJson(Map<String, dynamic> json) =>
      _$ImageResponseListDtoFromJson(json);

  Map<String, dynamic> toJson() => _$ImageResponseListDtoToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}

enum MaskSource {

  @JsonValue("MASK_IMAGE_WHITE")
  maskImageWhite,

  @JsonValue("MASK_IMAGE_BLACK")
  maskImageBlack,

  @JsonValue("INIT_IMAGE_ALPHA")
  initImageAlpha

}

enum InitImageMode{
  @JsonValue("IMAGE_STRENGTH")
  imageStrength,

  @JsonValue("STEP_SCHEDULE")
  stepSchedule,
}

enum StylePreset {
  @JsonValue("3d-model")
  model3d,
  @JsonValue("analog-film")
  analogFilm,
  @JsonValue("anime")
  anime,
  @JsonValue("cinematic")
  cinematic,
  @JsonValue("comic-book")
  comicBook,
  @JsonValue("digital-art")
  digitalArt,
  @JsonValue("enhance")
  enhance,
  @JsonValue("fantasy-art")
  fantasyArt,
  @JsonValue("isometric")
  isometric,
  @JsonValue("line-art")
  lineArt,
  @JsonValue("low-poly")
  lowPoly,
  @JsonValue("modeling-compound")
  modelingCompound,
  @JsonValue("neon-punk")
  neonPunk,
  origami,
  photographic,
  @JsonValue("pixel-art")
  pixelArt,
  @JsonValue("tile-texture")
  tileTexture,
}

enum Sampler {
  @JsonValue("DDIM")
  ddim,
  @JsonValue("DDPM")
  ddpm,
  @JsonValue("K_DPMPP_2M")
  kDpmpp2m,
  @JsonValue("K_DPMPP_2S_ANCESTRAL")
  kDpmpp2sAncestral,
  @JsonValue("K_DPM_2")
  kDpm2,
  @JsonValue("K_DPM_2_ANCESTRAL")
  kDpm2Ancestral,
  @JsonValue("K_EULER")
  kEuler,
  @JsonValue("K_EULER_ANCESTRAL")
  kEulerAncestral,
  @JsonValue("K_HEUN")
  kHeun,
  @JsonValue("K_LMS")
  kLms,
}

enum ClipGuidancePreset {
  @JsonValue("NONE")
  none,
  @JsonValue("FAST_BLUE")
  fastBlue,
  @JsonValue("FAST_GREEN")
  fastGreen,
  @JsonValue("SIMPLE")
  simple,
  @JsonValue("SLOW")
  slow,
  @JsonValue("SLOWER")
  slower,
  @JsonValue("SLOWEST")
  slowest,
}

enum GenerationAcceptType {
  @JsonValue("application/json")
  json,
  @JsonValue("image/png")
  png,
}

enum FinishReason {

  @JsonValue("CONTENT_FILTERED")
  contentFiltered,

  @JsonValue("ERROR")
  error,

  @JsonValue("SUCCESS")
  success,
}