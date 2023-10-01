
import 'package:json_annotation/json_annotation.dart';

part 'user_dto.g.dart';

@JsonSerializable(includeIfNull: false)
class Account {
  String email;
  String id;
  @JsonKey(name: "profile_picture")
  String? profilePicture;

  List<Organization> organizations;

  Account({required this.email, required this.id, this.profilePicture, required this.organizations});

  factory Account.fromJson(Map<String, dynamic> json) =>
      _$AccountFromJson(json);

  Map<String, dynamic> toJson() => _$AccountToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}

@JsonSerializable(includeIfNull: false)
class Organization {

  String id;
  String name;
  String role;
  @JsonKey(name: "is_default")
  bool isDefault;

  Organization({required this.id, required this.name, required this.role, required this.isDefault});

  factory Organization.fromJson(Map<String, dynamic> json) =>
      _$OrganizationFromJson(json);

  Map<String, dynamic> toJson() => _$OrganizationToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}

@JsonSerializable(includeIfNull: false)
class Balance {

  double credits;

  Balance({required this.credits});

  factory Balance.fromJson(Map<String, dynamic> json) =>
      _$BalanceFromJson(json);

  Map<String, dynamic> toJson() => _$BalanceToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}