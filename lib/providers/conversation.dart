import 'package:flutter/material.dart';
import 'package:study/blocs/message.dart';
import 'package:study/models/conversation.dart';
import 'package:study/models/message.dart';
import 'package:study/models/response.dart';
import 'package:study/services/conversation.dart';

class ConversationProvider extends ChangeNotifier {
  late List<Conversation> _conversations;
  final ConversationService conversationService;

  ConversationProvider(this.conversationService) {
    _conversations = [];
    messageStream.listen((message) {
      _updateConversation(message);
    });
  }

  void _updateConversation(Message message) {
    int index = _conversations.indexWhere(
        (conversation) => conversation.id == message.conversationId);
    if (index >= 0) {
      _conversations[index] =
          _conversations[index].copyWith(lastMessage: message);
      notifyListeners();
    }
  }

  bool _creating = false;

  Future<ConversationResponse> createConversation(
      ConversationTopic topic) async {
    if (_creating) {
      return ApiResponse(
          error: "Can not create another while one is in progress");
    }
    _creating = true;
    notifyListeners();
    final response = await conversationService.createConversation(topic);
    _creating = false;
    if (response.isSuccess) {
      _conversations.insert(0, response.data!);
    }
    notifyListeners();
    return response;
  }

  Future<void> updateLastMessage(String conversationId, Message message) async {
    int index = _conversations
        .indexWhere((conversation) => conversation.id == conversationId);
    if (index < 0) {
      throw "conversation not found";
    }
    _conversations[index] =
        _conversations[index].copyWith(lastMessage: message);
    notifyListeners();
  }

  List<Conversation> get conversations => _conversations.toList();

  bool get creating => _creating;
}
