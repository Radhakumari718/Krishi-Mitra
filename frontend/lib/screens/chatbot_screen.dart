import 'package:flutter/material.dart';

class ChatbotScreen extends StatefulWidget {
  const ChatbotScreen({super.key});
  @override
  State<ChatbotScreen> createState() => _ChatbotScreenState();
}

class _ChatbotScreenState extends State<ChatbotScreen> {
  final messageController = TextEditingController();
  final scrollController = ScrollController();
  List<Map<String, String>> messages = [
    {'sender': 'bot', 'message': 'Hi! I am your farming assistant 🌾. Ask me about crops, fertilizers, or weather.'},
  ];

  void sendMessage() {
    final userMessage = messageController.text.trim();
    if (userMessage.isEmpty) return;
    setState(() {
      messages.add({'sender': 'user', 'message': userMessage});
      messages.add({'sender': 'bot', 'message': getBotReply(userMessage)});
    });
    messageController.clear();
    Future.delayed(const Duration(milliseconds: 100), () {
      if (scrollController.hasClients) {
        scrollController.animateTo(scrollController.position.maxScrollExtent, duration: const Duration(milliseconds: 300), curve: Curves.easeOut);
      }
    });
  }

  String getBotReply(String message) {
    message = message.toLowerCase();
    if (message.contains('rice')) return 'Rice grows well in wet and humid climate with standing water.';
    if (message.contains('fertilizer')) return 'Organic fertilizers like compost and vermicompost improve soil fertility naturally.';
    if (message.contains('weather')) return 'Check the Weather screen for live forecasts before irrigation or harvesting.';
    if (message.contains('price')) return 'Use the Price tracker in your dashboard to check current market rates.';
    if (message.contains('disease') || message.contains('pest')) return 'Try the Disease check tool — upload a leaf photo and I will help identify issues.';
    return 'I am your farming assistant 🌾. Try asking about crops, fertilizers, weather, or prices.';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F3F5),
      appBar: AppBar(
        title: const Text('AI Chatbot'),
        backgroundColor: const Color(0xFF1a6b2e),
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: scrollController,
              padding: const EdgeInsets.all(14),
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final message = messages[index];
                final isUser = message['sender'] == 'user';
                return Align(
                  alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                    constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.75),
                    decoration: BoxDecoration(
                      color: isUser ? const Color(0xFF1a6b2e) : Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: isUser ? null : [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 4)],
                    ),
                    child: Text(message['message']!, style: TextStyle(color: isUser ? Colors.white : Colors.black87, fontSize: 14)),
                  ),
                );
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(14, 10, 14, 16),
            decoration: BoxDecoration(color: Colors.white, boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.06), blurRadius: 8, offset: const Offset(0, -2))]),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: messageController,
                    onSubmitted: (_) => sendMessage(),
                    decoration: InputDecoration(
                      hintText: 'Ask farming questions...',
                      filled: true,
                      fillColor: const Color(0xFFF5F5F5),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(24), borderSide: BorderSide.none),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                CircleAvatar(
                  backgroundColor: const Color(0xFF1a6b2e),
                  child: IconButton(onPressed: sendMessage, icon: const Icon(Icons.send, color: Colors.white, size: 18)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
