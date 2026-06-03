import 'package:flutter/material.dart';
import '../services/api_service.dart';


class ChatbotScreen extends StatefulWidget {
  const ChatbotScreen({super.key});

  @override
  State<ChatbotScreen> createState() =>
      _ChatbotScreenState();
}

class _ChatbotScreenState
    extends State<ChatbotScreen> {

  final TextEditingController messageController =
      TextEditingController();

  List<Map<String, String>> messages = [];

  void sendMessage() {

    String userMessage =
        messageController.text.trim();

    if (userMessage.isEmpty) return;

    setState(() {

      messages.add({
        "sender": "user",
        "message": userMessage,
      });

      String botReply = getBotReply(userMessage);

      messages.add({
        "sender": "bot",
        "message": botReply,
      });

    });

    messageController.clear();
  }

  String getBotReply(String message) {

    message = message.toLowerCase();

    if (message.contains("rice")) {

      return "Rice grows well in wet and humid climate.";

    } else if (message.contains("fertilizer")) {

      return "Organic fertilizers improve soil fertility.";

    } else if (message.contains("weather")) {

      return "Check weather alerts regularly before irrigation.";

    } else {

      return "I am your farming assistant 🌾";
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text("AI Chatbot"),
        backgroundColor: Colors.green,
      ),

      body: Column(

        children: [

          Expanded(

            child: ListView.builder(

              padding: const EdgeInsets.all(12),

              itemCount: messages.length,

              itemBuilder: (context, index) {

                final message = messages[index];

                bool isUser =
                    message["sender"] == "user";

                return Align(

                  alignment: isUser
                      ? Alignment.centerRight
                      : Alignment.centerLeft,

                  child: Container(

                    margin: const EdgeInsets.symmetric(
                      vertical: 6,
                    ),

                    padding: const EdgeInsets.all(14),

                    decoration: BoxDecoration(

                      color: isUser
                          ? Colors.green
                          : Colors.grey.shade300,

                      borderRadius:
                          BorderRadius.circular(15),
                    ),

                    child: Text(

                      message["message"]!,

                      style: TextStyle(

                        color: isUser
                            ? Colors.white
                            : Colors.black,

                        fontSize: 16,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          Container(

            padding: const EdgeInsets.all(10),

            child: Row(

              children: [

                Expanded(

                  child: TextField(
                    controller: messageController,

                    decoration: InputDecoration(

                      hintText:
                          "Ask farming questions...",

                      border: OutlineInputBorder(
                        borderRadius:
                            BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),

                const SizedBox(width: 10),

                CircleAvatar(

                  backgroundColor: Colors.green,

                  child: IconButton(

                    onPressed: sendMessage,

                    icon: const Icon(
                      Icons.send,
                      color: Colors.white,
                    ),
                  ),
                ),

              ],
            ),
          ),

        ],
      ),
    );
  }
}