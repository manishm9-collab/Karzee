import 'package:flutter/material.dart';


class FreelancerDashboard extends StatelessWidget {
  const FreelancerDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Freelancer Dashboard'),
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // PROFILE CARD
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.grey.shade100,
              ),
              child: Row(
                children: [
                  const CircleAvatar(
                    radius: 28,
                    child: Icon(Icons.person),
                  ),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'John Freelancer',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text('Flutter Developer'),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            // STATS
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _statCard('Applied Jobs', '5'),
                _statCard('Active Jobs', '2'),
                _statCard('Earnings', '₹15,000'),
              ],
            ),

            const SizedBox(height: 40),

            // AVAILABLE JOBS
            const Text(
              'Available Jobs',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 16),

            Expanded(
              child: ListView(
                children: const [
                  _JobTile(
                    title: 'Build Flutter Web App',
                    budget: '₹5,000',
                  ),
                  _JobTile(
                    title: 'Landing Page UI',
                    budget: '₹3,000',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  static Widget _statCard(String title, String value) {
    return Container(
      width: 110,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 6),
          Text(title, textAlign: TextAlign.center),
        ],
      ),
    );
  }
}

class _JobTile extends StatelessWidget {
  final String title;
  final String budget;

  const _JobTile({
    required this.title,
    required this.budget,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        title: Text(title),
        subtitle: Text('Budget: $budget'),
        trailing: ElevatedButton(
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Applied successfully')),
            );
          },
          child: const Text('Apply'),
        ),
      ),
    );
  }
}
