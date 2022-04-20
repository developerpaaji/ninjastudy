import 'package:study/client.dart';
import 'package:study/models/conversation.dart';
import 'package:study/models/response.dart';
import 'package:study/services/base.dart';
import 'package:study/services/error_handler.dart';
import 'package:uuid/uuid.dart';

typedef ConversationResponse = ApiResponse<Conversation>;

abstract class ConversationService extends BaseService {
  ConversationService([ErrorHandler? errorHandler]) : super(errorHandler);
  Future<ConversationResponse> createConversation(ConversationTopic topic);
}

class ConversationMockService extends ConversationService {
  @override
  Future<ConversationResponse> createConversation(
      ConversationTopic topic) async {
    return ApiResponse(
        data: Conversation(
            id: "1",
            topic: topic,
            createdAt: DateTime.now(),
            sentences: [
          ConversationSentence(bot: "Hello", human: "How are you"),
          ConversationSentence(bot: "I am fine", human: "Awesome"),
        ]));
  }
}

class ConversationApiService extends ConversationService {
  final ApiClient client;
  ConversationApiService(this.client, ErrorHandler? errorHandler)
      : super(errorHandler);

  @override
  Future<ConversationResponse> createConversation(
      ConversationTopic topic) async {
    try {
      final response = await client.get("/tryninjastudy/dummyapi/db");
      String id = const Uuid().v4();
      final results =
          List.from(response.data[topic.name] ?? response.data["restaurant"])
              .map<ConversationSentence>(
                  (itemJson) => ConversationSentence.fromJson(itemJson))
              .toList();
      Conversation conversation = Conversation(
        id: id,
        createdAt: DateTime.now(),
        topic: topic,
        sentences: results,
      );
      return ApiResponse(data: conversation);
    } catch (e) {
      errorHandler?.recordError(e);
      return ApiResponse(error: e);
    }
  }
}
