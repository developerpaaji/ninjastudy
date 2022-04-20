import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:study/blocs/auth.dart';
import 'package:study/providers/message.dart';
import 'package:study/models/conversation.dart';
import 'package:study/utils/meta/text.dart';
import 'package:study/widgets/message.dart';
import 'package:study/widgets/message_input.dart';
import 'package:study/widgets/message_list_view.dart';

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
                            return MessageWidget(
                              message: message,
                              showAvatar: showAvatar,
                              topic: widget.conversation.topic!,
                              user: user,
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
