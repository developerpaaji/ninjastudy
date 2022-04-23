import 'package:flutter_test/flutter_test.dart';
import 'package:study/providers/message.dart';
import 'package:study/models/conversation.dart';
import 'package:study/models/message.dart';
import 'package:study/models/user.dart';

void main() {
  Conversation conversation =
      Conversation(id: "1", createdAt: DateTime.now(), sentences: [
    ConversationSentence(bot: "Hello", human: "How are you"),
    ConversationSentence(bot: "I am fine", human: "Awesome"),
  ]);
  User user = User(id: "1", username: "bhavneet", createdAt: DateTime.now());
  MessageProvider messageProvider =
      MessageProvider(conversation: conversation, user: user);
  test("Human must see Hi #username", () {
    expect(messageProvider.messages.first.text, "Hi ${user.username}");
  });

  test("Human can type now", () {
    expect(messageProvider.humanCanSend, true);
  });

  test(
      "If Human enter wrong response and then they will see Please try again and suggestion",
      () async {
    final replyTo = messageProvider.messages.last;
    await messageProvider.addHumanMessage("Sup", replyTo);
    Message lastMessage = messageProvider.messages.last;
    expect(lastMessage.text, pleaseTryAgain);
  });

  test("If Human enter right response and then they will see next sentence",
      () async {
    final replyTo = messageProvider.messages.last;
    await messageProvider.addHumanMessage(
        '${conversation.sentences!.first.human}', replyTo);
    Message lastMessage = messageProvider.messages.last;
    expect(lastMessage.text, '${conversation.sentences!.last.bot}');
  });

  test(
      "If Human enter last correct response and then they will see 'Conversation Ended'",
      () async {
    final replyTo = messageProvider.messages.last;
    await messageProvider.addHumanMessage(
        '${conversation.sentences!.last.human}', replyTo);
    Message lastMessage = messageProvider.messages.last;
    expect(lastMessage.text, conversationEndedMessage);
    expect(messageProvider.humanCanSend, false);
  });
}
