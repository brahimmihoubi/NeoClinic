import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:neoclinic/controllers/chatdetailscontroller.dart';
import '../models/message_model.dart';

class ChatDetailScreen extends StatelessWidget {
  final ChatDetailController controller = Get.put(ChatDetailController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Row(
          children: [
            CircleAvatar(
              backgroundImage: AssetImage('assets/images/doctor1.png'),
            ),
            SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text('Dr. Hachani', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                Text('Neurologist', style: TextStyle(fontSize: 12)),
              ],
            ),
          ],
        ),
        backgroundColor: Color(0xFF3D5AFE),
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Expanded(
            child: Obx(() => ListView.builder(
                  padding: EdgeInsets.all(16),
                  itemCount: controller.messages.length,
                  itemBuilder: (context, index) {
                    final message = controller.messages[index];
                    return MessageBubble(message: message);
                  },
                )),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: [
                Expanded(
                  child: Obx(() => TextField(
                        onChanged: (value) => controller.inputMessage.value = value,
                        controller: TextEditingController(text: controller.inputMessage.value)
                          ..selection = TextSelection.fromPosition(
                            TextPosition(offset: controller.inputMessage.value.length),
                          ),
                        decoration: InputDecoration(
                          hintText: 'Type a message',
                          filled: true,
                          fillColor: Colors.grey[100],
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(24),
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        ),
                      )),
                ),
                SizedBox(width: 8),
                GestureDetector(
                  onTap: controller.sendMessage,
                  child: CircleAvatar(
                    backgroundColor: Color(0xFF3D5AFE),
                    child: Icon(Icons.send, color: Colors.white),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 2,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.calendar_today), label: 'Schedule'),
          BottomNavigationBarItem(icon: Icon(Icons.chat_bubble), label: 'Messages'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}

class MessageBubble extends StatelessWidget {
  final MessageModel message;

  const MessageBubble({required this.message});

  @override
  Widget build(BuildContext context) {
    final alignment = message.isSentByUser ? CrossAxisAlignment.end : CrossAxisAlignment.start;
    final bubbleColor = message.isSentByUser ? Colors.green[300] : Colors.blue[300];
    final textAlign = message.isSentByUser ? TextAlign.right : TextAlign.left;
    final margin = message.isSentByUser
        ? EdgeInsets.only(left: 50, bottom: 12)
        : EdgeInsets.only(right: 50, bottom: 12);

    return Column(
      crossAxisAlignment: alignment,
      children: [
        Container(
          margin: margin,
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: bubbleColor,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Text(
            message.content,
            style: TextStyle(color: Colors.white),
            textAlign: textAlign,
          ),
        ),
        Padding(
          padding: margin,
          child: Text(
            _formatTime(message.timestamp),
            style: TextStyle(fontSize: 10, color: Colors.grey[600]),
          ),
        )
      ],
    );
  }

  String _formatTime(DateTime time) {
    return '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
  }
}
