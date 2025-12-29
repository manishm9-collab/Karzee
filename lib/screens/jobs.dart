import 'package:flutter/material.dart';

class JobsPage extends StatelessWidget {
  final String? filter; // Accepts the sub-category name from ExplorePage

  // Constructor updated with 'filter' and 'const'
  const JobsPage({super.key, this.filter});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        // Dynamic title: Shows category name if filtered, else "Available Jobs"
        title: Text(
          filter == null ? 'Available Jobs' : 'Jobs in $filter',
          style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Column(
        children: [
          // If a filter is active, show a small "Clear Filter" chips bar
          if (filter != null)
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
              child: Row(
                children: [
                  Chip(
                    label: Text(filter!),
                    onDeleted: () => Navigator.pop(context),
                    deleteIcon: const Icon(Icons.close, size: 14),
                    backgroundColor: const Color(0xFF0F6B4A).withOpacity(0.1),
                  ),
                ],
              ),
            ),
            
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                // If filter is null, show all. If not, these are placeholders
                _buildJobCard(
                  filter ?? 'UI/UX Designer',
                  'Karzee Tech',
                  '\$50 - \$80 / hr',
                  'Remote',
                  Icons.palette,
                ),
                _buildJobCard(
                  'Flutter Developer',
                  'AppWorks',
                  '\$3,000 - \$5,000',
                  'Contract',
                  Icons.code,
                ),
                _buildJobCard(
                  'Content Writer',
                  'Creative Studio',
                  '\$20 - \$40 / hr',
                  'Part-time',
                  Icons.edit,
                ),
                _buildJobCard(
                  'Marketing Specialist',
                  'Growth Lab',
                  '\$4,000 / mo',
                  'Full-time',
                  Icons.trending_up,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildJobCard(String title, String company, String salary, String type, IconData icon) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 25,
              backgroundColor: const Color(0xFF0F6B4A).withOpacity(0.1),
              child: Icon(icon, color: const Color(0xFF0F6B4A)),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text(company, style: TextStyle(color: Colors.grey[600])),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        salary,
                        style: const TextStyle(
                          color: Color(0xFF0F6B4A), 
                          fontWeight: FontWeight.w600
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Text(type, style: const TextStyle(fontSize: 12)),
                      ),
                    ],
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