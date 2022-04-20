import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:study/models/message.dart';

part 'conversation.g.dart';

enum ConversationTopic { restaurant, interview }

class Conversation extends Equatable {
  final String id;
  final ConversationTopic? topic;
  final DateTime? createdAt;
  final List<ConversationSentence>? sentences;
  final Message? lastMessage;

  const Conversation(
      {required this.id,
      this.topic,
      this.lastMessage,
      this.createdAt,
      this.sentences});

  @override
  List<Object?> get props => [id];

  Conversation copyWith(
      {String? id,
      ConversationTopic? topic,
      DateTime? createdAt,
      List<ConversationSentence>? sentences,
      Message? lastMessage}) {
    return Conversation(
        id: id ?? this.id,
        createdAt: createdAt ?? this.createdAt,
        lastMessage: lastMessage ?? this.lastMessage,
        sentences: sentences ?? this.sentences,
        topic: topic ?? this.topic);
  }
}

@JsonSerializable(createToJson: false)
class ConversationSentence {
  final String? bot;
  final String? human;

  ConversationSentence({
    this.bot,
    this.human,
  });

  factory ConversationSentence.fromJson(json) =>
      _$ConversationSentenceFromJson(json);
}
