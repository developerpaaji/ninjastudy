import 'package:equatable/equatable.dart';

enum ConversationTopic{
  restaurant,
  interview
}

class Conversation extends Equatable{
    final String id;
    final ConversationTopic? topic;
    final DateTime? createdAt;

  const Conversation({required this.id, this.topic, this.createdAt,});

  @override
  List<Object?> get props =>[id];
}