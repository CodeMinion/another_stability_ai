
import 'package:json_annotation/json_annotation.dart';

part 'engine_dto.g.dart';

@JsonSerializable(includeIfNull: false)
class Engine {

  String id;
  String name;
  String description;
  EngineType type;

  Engine({required this.id, required this.name, required this.description, required this.type});

  factory Engine.fromJson(Map<String, dynamic> json) =>
      _$EngineFromJson(json);

  Map<String, dynamic> toJson() => _$EngineToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}

enum EngineType {

  @JsonValue("AUDIO")
  audio,

  @JsonValue("CLASSIFICATION")
  classification,

  @JsonValue("PICTURE")
  picture,

  @JsonValue("STORAGE")
  storage,

  @JsonValue("TEXT")
  text,

  @JsonValue("VIDEO")
  video,
}