import 'package:flutter/material.dart';

class BusMapScreen extends StatelessWidget {
  final String routeName;

  const BusMapScreen({super.key, required this.routeName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Live Bus Location"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          /// MAP PLACEHOLDER
          Container(
            height: 300,
            width: double.infinity,
            color: Colors.grey.shade300,
            child: const Center(
              child: Text(
                "Map View (Banasthali Vidyapith)",
                style: TextStyle(fontSize: 16),
              ),
            ),
          ),

          const SizedBox(height: 20),

          /// ROUTE + ETA
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Route: $routeName",
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                const Text(
                  "Estimated Arrival Time: 10 minutes",
                  style: TextStyle(fontSize: 15),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
