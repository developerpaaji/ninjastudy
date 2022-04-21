import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable(explicitToJson: true)
class User extends Equatable {
  final String id;
  final String? username;
  final String? password;
  final DateTime? createdAt;

  const User({required this.id, this.username, this.createdAt, this.password});

  @override
  List<Object?> get props => [id];

  Map<String, dynamic> toJson() => _$UserToJson(this);

  factory User.fromJson(json) => _$UserFromJson(json);
}
