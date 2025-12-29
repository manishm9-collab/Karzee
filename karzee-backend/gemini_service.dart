import 'package:google_generative_ai/google_generative_ai.dart';

class KarzeeAIService {
  // 1. Yahan apni EKDOM FRESH API Key paste kar
  final String _apiKey = "AIzaSyDIe9GD-FijMDf1ZmC4BX0eTAXOxw3-S8M"; 

  Future<String> getTaskRecommendation({
    required String taskDetails,
    required String freelancerProfile,
  }) async {
    // 2. Model name bilkul yahi hona chahiye
    final model = GenerativeModel(
      model: 'gemini-1.5-flash-latest',
      apiKey: _apiKey,
    );

    final prompt = """
    System: You are the Karzee Project Manager AI. 
    Analyze if this freelancer is the right fit for the task.
    Task Details: $taskDetails
    Freelancer Profile: $freelancerProfile
    Instruction: Give decision (Match/No Match) and a 2-line reason.
    """;

    try {
      final content = [Content.text(prompt)];
      final response = await model.generateContent(content);
      
      if (response.text == null || response.text!.isEmpty) {
        return "AI: Response received but it was empty.";
      }
      return response.text!;
      
    } catch (e) {
      // 3. Ye print terminal mein check kar jab error aaye
      print("DEBUG: Gemini API Error -> $e");
      
      if (e.toString().contains('404')) {
        return "AI Error (404): Model not found or API Key is invalid.";
      } else if (e.toString().contains('403')) {
        return "AI Error (403): API Key permission denied. Check Google AI Studio.";
      }
      return "AI Connection Error: Check your internet or API Key.";
    }
  }
}