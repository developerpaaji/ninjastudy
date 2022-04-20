import 'package:equatable/equatable.dart';

class Message extends Equatable {
  final String id;
  final String? text;
  final bool? isBot;
  final bool? isMeta;
  final DateTime? createdAt;
  final String? botSuggestion;
  final String? conversationId;

  const Message({
    required this.id,
    this.text,
    this.isMeta,
    this.isBot,
    this.createdAt,
    this.botSuggestion,
    this.conversationId,
  });

  Message copyWith(
      {String? id,
      String? text,
      bool? isMeta,
      DateTime? createdAt,
      String? botSuggestion,
      bool? isBot,
      String? conversationId}) {
    return Message(
      id: id ?? this.id,
      text: text ?? this.text,
      botSuggestion: botSuggestion ?? this.botSuggestion,
      conversationId: conversationId ?? this.conversationId,
      createdAt: createdAt ?? this.createdAt,
      isBot: isBot ?? this.isBot,
      isMeta: isMeta ?? this.isMeta,
    );
  }

  @override
  List<Object?> get props => [id];
}
