import 'package:equatable/equatable.dart';

class Message extends Equatable {
  final String id;
  final String? text;
  final bool? isBot;
  final DateTime? createdAt;
  final List<String>? botSuggestions;

  const Message({
    required this.id,
    this.text,
    this.isBot,
    this.createdAt,
    this.botSuggestions,
  });

  @override
  List<Object?> get props => [id];
}
