import 'package:flutter/material.dart';

class LanguageScreen extends StatefulWidget {
  const LanguageScreen({super.key});

  @override
  State<LanguageScreen> createState() =>
      _LanguageScreenState();
}

class _LanguageScreenState
    extends State<LanguageScreen> {

  String selectedLanguage = "English";

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text("Select Language"),
        backgroundColor: Colors.green,
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: Column(

          crossAxisAlignment: CrossAxisAlignment.start,

          children: [

            const Text(
              "Choose Your Language",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 30),

            languageTile("English"),
            languageTile("తెలుగు"),
            languageTile("हिन्दी"),
            languageTile("தமிழ்"),

            const SizedBox(height: 30),

            Center(
              child: Text(
                "Selected: $selectedLanguage",

                style: const TextStyle(
                  fontSize: 20,
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget languageTile(String language) {

    return Card(
      elevation: 4,
      margin: const EdgeInsets.only(bottom: 15),

      child: RadioListTile(

        title: Text(
          language,
          style: const TextStyle(
            fontSize: 18,
          ),
        ),

        value: language,
        groupValue: selectedLanguage,

        activeColor: Colors.green,

        onChanged: (value) {

          setState(() {

            selectedLanguage = value.toString();

          });

        },
      ),
    );
  }
}