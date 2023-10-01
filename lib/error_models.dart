
import 'package:json_annotation/json_annotation.dart';

part 'error_models.g.dart';

@JsonSerializable(includeIfNull: false)
class ServerError {

  String id;
  String name;
  String message;

  ServerError({required this.id, required this.name, required this.message});

  factory ServerError.fromJson(Map<String, dynamic> json) =>
      _$ServerErrorFromJson(json);

  Map<String, dynamic> toJson() => _$ServerErrorToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}