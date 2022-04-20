import 'package:flutter/material.dart';
import 'package:study/models/conversation.dart';
import 'package:study/utils/meta/text.dart';
import 'package:study/utils/text.dart';

class ConversationTile extends StatelessWidget {
  final Conversation conversation;
  final Function(Conversation conversation)? onTap;
  const ConversationTile({Key? key, required this.conversation, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap != null
          ? () {
              onTap!(conversation);
            }
          : null,
      leading: conversation.topic != null
          ? ConversationTopicIcon(topic: conversation.topic!)
          : null,
      title: conversation.topic?.name != null
          ? Text(
              capitalize(conversation.topic!.name),
              style: const TextStyle(fontWeight: FontWeight.w500),
            )
          : null,
      subtitle: Text(
        conversation.lastMessage?.text ??
            MetaText.of(context).startConversation,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
      trailing: const Icon(Icons.chevron_right),
    );
  }
}

class ConversationTopicIcon extends StatelessWidget {
  final ConversationTopic topic;
  final double radius;
  const ConversationTopicIcon({
    Key? key,
    required this.topic,
    this.radius = 20,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color color1 = _color;
    Color color2 = _color.withOpacity(0.7);
    return Container(
        width: radius * 2,
        height: radius * 2,
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(colors: [color1, color2])),
        child: Icon(
          _iconData,
          color: Colors.white,
          size: radius,
        ));
  }

  IconData get _iconData {
    switch (topic) {
      case ConversationTopic.interview:
        return Icons.group;
      case ConversationTopic.restaurant:
      default:
        return Icons.restaurant;
    }
  }

  Color get _color {
    switch (topic) {
      case ConversationTopic.interview:
        return Colors.red;
      case ConversationTopic.restaurant:
      default:
        return Colors.green;
    }
  }
}
