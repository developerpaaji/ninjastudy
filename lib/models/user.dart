import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String id;
  final String? username;
  final DateTime? createdAt;

  const User({
    required this.id,
    this.username,
    this.createdAt,
  });

  @override
  List<Object?> get props => [id];
}
