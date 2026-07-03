import 'package:flutter/material.dart';

class LanguageScreen extends StatefulWidget {
  const LanguageScreen({super.key});
  @override
  State<LanguageScreen> createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  String selectedLanguage = 'English';
  final languages = ['English', 'తెలుగు', 'हिन्दी', 'தமிழ்'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F3F5),
      appBar: AppBar(
        title: const Text('Select language'),
        backgroundColor: const Color(0xFF1a6b2e),
        foregroundColor: Colors.white,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(14),
        itemCount: languages.length,
        itemBuilder: (context, index) {
          final language = languages[index];
          final selected = selectedLanguage == language;
          return GestureDetector(
            onTap: () {
              setState(() => selectedLanguage = language);
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('$language selected'), backgroundColor: const Color(0xFF1a6b2e)));
            },
            child: Container(
              margin: const EdgeInsets.only(bottom: 10),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: selected ? const Color(0xFF1a6b2e) : Colors.transparent, width: 1.5),
                boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 6)],
              ),
              child: Row(children: [
                Expanded(child: Text(language, style: const TextStyle(fontSize: 16))),
                Icon(selected ? Icons.radio_button_checked : Icons.radio_button_off, color: selected ? const Color(0xFF1a6b2e) : Colors.grey),
              ]),
            ),
          );
        },
      ),
    );
  }
}
