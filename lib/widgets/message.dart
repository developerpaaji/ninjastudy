import 'package:study/models/conversation.dart';
import 'package:study/models/message.dart';
import 'package:study/models/user.dart';
import 'package:study/utils/meta/color.dart';
import 'package:study/utils/meta/text.dart';
import 'package:study/widgets/conversation_tile.dart';
import 'package:study/widgets/person_avatar.dart';
import 'package:flutter/material.dart';

class MetaMessageWidget extends StatelessWidget {
  final Message message;
  const MetaMessageWidget({
    Key? key,
    required this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        decoration: BoxDecoration(
            color: MetaColor.of(context).black.withOpacity(0.6),
            borderRadius: BorderRadius.circular(24)),
        padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
        child: Text("${message.text}",
            style: TextStyle(fontSize: 12, color: MetaColor.of(context).white)),
      ),
    );
  }
}

class MessageWidget extends StatelessWidget {
  final Message message;
  final bool showAvatar;
  final ConversationTopic? topic;
  final User? user;
  MessageWidget(
      {Key? key,
      required this.message,
      this.showAvatar = true,
      this.topic,
      this.user})
      : assert(showAvatar
            ? ((message.isBot ?? false) ? topic != null : user != null)
            : true),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: (message.isBot ?? false)
          ? Alignment.centerLeft
          : Alignment.centerRight,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Opacity(
            opacity: showAvatar && (message.isBot ?? false) ? 1.0 : 0.0,
            child: Container(
              margin: const EdgeInsets.only(right: 8),
              child: ConversationTopicIcon(radius: 16, topic: topic!),
            ),
          ),
          Flexible(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    decoration: BoxDecoration(
                        color: MetaColor.of(context).materialAccent,
                        borderRadius: BorderRadius.circular(32)),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    child: Text("${message.text}")),
                if ((message.isBot ?? false) && message.botSuggestion != null)
                  Container(
                    margin: const EdgeInsets.only(top: 4),
                    child: Container(
                      decoration: BoxDecoration(
                          color: MetaColor.of(context).materialAccent,
                          borderRadius: BorderRadius.circular(32)),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 8),
                      child: Text.rich(TextSpan(children: [
                        TextSpan(
                          text: MetaText.of(context).suggestion + " - ",
                          style: const TextStyle(fontWeight: FontWeight.w600),
                        ),
                        TextSpan(
                          text: "${message.botSuggestion}",
                          style: const TextStyle(fontStyle: FontStyle.italic),
                        )
                      ])),
                    ),
                  )
              ],
            ),
          ),
          if (showAvatar && !(message.isBot ?? false))
            Container(
              margin: const EdgeInsets.only(left: 8),
              child: PersonAvatar(radius: 16, username: user!.username!),
            ),
        ],
      ),
    );
  }
}
