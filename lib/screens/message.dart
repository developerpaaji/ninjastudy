import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:study/blocs/auth.dart';
import 'package:study/blocs/message.dart';
import 'package:study/models/conversation.dart';
import 'package:study/models/message.dart';
import 'package:study/utils/meta/color.dart';
import 'package:study/utils/meta/text.dart';
import 'package:study/widgets/conversation_tile.dart';
import 'package:study/widgets/message_input.dart';
import 'package:study/widgets/message_list_view.dart';
import 'package:study/widgets/person_avatar.dart';

class MessageScreen extends StatefulWidget {
  final Conversation conversation;
  const MessageScreen({
    Key? key,
    required this.conversation,
  }) : super(key: key);

  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  @override
  Widget build(BuildContext context) {
    final state = BlocProvider.of<AuthBloc>(context).state;
    if (state is! AuthSuccessState) {
      throw UnsupportedError("User must be logged in");
    }
    final user = state.user;
    return ChangeNotifierProvider<MessageProvider>(
        create: (context) =>
            MessageProvider(conversation: widget.conversation, user: user),
        builder: (context, child) {
          final messageProvider = Provider.of<MessageProvider>(context);
          final messages = messageProvider.messages;
          return Scaffold(
            appBar: AppBar(
              title: Text(MetaText.of(context).chat),
            ),
            body: SafeArea(
              top: false,
              child: Column(
                children: [
                  Expanded(
                      child: MessageAnimatedList(
                          isTyping: messageProvider.isBotTyping,
                          messages: messages,
                          padding: const EdgeInsets.symmetric(
                              vertical: 12, horizontal: 12),
                          messageBuilder: (context, message, showAvatar) {
                            if (message.isMeta ?? false) {
                              return MetaMessageWidget(message: message);
                            }
                            return Container(
                              alignment: (message.isBot ?? false)
                                  ? Alignment.centerLeft
                                  : Alignment.centerRight,
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Opacity(
                                    opacity:
                                        showAvatar && (message.isBot ?? false)
                                            ? 1.0
                                            : 0.0,
                                    child: Container(
                                      margin: const EdgeInsets.only(right: 8),
                                      child: ConversationTopicIcon(
                                          radius: 16,
                                          topic: widget.conversation.topic!),
                                    ),
                                  ),
                                  Flexible(
                                    child: Container(
                                        decoration: BoxDecoration(
                                            color: const Color(0xffeeeeee),
                                            borderRadius:
                                                BorderRadius.circular(32)),
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 12, vertical: 8),
                                        child: Text("${message.text}")),
                                  ),
                                  if (showAvatar && !(message.isBot ?? false))
                                    Container(
                                      margin: const EdgeInsets.only(left: 8),
                                      child: PersonAvatar(
                                          radius: 16, username: user.username!),
                                    ),
                                ],
                              ),
                            );
                          })),
                  if (!messageProvider.conversationEnded)
                    MessageInputWidget(
                      canSend: messageProvider.humanCanSend,
                      onSubmitted: (text) {
                        messageProvider.addHumanMessage(
                            text, messageProvider.messages.last);
                      },
                    ),
                ],
              ),
            ),
          );
        });
  }
}

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
