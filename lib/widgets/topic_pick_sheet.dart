import 'package:flutter/material.dart';
import 'package:study/models/conversation.dart';
import 'package:study/utils/meta/color.dart';
import 'package:study/utils/text.dart';
import 'package:study/widgets/conversation_tile.dart';

class TopicPickSheet extends StatelessWidget {
  final Function(ConversationTopic? topic) onSelected;
  const TopicPickSheet({Key? key, required this.onSelected}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
      margin: const EdgeInsets.symmetric(horizontal: 12),
      height: 300,
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
          color: Theme.of(context).backgroundColor),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text("Start a conversation with",
              style: Theme.of(context)
                  .textTheme
                  .subtitle1
                  ?.copyWith(fontWeight: FontWeight.w600)),
          const SizedBox(height: 18),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildButton(ConversationTopic.restaurant, onSelected),
              _buildButton(ConversationTopic.interview, onSelected),
            ],
          ),
          const Spacer(),
          FloatingActionButton(
            onPressed: () {
              onSelected(null);
            },
            child: const Icon(Icons.close),
          ),
          const Spacer(),
        ],
      ),
    );
  }

  Widget _buildButton(
      ConversationTopic topic, Function(ConversationTopic topic) onPressed) {
    return Builder(builder: (context) {
      return GestureDetector(
        onTap: () {
          onPressed(topic);
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: MetaColor.of(context).materialAccent.withOpacity(0.6),
          ),
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ConversationTopicIcon(topic: topic),
              const SizedBox(height: 4),
              Text(capitalize(topic.name)),
            ],
          ),
        ),
      );
    });
  }
}
