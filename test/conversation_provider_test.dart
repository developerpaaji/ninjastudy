import 'package:flutter_test/flutter_test.dart';
import 'package:study/models/conversation.dart';
import 'package:study/models/message.dart';
import 'package:study/providers/conversation.dart';
import 'package:study/services/conversation.dart';

void main() {
  ConversationService conversationService = ConversationMockService();
  ConversationProvider conversationProvider =
      ConversationProvider(conversationService);
  test("Create conversations ", () async {
    await conversationProvider.createConversation(ConversationTopic.restaurant);
    final conversations = conversationProvider.conversations;
    expect(conversations.length, 1);
  });

  test("Update last message", () async {
    final conversation = conversationProvider.conversations.first;
    conversationProvider.updateLastMessage(
        conversation.id, const Message(id: "1"));
    final updatedConversation = conversationProvider.conversations.firstWhere(
        (conversationItem) => conversation.id == conversationItem.id);
    expect(updatedConversation.lastMessage!.id, "1");
  });
}
