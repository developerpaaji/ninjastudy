import 'package:study/client.dart';
import 'package:study/models/conversation.dart';
import 'package:study/models/response.dart';
import 'package:study/services/base.dart';
import 'package:study/services/error_handler.dart';
import 'package:uuid/uuid.dart';

typedef ConversationResponse = ApiResponse<Conversation>;

class ConversationService extends BaseService {
  final ApiClient client;
  ConversationService(this.client, ErrorHandler? errorHandler)
      : super(errorHandler);

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
