import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ChatbotScreen extends StatefulWidget {
  const ChatbotScreen({super.key});

  @override
  State<ChatbotScreen> createState() => _ChatbotScreenState();
}

class _ChatbotScreenState extends State<ChatbotScreen> {
  final supabase          = Supabase.instance.client;
  final messageController = TextEditingController();
  final scrollController  = ScrollController();

  // ✅ Groq API Key
  final String groqApiKey = dotenv.env['GROQ_API_KEY'] ?? '';
  List<Map<String, String>> messages = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    fetchHistory();
  }

  Future<void> fetchHistory() async {
    try {
      final userId = supabase.auth.currentUser!.id;
      final data   = await supabase
          .from('chatbot_history')
          .select()
          .eq('user_id', userId)
          .order('asked_at', ascending: true)
          .limit(20);

      setState(() {
        for (var item in data) {
          messages.add({'role': 'user',      'text': item['question']});
          messages.add({'role': 'assistant', 'text': item['answer']});
        }
      });
    } catch (e) {
      print('History fetch error: $e');
    }
  }

  // ✅ Groq API Call (replaces Gemini)
  Future<String> getAIResponse(String question) async {
    final url = Uri.parse('https://api.groq.com/openai/v1/chat/completions');

    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $groqApiKey', // ✅ Groq Auth
      },
      body: jsonEncode({
        'model': 'llama-3.3-70b-versatile', // ✅ Free Groq Model
        'messages': [
          {
  'role': 'system',
  'content': 'You are Krishi Mithra, an AI assistant for Indian farmers. '
      'IMPORTANT: Always detect the language of the user question and reply '
      'in the SAME language. If they ask in Telugu, reply in Telugu. '
      'If they ask in English, reply in English. '
      'If they ask in Tenglish mix, reply in Tenglish. '
      'Keep answers short and practical for farmers.'
},
          {
            'role': 'user',
            'content': question
          }
        ],
        'max_tokens': 500,
        'temperature': 0.7,
      }),
    );

    print('Groq Status: ${response.statusCode}');
    print('Groq Response: ${response.body}');

    final jsonData = jsonDecode(response.body);

    if (response.statusCode != 200) {
      throw Exception('API Error: ${jsonData['error']['message']}');
    }

    return jsonData['choices'][0]['message']['content'];
  }

  Future<void> sendMessage() async {
    if (messageController.text.trim().isEmpty) return;

    final question = messageController.text.trim();
    messageController.clear();

    setState(() {
      messages.add({'role': 'user', 'text': question});
      isLoading = true;
    });

    scrollToBottom();

    try {
      final answer = await getAIResponse(question);

      setState(() {
        messages.add({'role': 'assistant', 'text': answer});
        isLoading = false;
      });

      await supabase.from('chatbot_history').insert({
        'user_id' : supabase.auth.currentUser!.id,
        'question': question,
        'answer'  : answer,
      });

      scrollToBottom();

    } catch (e) {
      print('Send message error: $e');
      setState(() {
        messages.add({
          'role': 'assistant',
          'text': 'Error: $e'
        });
        isLoading = false;
      });
    }
  }

  void scrollToBottom() {
    Future.delayed(const Duration(milliseconds: 300), () {
      if (scrollController.hasClients) {
        scrollController.animateTo(
          scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("AI Chatbot 🌾"),
        backgroundColor: Colors.green,
      ),

      body: Column(
        children: [

          Expanded(
            child: messages.isEmpty
                ? const Center(
                    child: Text(
                      '🌾 Farming questions adugandi!\nTelugu or English lo ask cheyochu.',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  )
                : ListView.builder(
                    controller: scrollController,
                    padding: const EdgeInsets.all(10),
                    itemCount: messages.length,
                    itemBuilder: (context, index) {
                      final msg    = messages[index];
                      final isUser = msg['role'] == 'user';

                      return Align(
                        alignment: isUser
                            ? Alignment.centerRight
                            : Alignment.centerLeft,
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 10),
                          padding: const EdgeInsets.all(15),
                          constraints: BoxConstraints(
                            maxWidth: MediaQuery.of(context).size.width * 0.75,
                          ),
                          decoration: BoxDecoration(
                            color: isUser
                                ? Colors.green
                                : Colors.green.shade50,
                            borderRadius: BorderRadius.circular(15),
                            border: isUser
                                ? null
                                : Border.all(color: Colors.green.shade200),
                          ),
                          child: Text(
                            msg['text'] ?? '',
                            style: TextStyle(
                              fontSize: 16,
                              color: isUser ? Colors.white : Colors.black87,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
          ),

          if (isLoading)
            const Padding(
              padding: EdgeInsets.all(8),
              child: Row(
                children: [
                  SizedBox(width: 10),
                  SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Colors.green,
                    ),
                  ),
                  SizedBox(width: 10),
                  Text(
                    'Krishi Mithra thinking...',
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
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
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 10,
                      ),
                    ),
                    onSubmitted: (_) => sendMessage(),
                  ),
                ),
                const SizedBox(width: 10),
                CircleAvatar(
                  backgroundColor: Colors.green,
                  child: IconButton(
                    onPressed: isLoading ? null : sendMessage,
                    icon: const Icon(Icons.send, color: Colors.white),
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