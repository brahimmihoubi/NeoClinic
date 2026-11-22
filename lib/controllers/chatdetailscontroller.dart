import 'package:get/get.dart';
import 'package:neoclinic/models/message_model.dart';

class ChatDetailController extends GetxController {
  var messages = <MessageModel>[
    MessageModel(content: 'Hello, how can I assist you today?', timestamp: DateTime.now().subtract(Duration(minutes: 5)), isSentByUser: false),
    MessageModel(content: 'I have a question about my medication', timestamp: DateTime.now().subtract(Duration(minutes: 4)), isSentByUser: true),
    MessageModel(content: 'Sure, please provide me details.', timestamp: DateTime.now().subtract(Duration(minutes: 3)), isSentByUser: false),
  ].obs;

  var inputMessage = ''.obs;

  void sendMessage() {
    if (inputMessage.value.trim().isEmpty) return;

    messages.add(
      MessageModel(
        content: inputMessage.value,
        timestamp: DateTime.now(),
        isSentByUser: true,
      ),
    );
    inputMessage.value = '';
  }
}

