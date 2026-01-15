import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Banasthali Buddy"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [

            /// Student Exchange Hub
            _homeCard(
              context,
              title: "Student Exchange Hub",
              subtitle: "Buy & sell items among students",
              icon: Icons.swap_horiz,
            ),

            const SizedBox(height: 20),

            /// Bus Tracking
            _homeCard(
              context,
              title: "Bus Tracking",
              subtitle: "Track campus buses in real time",
              icon: Icons.directions_bus,
            ),

            const SizedBox(height: 20),

            /// E-Rickshaw Booking
            _homeCard(
              context,
              title: "E-Rickshaw Booking",
              subtitle: "Book e-rickshaw inside campus",
              icon: Icons.electric_rickshaw,
            ),
          ],
        ),
      ),
    );
  }

  /// Reusable Card Widget
  Widget _homeCard(
      BuildContext context, {
        required String title,
        required String subtitle,
        required IconData icon,
      }) {
    return Card(
      elevation: 4,
      child: ListTile(
        leading: Icon(icon, size: 40),
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.arrow_forward_ios),
        onTap: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("$title clicked")),
          );
        },
      ),
    );
  }
}
