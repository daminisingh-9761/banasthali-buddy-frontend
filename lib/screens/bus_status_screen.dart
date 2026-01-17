import 'package:flutter/material.dart';
import 'bus_map_screen.dart';

class BusStatusScreen extends StatelessWidget {
  final String routeName;

  const BusStatusScreen({super.key, required this.routeName});

  @override
  Widget build(BuildContext context) {
    // Dummy logic (backend later)
    bool isBusActive = true;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Bus Status"),
        centerTitle: true,
      ),
      body: Center(
        child: isBusActive
            ? Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.directions_bus,
                size: 60, color: Colors.green),
            const SizedBox(height: 10),
            const Text(
              "Bus is Active",
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) =>
                        BusMapScreen(routeName: routeName),
                  ),
                );
              },
              child: const Text("View Live Location"),
            ),
          ],
        )
            : const Text(
          "Bus Not Active",
          style: TextStyle(fontSize: 18, color: Colors.red),
        ),
      ),
    );
  }
}
