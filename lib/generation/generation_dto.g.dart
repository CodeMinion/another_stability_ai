// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'generation_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TextToImageRequestParams _$TextToImageRequestParamsFromJson(
        Map<String, dynamic> json) =>
    TextToImageRequestParams(
      width: json['width'] as int? ?? 512,
      height: json['height'] as int? ?? 512,
      textPrompts: (json['text_prompts'] as List<dynamic>)
          .map((e) => TextPrompt.fromJson(e as Map<String, dynamic>))
          .toList(),
      cfgScale: json['cfg_scale'] as int? ?? 7,
      clipGuidancePreset: $enumDecodeNullable(
              _$ClipGuidancePresetEnumMap, json['clip_guidance_preset']) ??
          ClipGuidancePreset.none,
      sampler: $enumDecodeNullable(_$SamplerEnumMap, json['sampler']),
      samples: json['samples'] as int? ?? 1,
      seed: json['seed'] as int? ?? 0,
      steps: json['steps'] as int? ?? 50,
      stylePreset: $enumDecode(_$StylePresetEnumMap, json['style_preset']),
    );

Map<String, dynamic> _$TextToImageRequestParamsToJson(
    TextToImageRequestParams instance) {
  final val = <String, dynamic>{
    'height': instance.height,
    'width': instance.width,
    'text_prompts': instance.textPrompts,
    'cfg_scale': instance.cfgScale,
    'clip_guidance_preset':
        _$ClipGuidancePresetEnumMap[instance.clipGuidancePreset]!,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('sampler', _$SamplerEnumMap[instance.sampler]);
  val['samples'] = instance.samples;
  val['seed'] = instance.seed;
  val['steps'] = instance.steps;
  val['style_preset'] = _$StylePresetEnumMap[instance.stylePreset]!;
  return val;
}

const _$ClipGuidancePresetEnumMap = {
  ClipGuidancePreset.none: 'NONE',
  ClipGuidancePreset.fastBlue: 'FAST_BLUE',
  ClipGuidancePreset.fastGreen: 'FAST_GREEN',
  ClipGuidancePreset.simple: 'SIMPLE',
  ClipGuidancePreset.slow: 'SLOW',
  ClipGuidancePreset.slower: 'SLOWER',
  ClipGuidancePreset.slowest: 'SLOWEST',
};

const _$SamplerEnumMap = {
  Sampler.ddim: 'DDIM',
  Sampler.ddpm: 'DDPM',
  Sampler.kDpmpp2m: 'K_DPMPP_2M',
  Sampler.kDpmpp2sAncestral: 'K_DPMPP_2S_ANCESTRAL',
  Sampler.kDpm2: 'K_DPM_2',
  Sampler.kDpm2Ancestral: 'K_DPM_2_ANCESTRAL',
  Sampler.kEuler: 'K_EULER',
  Sampler.kEulerAncestral: 'K_EULER_ANCESTRAL',
  Sampler.kHeun: 'K_HEUN',
  Sampler.kLms: 'K_LMS',
};

const _$StylePresetEnumMap = {
  StylePreset.model3d: '3d-model',
  StylePreset.analogFilm: 'analog-film',
  StylePreset.anime: 'anime',
  StylePreset.cinematic: 'cinematic',
  StylePreset.comicBook: 'comic-book',
  StylePreset.digitalArt: 'digital-art',
  StylePreset.enhance: 'enhance',
  StylePreset.fantasyArt: 'fantasy-art',
  StylePreset.isometric: 'isometric',
  StylePreset.lineArt: 'line-art',
  StylePreset.lowPoly: 'low-poly',
  StylePreset.modelingCompound: 'modeling-compound',
  StylePreset.neonPunk: 'neon-punk',
  StylePreset.origami: 'origami',
  StylePreset.photographic: 'photographic',
  StylePreset.pixelArt: 'pixel-art',
  StylePreset.tileTexture: 'tile-texture',
};

TextPrompt _$TextPromptFromJson(Map<String, dynamic> json) => TextPrompt(
      text: json['text'] as String,
      weight: (json['weight'] as num?)?.toDouble() ?? 0.5,
    );

Map<String, dynamic> _$TextPromptToJson(TextPrompt instance) =>
    <String, dynamic>{
      'text': instance.text,
      'weight': instance.weight,
    };

ImageToImageRequestParams _$ImageToImageRequestParamsFromJson(
        Map<String, dynamic> json) =>
    ImageToImageRequestParams(
      initImageMode: $enumDecodeNullable(
              _$InitImageModeEnumMap, json['init_image_mode']) ??
          InitImageMode.imageStrength,
      imageStrength: (json['image_strength'] as num?)?.toDouble() ?? 0.35,
      stepScheduleStart:
          (json['step_schedule_start'] as num?)?.toDouble() ?? 0.65,
      stepScheduleEnd: (json['step_schedule_end'] as num?)?.toDouble() ?? 0,
      textPrompts: (json['text_prompts'] as List<dynamic>)
          .map((e) => TextPrompt.fromJson(e as Map<String, dynamic>))
          .toList(),
      cfgScale: json['cfg_scale'] as int? ?? 7,
      clipGuidancePreset: $enumDecodeNullable(
              _$ClipGuidancePresetEnumMap, json['clip_guidance_preset']) ??
          ClipGuidancePreset.none,
      sampler: $enumDecodeNullable(_$SamplerEnumMap, json['sampler']),
      samples: json['samples'] as int? ?? 1,
      seed: json['seed'] as int? ?? 0,
      steps: json['steps'] as int? ?? 50,
      stylePreset: $enumDecode(_$StylePresetEnumMap, json['style_preset']),
    );

Map<String, dynamic> _$ImageToImageRequestParamsToJson(
    ImageToImageRequestParams instance) {
  final val = <String, dynamic>{
    'text_prompts': instance.textPrompts,
    'init_image_mode': _$InitImageModeEnumMap[instance.initImageMode]!,
    'image_strength': instance.imageStrength,
    'step_schedule_start': instance.stepScheduleStart,
    'step_schedule_end': instance.stepScheduleEnd,
    'cfg_scale': instance.cfgScale,
    'clip_guidance_preset':
        _$ClipGuidancePresetEnumMap[instance.clipGuidancePreset]!,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('sampler', _$SamplerEnumMap[instance.sampler]);
  val['samples'] = instance.samples;
  val['seed'] = instance.seed;
  val['steps'] = instance.steps;
  val['style_preset'] = _$StylePresetEnumMap[instance.stylePreset]!;
  return val;
}

const _$InitImageModeEnumMap = {
  InitImageMode.imageStrength: 'IMAGE_STRENGTH',
  InitImageMode.stepSchedule: 'STEP_SCHEDULE',
};

RealESRGANUpscaleRequestParams _$RealESRGANUpscaleRequestParamsFromJson(
        Map<String, dynamic> json) =>
    RealESRGANUpscaleRequestParams(
      width: json['width'] as int,
      height: json['height'] as int,
    );

Map<String, dynamic> _$RealESRGANUpscaleRequestParamsToJson(
        RealESRGANUpscaleRequestParams instance) =>
    <String, dynamic>{
      'width': instance.width,
      'height': instance.height,
    };

LatentUpscalerUpscaleRequestParams _$LatentUpscalerUpscaleRequestParamsFromJson(
        Map<String, dynamic> json) =>
    LatentUpscalerUpscaleRequestParams(
      width: json['width'] as int,
      height: json['height'] as int,
      textPrompts: (json['text_prompts'] as List<dynamic>)
          .map((e) => TextPrompt.fromJson(e as Map<String, dynamic>))
          .toList(),
      seed: json['seed'] as int? ?? 0,
      steps: json['steps'] as int? ?? 50,
      cfgScale: json['cfg_scale'] as int? ?? 7,
    );

Map<String, dynamic> _$LatentUpscalerUpscaleRequestParamsToJson(
        LatentUpscalerUpscaleRequestParams instance) =>
    <String, dynamic>{
      'width': instance.width,
      'height': instance.height,
      'text_prompts': instance.textPrompts,
      'seed': instance.seed,
      'steps': instance.steps,
      'cfg_scale': instance.cfgScale,
    };

ImageToImageUpscaleRequestParams _$ImageToImageUpscaleRequestParamsFromJson(
        Map<String, dynamic> json) =>
    ImageToImageUpscaleRequestParams(
      maskSource:
          $enumDecodeNullable(_$MaskSourceEnumMap, json['mask_source']) ??
              MaskSource.maskImageBlack,
      textPrompts: (json['text_prompts'] as List<dynamic>)
          .map((e) => TextPrompt.fromJson(e as Map<String, dynamic>))
          .toList(),
      cfgScale: json['cfg_scale'] as int? ?? 7,
      clipGuidancePreset: $enumDecodeNullable(
              _$ClipGuidancePresetEnumMap, json['clip_guidance_preset']) ??
          ClipGuidancePreset.none,
      sampler: $enumDecodeNullable(_$SamplerEnumMap, json['sampler']),
      samples: json['samples'] as int? ?? 1,
      seed: json['seed'] as int? ?? 0,
      steps: json['steps'] as int? ?? 50,
      stylePreset: $enumDecode(_$StylePresetEnumMap, json['style_preset']),
    );

Map<String, dynamic> _$ImageToImageUpscaleRequestParamsToJson(
    ImageToImageUpscaleRequestParams instance) {
  final val = <String, dynamic>{
    'text_prompts': instance.textPrompts,
    'mask_source': _$MaskSourceEnumMap[instance.maskSource]!,
    'cfg_scale': instance.cfgScale,
    'clip_guidance_preset':
        _$ClipGuidancePresetEnumMap[instance.clipGuidancePreset]!,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('sampler', _$SamplerEnumMap[instance.sampler]);
  val['samples'] = instance.samples;
  val['seed'] = instance.seed;
  val['steps'] = instance.steps;
  val['style_preset'] = _$StylePresetEnumMap[instance.stylePreset]!;
  return val;
}

const _$MaskSourceEnumMap = {
  MaskSource.maskImageWhite: 'MASK_IMAGE_WHITE',
  MaskSource.maskImageBlack: 'MASK_IMAGE_BLACK',
  MaskSource.initImageAlpha: 'INIT_IMAGE_ALPHA',
};

ImageResponse _$ImageResponseFromJson(Map<String, dynamic> json) =>
    ImageResponse(
      seed: json['seed'] as int,
      finishReason: $enumDecode(_$FinishReasonEnumMap, json['finishReason']),
      base64: json['base64'] as String?,
    );

Map<String, dynamic> _$ImageResponseToJson(ImageResponse instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('base64', instance.base64);
  val['finishReason'] = _$FinishReasonEnumMap[instance.finishReason]!;
  val['seed'] = instance.seed;
  return val;
}

const _$FinishReasonEnumMap = {
  FinishReason.contentFiltered: 'CONTENT_FILTERED',
  FinishReason.error: 'ERROR',
  FinishReason.success: 'SUCCESS',
};

ImageResponseListDto _$ImageResponseListDtoFromJson(
        Map<String, dynamic> json) =>
    ImageResponseListDto(
      artifacts: (json['artifacts'] as List<dynamic>)
          .map((e) => ImageResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ImageResponseListDtoToJson(
        ImageResponseListDto instance) =>
    <String, dynamic>{
      'artifacts': instance.artifacts,
    };
