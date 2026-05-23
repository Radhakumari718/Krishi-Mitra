import 'package:flutter/material.dart';

class ChatbotScreen extends StatefulWidget {
  const ChatbotScreen({super.key});

  @override
  State<ChatbotScreen> createState() => _ChatbotScreenState();
}

class _ChatbotScreenState extends State<ChatbotScreen> {

  final TextEditingController messageController =
      TextEditingController();

  List<String> messages = [];

  void sendMessage() {

    if (messageController.text.isNotEmpty) {

      setState(() {

        messages.add(
          "Farmer: ${messageController.text}",
        );

        messages.add(
          "AI: कृषि मित्र is analyzing your question...",
        );

      });

      messageController.clear();
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

              itemCount: messages.length,

              itemBuilder: (context, index) {

                return Padding(
                  padding: const EdgeInsets.all(10),

                  child: Container(
                    padding: const EdgeInsets.all(15),

                    decoration: BoxDecoration(
                      color: Colors.green.shade100,
                      borderRadius: BorderRadius.circular(10),
                    ),

                    child: Text(
                      messages[index],
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(10),

            child: Row(

              children: [

                Expanded(
                  child: TextField(
                    controller: messageController,

                    decoration: InputDecoration(
                      hintText: "Ask farming question...",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),

                const SizedBox(width: 10),

                IconButton(
                  onPressed: sendMessage,

                  icon: const Icon(
                    Icons.send,
                    color: Colors.green,
                    size: 30,
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