import 'package:flutter/material.dart';

class LanguageScreen extends StatefulWidget {

  const LanguageScreen({
    super.key,
  });

  @override
  State<LanguageScreen>
      createState() =>
          _LanguageScreenState();
}

class _LanguageScreenState
    extends State<LanguageScreen> {

  String selectedLanguage =
      "English";

  @override
  Widget build(BuildContext context) {

    final List<String> languages = [

      "English",
      "తెలుగు",
      "हिन्दी",
      "தமிழ்",

    ];

    return Scaffold(

      appBar: AppBar(
        title:
            const Text("Select Language"),
        backgroundColor: Colors.green,
      ),

      body: Padding(
        padding:
            const EdgeInsets.all(20),

        child: Column(

          crossAxisAlignment:
              CrossAxisAlignment.start,

          children: [

            const Text(
              "Choose Your Language",

              style: TextStyle(
                fontSize: 24,
                fontWeight:
                    FontWeight.bold,
                color: Colors.green,
              ),
            ),

            const SizedBox(height: 25),

            Expanded(

              child: ListView.builder(

                itemCount:
                    languages.length,

                itemBuilder:
                    (context, index) {

                  final language =
                      languages[index];

                  return Card(

                    margin:
                        const EdgeInsets.only(
                      bottom: 15,
                    ),

                    child: RadioListTile(

                      activeColor:
                          Colors.green,

                      title: Text(
                        language,

                        style:
                            const TextStyle(
                          fontSize: 20,
                        ),
                      ),

                      value: language,

                      groupValue:
                          selectedLanguage,

                      onChanged: (value) {

                        setState(() {

                          selectedLanguage =
                              value.toString();

                        });

                        ScaffoldMessenger.of(
                          context,
                        ).showSnackBar(

                          SnackBar(

                            content: Text(
                              "$selectedLanguage selected",
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ),

          ],
        ),
      ),
    );
  }
}