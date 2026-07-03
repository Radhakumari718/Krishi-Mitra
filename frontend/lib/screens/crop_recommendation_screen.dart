import 'package:flutter/material.dart';
import '../services/api_service.dart';

class CropRecommendationScreen extends StatefulWidget {
  const CropRecommendationScreen({super.key});
  @override
  State<CropRecommendationScreen> createState() => _CropRecommendationScreenState();
}

class _CropRecommendationScreenState extends State<CropRecommendationScreen> {
  final nController = TextEditingController();
  final pController = TextEditingController();
  final kController = TextEditingController();
  final temperatureController = TextEditingController();
  final humidityController = TextEditingController();
  final phController = TextEditingController();
  final rainfallController = TextEditingController();

  String result = '';
  bool isLoading = false;

  Future<void> recommendCrop() async {
    setState(() => isLoading = true);
    final n = double.tryParse(nController.text) ?? 0;
    final p = double.tryParse(pController.text) ?? 0;
    final k = double.tryParse(kController.text) ?? 0;
    final temperature = double.tryParse(temperatureController.text) ?? 0;
    final humidity = double.tryParse(humidityController.text) ?? 0;
    final ph = double.tryParse(phController.text) ?? 0;
    final rainfall = double.tryParse(rainfallController.text) ?? 0;

    try {
      final crop = await ApiService.recommendCrop(n, p, k, temperature, humidity, ph, rainfall);
      setState(() => result = crop);
    } catch (e) {
      setState(() => result = 'Could not fetch recommendation. Check your connection.');
    } finally {
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F3F5),
      appBar: AppBar(
        title: const Text('AI Crop Recommendation'),
        backgroundColor: const Color(0xFF1a6b2e),
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 6)]),
              child: Column(
                children: [
                  const Row(children: [
                    Icon(Icons.science_outlined, color: Color(0xFF1a6b2e)),
                    SizedBox(width: 8),
                    Text('Enter soil & climate data', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                  ]),
                  const SizedBox(height: 16),
                  Row(children: [
                    Expanded(child: _field(nController, 'Nitrogen (N)')),
                    const SizedBox(width: 10),
                    Expanded(child: _field(pController, 'Phosphorus (P)')),
                  ]),
                  const SizedBox(height: 12),
                  Row(children: [
                    Expanded(child: _field(kController, 'Potassium (K)')),
                    const SizedBox(width: 10),
                    Expanded(child: _field(phController, 'pH level')),
                  ]),
                  const SizedBox(height: 12),
                  Row(children: [
                    Expanded(child: _field(temperatureController, 'Temperature °C')),
                    const SizedBox(width: 10),
                    Expanded(child: _field(humidityController, 'Humidity %')),
                  ]),
                  const SizedBox(height: 12),
                  _field(rainfallController, 'Rainfall (mm)'),
                ],
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                onPressed: isLoading ? null : recommendCrop,
                style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF1a6b2e), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
                child: isLoading
                    ? const SizedBox(width: 22, height: 22, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
                    : const Text('Recommend crop', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600)),
              ),
            ),
            if (result.isNotEmpty) ...[
              const SizedBox(height: 24),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(color: const Color(0xFFE8F5E9), borderRadius: BorderRadius.circular(14), border: Border.all(color: const Color(0xFF1a6b2e).withOpacity(0.3))),
                child: Column(children: [
                  const Icon(Icons.eco, color: Color(0xFF1a6b2e), size: 32),
                  const SizedBox(height: 10),
                  const Text('Recommended crop', style: TextStyle(fontSize: 13, color: Colors.grey)),
                  const SizedBox(height: 4),
                  Text(result, textAlign: TextAlign.center, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xFF1a6b2e))),
                ]),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _field(TextEditingController controller, String label) {
    return TextField(
      controller: controller,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: label,
        filled: true,
        fillColor: const Color(0xFFF5F5F5),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none),
      ),
    );
  }
}
