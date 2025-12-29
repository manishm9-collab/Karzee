import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

// Pehle se bani hui files ke imports
import 'login.dart';
import 'signup.dart';
import 'post_project.dart';
import 'jobs.dart';
import 'freelancer_dashboard.dart';
import 'explore.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  // Role Toggle
  bool isClientMode = true;

  // --- GEMINI AI STATE VARIABLES ---
  String _aiDecision = "Click 'Analyze Match' to let Karzee AI find the perfect fit.";
  bool _isLoadingAI = false;
  bool _showAiResult = false;

  // --- 1. BACKEND AI MATCHING FUNCTION ---
  Future<void> getAIMatch() async {
    // 🔍 DEBUG PRINT - Yeh aapke terminal mein dikhna chahiye
    print("AI BUTTON CLICKED");

    setState(() {
      _isLoadingAI = true;
      _showAiResult = true;
      _aiDecision = "Karzee AI is analyzing profiles...";
    });

    try {
      // ⚠️ UPDATE: Port 5001 use kar rahe hain jaisa aapne bataya
      const String apiUrl = "http://localhost:5001/api/ai/match"; 

      print("Sending request to: $apiUrl");

      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
        },
        body: jsonEncode({
          "taskDetails": "Need a Senior Flutter Developer for a fintech app. Must handle state management (Riverpod/Bloc) and clean architecture.",
          "freelancerProfile": "Name: Rahul Sharma, Skills: Flutter, Firebase, Dart, Node.js. Experience: 3 Years.",
        }),
      );

      print("HTTP Status Code: ${response.statusCode}");
      print("Raw Response Body: ${response.body}");

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        
        // Backend keys ke hisab se adjust kiya hai (recommendation ya decision)
        String resultText = data['recommendation'] ?? data['decision'] ?? "AI processed successfully.";
        
        print("AI Response Success: $resultText");
        
        setState(() {
          _aiDecision = resultText;
          _isLoadingAI = false;
        });
      } else {
        print("AI API Error: Status ${response.statusCode} - ${response.body}");
        setState(() {
          _aiDecision = "Backend Error: Status ${response.statusCode}. Check if Gemini API Key is active.";
          _isLoadingAI = false;
        });
      }
    } catch (e) {
      print("CONNECTION ERROR: $e");
      setState(() {
        _aiDecision = "Connection Failed. Ensure Node.js is running on Port 5001 and check Network Tab.";
        _isLoadingAI = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        toolbarHeight: 75,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'karzee',
              style: TextStyle(
                color: Color(0xFF0F6B4A),
                fontSize: 26,
                fontWeight: FontWeight.bold,
                letterSpacing: -1,
              ),
            ),
            Text(
              isClientMode ? "Hiring Mode" : "Working Mode",
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            )
          ],
        ),
        actions: [
          Row(
            children: [
              Icon(
                isClientMode ? Icons.business : Icons.person_search,
                size: 18,
                color: const Color(0xFF0F6B4A),
              ),
              Switch(
                value: isClientMode,
                activeColor: const Color(0xFF0F6B4A),
                onChanged: (value) {
                  setState(() {
                    isClientMode = value;
                  });
                },
              ),
            ],
          ),
          _navItem(context, 'Explore'),
          const SizedBox(width: 5),
          IconButton(
            icon: const CircleAvatar(
              radius: 16,
              backgroundColor: Color(0xFF0F6B4A),
              child: Icon(Icons.person, size: 20, color: Colors.white),
            ),
            onPressed: () => Navigator.pushNamed(context, '/profile'),
          ),
          const SizedBox(width: 15),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeroSection(context),

            // AI Smart Section
            if (isClientMode) _buildGeminiSection(),

            // Dynamic Dashboard Sections
            isClientMode ? _buildClientDashboard(context) : _buildFreelancerDashboard(context),

            const SizedBox(height: 30),

            // Popular Categories Section
            const Padding(
              padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
              child: Text('Popular Categories',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            ),
            _buildCategoryList(),

            // Top Professionals Section
            const Padding(
              padding: EdgeInsets.fromLTRB(20, 30, 20, 20),
              child: Text('Top Rated Professionals',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            ),
            _buildFreelancerList(),

            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  // --- UI COMPONENTS ---

  Widget _buildGeminiSection() {
    return Container(
      margin: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 15,
            offset: const Offset(0, 5),
          )
        ],
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            decoration: const BoxDecoration(
              color: Color(0xFF0F6B4A),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: const Row(
              children: [
                Icon(Icons.auto_awesome, color: Colors.amber, size: 20),
                SizedBox(width: 10),
                Text(
                  "Karzee AI Smart-Match",
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Analyze if the candidate matches your project requirements.",
                  style: TextStyle(fontSize: 14, color: Colors.black87),
                ),
                const SizedBox(height: 15),
                if (_showAiResult)
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade50,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey.shade200),
                    ),
                    child: _isLoadingAI
                        ? const Center(child: CircularProgressIndicator(color: Color(0xFF0F6B4A)))
                        : Text(
                            _aiDecision,
                            style: TextStyle(color: Colors.grey.shade800, height: 1.5),
                          ),
                  ),
                const SizedBox(height: 15),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: _isLoadingAI ? null : getAIMatch,
                    icon: const Icon(Icons.psychology),
                    label: const Text("Run AI Matchmaking"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF0F6B4A),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      padding: const EdgeInsets.symmetric(vertical: 12),
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

  Widget _buildHeroSection(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
      decoration: const BoxDecoration(
        color: Color(0xFF0F6B4A),
        borderRadius: BorderRadius.only(bottomRight: Radius.circular(50)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            isClientMode ? 'Hire the best\nexperts for any job.' : 'Find the best\ngigs and earn.',
            style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white, height: 1.1),
          ),
          const SizedBox(height: 15),
          const Text('Work with the largest network of independent professionals.',
              style: TextStyle(color: Colors.white70, fontSize: 16)),
          const SizedBox(height: 25),
          TextField(
            decoration: InputDecoration(
              hintText: isClientMode ? 'Try "Web Developer"' : 'Try "Logo Design Jobs"',
              filled: true,
              fillColor: Colors.white,
              prefixIcon: const Icon(Icons.search, color: Colors.grey),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildClientDashboard(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Employer Tools", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 15),
          _quickActionCard(
              context,
              "Post a New Job",
              "Get proposals from top talent",
              Icons.add_circle,
              const Color(0xFF0F6B4A),
              () => Navigator.push(context, MaterialPageRoute(builder: (context) => const PostProjectPage()))),
          _quickActionCard(context, "Manage Your Posts", "Review applicants and hires", Icons.list_alt, Colors.black87, () {}),
        ],
      ),
    );
  }

  Widget _buildFreelancerDashboard(BuildContext context) {
    return Column(
      children: [
        _buildStatsBar(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Freelancer Tools", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 15),
              _quickActionCard(
                  context,
                  "Browse Available Jobs",
                  "Apply and start earning XP",
                  Icons.search,
                  const Color(0xFF0F6B4A),
                  () => Navigator.push(context, MaterialPageRoute(builder: (context) => const JobsPage()))),
              _quickActionCard(context, "My Active Proposals", "Check your status", Icons.send, Colors.blue, () {}),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCategoryList() {
    return SizedBox(
      height: 120,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 15),
        children: [
          _categoryCard(Icons.code, 'Development'),
          _categoryCard(Icons.brush, 'Design'),
          _categoryCard(Icons.campaign, 'Marketing'),
          _categoryCard(Icons.edit, 'Writing'),
          _categoryCard(Icons.videocam, 'Video'),
        ],
      ),
    );
  }

  Widget _categoryCard(IconData icon, String title) {
    return Container(
      width: 110,
      margin: const EdgeInsets.only(right: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: const Color(0xFF0F6B4A), size: 30),
          const SizedBox(height: 8),
          Text(title, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }

  Widget _quickActionCard(BuildContext context, String title, String sub, IconData icon, Color color, VoidCallback onTap) {
    return Card(
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
        side: BorderSide(color: Colors.grey.shade200),
      ),
      child: ListTile(
        onTap: onTap,
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        leading: CircleAvatar(
          backgroundColor: color.withOpacity(0.1),
          child: Icon(icon, color: color),
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(sub, style: const TextStyle(fontSize: 12)),
        trailing: const Icon(Icons.arrow_forward_ios, size: 14, color: Colors.grey),
      ),
    );
  }

  Widget _buildStatsBar() {
    return Container(
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10)],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _statItem('4.9/5', 'Rating'),
          _statItem('Level 5', 'Rank'),
          _statItem('750 XP', 'Progress'),
        ],
      ),
    );
  }

  Widget _statItem(String value, String label) {
    return Column(
      children: [
        Text(value, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF0F6B4A))),
        Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey)),
      ],
    );
  }

  Widget _buildFreelancerList() {
    return SizedBox(
      height: 180,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.only(left: 20),
        itemCount: 5,
        itemBuilder: (context, index) {
          return Container(
            width: 150,
            margin: const EdgeInsets.only(right: 15),
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.grey.shade200),
            ),
            child: Column(
              children: [
                const CircleAvatar(radius: 30, backgroundImage: NetworkImage('https://i.pravatar.cc/150?u=karzee')),
                const SizedBox(height: 10),
                const Text('Alex Rivera', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                const Text('UI/UX Designer', style: TextStyle(fontSize: 11, color: Colors.grey)),
                const SizedBox(height: 5),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.star, color: Colors.amber, size: 12),
                    Text(' 4.9', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
                  ],
                )
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _navItem(BuildContext context, String text) {
    return TextButton(
      onPressed: () {
        if (text == 'Explore') Navigator.push(context, MaterialPageRoute(builder: (context) => const ExplorePage()));
      },
      child: Text(text, style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w500)),
    );
  }
}