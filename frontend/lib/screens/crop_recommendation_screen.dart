import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class CropRecommendationScreen extends StatefulWidget {
  const CropRecommendationScreen({super.key});

  @override
  State<CropRecommendationScreen> createState() =>
      _CropRecommendationScreenState();
}

class _CropRecommendationScreenState
    extends State<CropRecommendationScreen> {

  final TextEditingController soilController   = TextEditingController();
  final TextEditingController seasonController  = TextEditingController();
  final TextEditingController waterController   = TextEditingController();

  String result  = "";
  bool   loading = false;

  // Supabase client
  final supabase = Supabase.instance.client;

  // Crop recommendation logic
  String getCrop(String soil, String season, String water) {
    if (soil == "black"  && season == "winter" && water == "high")  return "Wheat";
    if (soil == "red"    && season == "summer")                      return "Groundnut";
    if (soil == "sandy"  && season == "summer" && water == "low")   return "Groundnut";
    if (soil == "loamy"  && season == "kharif" && water == "high")  return "Rice";
    if (soil == "black"  && season == "rabi"   && water == "medium")return "Wheat";
    if (soil == "red"    && season == "kharif" && water == "medium")return "Cotton";
    if (soil == "clay"   && season == "rabi"   && water == "high")  return "Sugarcane";
    return "Rice"; // default
  }

  Future<void> recommendCrop() async {
    String soil   = soilController.text.trim().toLowerCase();
    String season = seasonController.text.trim().toLowerCase();
    String water  = waterController.text.trim().toLowerCase();

    // Validation
    if (soil.isEmpty || season.isEmpty || water.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('అన్ని fields fill చేయండి!'),
        backgroundColor: Colors.red),
      );
      return;
    }

    setState(() => loading = true);

    try {
      String recommendedCrop = getCrop(soil, season, water);

      // Save to Supabase database
      await supabase.from('crop_recommendations').insert({
        'user_id'           : supabase.auth.currentUser!.id,
        'soil_type'         : soil,
        'season'            : season,
        'water_availability': water,
        'recommended_crop'  : recommendedCrop,
      });

      setState(() {
        result  = "Recommended Crop: $recommendedCrop";
        loading = false;
      });

    } catch (e) {
      setState(() => loading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e'),
        backgroundColor: Colors.red),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Crop Recommendation"),
        backgroundColor: Colors.green,
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [

            TextField(
              controller: soilController,
              decoration: const InputDecoration(
                labelText: "Soil Type (e.g. Black, Red, Loamy)",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 20),

            TextField(
              controller: seasonController,
              decoration: const InputDecoration(
                labelText: "Season (e.g. Winter, Summer, Kharif)",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 20),

            TextField(
              controller: waterController,
              decoration: const InputDecoration(
                labelText: "Water Availability (High, Medium, Low)",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 30),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: loading ? null : recommendCrop,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: const EdgeInsets.all(15),
                ),
                child: loading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text(
                        "Recommend Crop",
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
              ),
            ),

            const SizedBox(height: 30),

            if (result.isNotEmpty)
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.green.shade50,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.green),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.eco, color: Colors.green, size: 30),
                    const SizedBox(width: 12),
                    Text(
                      result,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                  ],
                ),
              ),

          ],
        ),
      ),
    );
  }
}
