import 'package:flutter/material.dart';
import 'package:rxdart/subjects.dart';
import 'package:string_similarity/string_similarity.dart';
import 'package:study/models/conversation.dart';
import 'package:study/models/message.dart';
import 'package:study/models/user.dart';
import 'package:uuid/uuid.dart';

const conversationEndedMessage = "Thanks, this conversation has ended";
const pleaseTryAgain = "Please try again";
const newConversation = "New Conversation";

Map<String, List<Message>> _messagesByConversation = {};

final BehaviorSubject<Message> _messageSubject = BehaviorSubject();

Stream<Message> get messageStream => _messageSubject.stream;

class MessageProvider extends ChangeNotifier {
  final Conversation conversation;
  final User user;
  late List<ConversationSentence> _sentenceList;
  late int _sentenceIndex;
  late bool _isBotTyping = false;
  late bool _conversationEnded;

  MessageProvider({required this.conversation, required this.user}) {
    _sentenceList = (conversation.sentences ?? []).toList();
    assert(_sentenceList.isNotEmpty);
    _sentenceIndex = 0;
    _conversationEnded = false;
    _init();
  }

  void _init() {
    if (messages.isEmpty || (messages.last.isEnd ?? false)) {
      if (messages.isNotEmpty && (messages.last.isEnd ?? false)) {
        if (_messagesByConversation[conversation.id] != null) {
          _add(_createMessage().copyWith(isMeta: true, text: newConversation));
          notifyListeners();
        }
      }
      _add(_createMessage().copyWith(
          isBot: true,
          botSuggestion: _sentenceList[_sentenceIndex].human,
          text: 'Hi ${user.username}'));
    }
    notifyListeners();
    return;
  }

  Message _createMessage() {
    return Message(
      id: const Uuid().v4(),
      conversationId: conversation.id,
      createdAt: DateTime.now(),
    );
  }

  void _add(Message message) {
    if (_messagesByConversation[conversation.id] == null) {
      _messagesByConversation[conversation.id] = [];
    }
    _messagesByConversation[conversation.id]!.add(message);
    _messageSubject.add(message);
  }

  Future<void> addHumanMessage(String text, Message replyTo) async {
    if (_conversationEnded) {
      throw "Conversation ended";
    }
    assert(replyTo.isBot == true);
    _add(_createMessage().copyWith(isBot: false, text: text));
    notifyListeners();
    await Future.delayed(const Duration(milliseconds: 200));
    _isBotTyping = true;
    notifyListeners();
    await Future.delayed(const Duration(milliseconds: 800));
    _isBotTyping = false;
    bool isCorrect = _isSimilar(text, replyTo.botSuggestion!);
    _sentenceIndex += isCorrect ? 1 : 0;
    if (_sentenceIndex >= _sentenceList.length) {
      _add(_createMessage().copyWith(
        isBot: true,
        text: conversationEndedMessage,
        isEnd: true,
      ));
      _conversationEnded = true;
      notifyListeners();
      return;
    } else {
      if (!isCorrect) {
        _add(_createMessage().copyWith(
          isBot: true,
          text: pleaseTryAgain,
          botSuggestion: replyTo.botSuggestion,
        ));
      } else {
        _add(_createMessage().copyWith(
            isBot: true,
            botSuggestion: _sentenceList[_sentenceIndex].human,
            text: _sentenceList[_sentenceIndex].bot));
      }
      notifyListeners();
    }
  }

  bool _isSimilar(String a, String b) {
    double result = StringSimilarity.compareTwoStrings(a, b);
    return result > 0.8;
  }

  bool get isBotTyping => _isBotTyping;

  bool get humanCanSend =>
      !conversationEnded &&
      (messages.isNotEmpty ? (messages.last.isBot ?? false) : false);

  List<Message> get messages =>
      (_messagesByConversation[conversation.id] ?? []).toList();

  bool get conversationEnded => _conversationEnded;
}
