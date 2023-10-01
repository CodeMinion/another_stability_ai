// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'engine_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Engine _$EngineFromJson(Map<String, dynamic> json) => Engine(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      type: $enumDecode(_$EngineTypeEnumMap, json['type']),
    );

Map<String, dynamic> _$EngineToJson(Engine instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'type': _$EngineTypeEnumMap[instance.type]!,
    };

const _$EngineTypeEnumMap = {
  EngineType.audio: 'AUDIO',
  EngineType.classification: 'CLASSIFICATION',
  EngineType.picture: 'PICTURE',
  EngineType.storage: 'STORAGE',
  EngineType.text: 'TEXT',
  EngineType.video: 'VIDEO',
};
