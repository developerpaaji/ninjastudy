import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:study/locator.dart';
import 'package:study/models/conversation.dart';
import 'package:study/models/user.dart';
import 'package:study/providers/conversation.dart';
import 'package:study/screens/message.dart';
import 'package:study/services/conversation.dart';
import 'package:study/utils/meta/asset.dart';
import 'package:study/utils/meta/text.dart';
import 'package:study/widgets/conversation_tile.dart';
import 'package:study/widgets/person_avatar.dart';
import 'package:study/widgets/topic_pick_sheet.dart';

class HomeScreen extends StatelessWidget {
  final User user;
  const HomeScreen({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ConversationProvider>(
        create: (context) =>
            ConversationProvider(locator.get<ConversationService>()),
        builder: (context, child) {
          final conversationProvider =
              Provider.of<ConversationProvider>(context);
          final conversations = conversationProvider.conversations;
          conversations.sort((b, a) {
            if (a.lastMessage != null && b.lastMessage != null) {
              return a.lastMessage!.createdAt!
                  .compareTo(b.lastMessage!.createdAt!);
            }
            if (a.lastMessage != null && b.lastMessage == null) {
              return a.lastMessage!.createdAt!.compareTo(b.createdAt!);
            }
            if (a.lastMessage == null && b.lastMessage != null) {
              return a.createdAt!.compareTo(b.lastMessage!.createdAt!);
            }
            return a.createdAt!.compareTo(b.createdAt!);
          });
          return Scaffold(
            appBar: AppBar(
              centerTitle: false,
              elevation: 0.6,
              title: Text(MetaText.of(context).conversations),
              titleTextStyle: Theme.of(context)
                  .appBarTheme
                  .titleTextStyle
                  ?.copyWith(fontSize: 22),
              actions: [
                PersonAvatar(
                    username: user.username ?? MetaText.of(context).anonymous),
                const SizedBox(width: 12)
              ],
            ),
            body: conversations.isEmpty
                ? Center(child: _emptyPlaceholder)
                : ListView.separated(
                    separatorBuilder: (context, index) =>
                        const Divider(height: 2),
                    itemBuilder: (context, index) => ConversationTile(
                        conversation: conversations[index],
                        onTap: (conversation) {
                          _goToConversation(context, conversation);
                        },
                        key: Key(conversations[index].id)),
                    itemCount: conversations.length,
                    shrinkWrap: true,
                    physics: const ClampingScrollPhysics(),
                  ),
            floatingActionButton: FloatingActionButton(
              onPressed: conversationProvider.creating
                  ? null
                  : () => _chooseTopic(context),
              child: conversationProvider.creating
                  ? CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                          Theme.of(context).colorScheme.onPrimary),
                    )
                  : const Icon(Icons.add),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
          );
        });
  }

  void _chooseTopic(BuildContext context) async {
    final conversationProvider =
        Provider.of<ConversationProvider>(context, listen: false);
    final topic = await showModalBottomSheet<ConversationTopic?>(
        context: context,
        backgroundColor: Colors.transparent,
        builder: (context) => TopicPickSheet(
              onSelected: (topic) {
                Navigator.of(context).pop(topic);
              },
            ));
    if (topic == null) {
      return;
    }
    final response = await conversationProvider.createConversation(topic);
    if (response.isSuccess) {
      _goToConversation(context, response.data!);
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("${response.error}")));
    }
  }

  void _goToConversation(BuildContext context, Conversation conversation) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => MessageScreen(conversation: conversation),
    ));
  }

  Widget get _emptyPlaceholder {
    return Builder(builder: (context) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            LottieBuilder.asset(
              MetaAsset.of(context).lottieAI,
              width: MediaQuery.of(context).size.width / 1,
            ),
            const SizedBox(height: 12),
            Text(MetaText.of(context).startConversation,
                style: Theme.of(context).textTheme.headline5),
            const SizedBox(height: 12),
            Text(
              MetaText.of(context).startConversationDescription,
              style: Theme.of(context).textTheme.subtitle1,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 75)
          ],
        ),
      );
    });
  }
}
