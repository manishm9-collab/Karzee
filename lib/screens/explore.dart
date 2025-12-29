import 'package:flutter/material.dart';

class ExplorePage extends StatefulWidget {
  const ExplorePage({super.key});

  @override
  State<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  // Data structure for your massive list
  final List<Map<String, dynamic>> categories = [
    {
      "title": "Graphics & Design",
      "icon": Icons.brush,
      "sub": ["Logo Design", "Brand Identity", "Web & App Design", "Art & Illustration", "Marketing Design", "Packaging & Covers", "Visual Design"]
    },
    {
      "title": "Digital Marketing",
      "icon": Icons.campaign,
      "sub": ["Social Media Marketing", "SEO", "Paid Advertising", "Content Marketing", "Email Marketing", "Analytics & Strategy"]
    },
    {
      "title": "Writing & Translation",
      "icon": Icons.edit_note,
      "sub": ["Articles & Blog Posts", "Copywriting", "Translation", "Transcription", "Proofreading", "Resume Editing"]
    },
    {
      "title": "Video & Animation",
      "icon": Icons.videocam,
      "sub": ["Video Editing", "2D/3D Animation", "Motion Graphics", "Explainer Videos", "Drone Videography"]
    },
    {
      "title": "Programming & Tech",
      "icon": Icons.code,
      "sub": ["Web Development", "Mobile Apps", "AI & Data", "Cybersecurity", "Cloud & DevOps", "APIs"]
    },
    {
      "title": "Business",
      "icon": Icons.business_center,
      "sub": ["Consulting", "Finance", "Legal", "Operations", "Project Management"]
    },
    {
      "title": "AI Services",
      "icon": Icons.psychology,
      "sub": ["AI Development", "AI Chatbots", "LLM Fine-Tuning", "AI Image Generation", "AI Automation"]
    },
    {
      "title": "Architecture & Engineering",
      "icon": Icons.architecture,
      "sub": ["Floor Plans", "3D Modeling", "Interior Design", "Electrical Design", "CAD Drawings"]
    },
    // ... You can add more from your list here
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Explore Categories', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search for any service...',
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.grey.shade100,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: categories.length,
              itemBuilder: (context, index) {
                final cat = categories[index];
                return ExpansionTile(
                  leading: Icon(cat['icon'], color: const Color(0xFF0F6B4A)),
                  title: Text(cat['title'], style: const TextStyle(fontWeight: FontWeight.bold)),
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      child: Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: (cat['sub'] as List<String>).map((subName) {
                          return ActionChip(
                            label: Text(subName),
                            onPressed: () {
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Finding $subName...')));
                            },
                            backgroundColor: Colors.grey.shade50,
                            labelStyle: const TextStyle(fontSize: 12, color: Colors.black87),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}