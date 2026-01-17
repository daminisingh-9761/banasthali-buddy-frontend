import 'package:flutter/material.dart';
import 'driver_assigned_screen.dart';

class ConfirmRideScreen extends StatelessWidget {
  final String pickup;
  final String drop;

  const ConfirmRideScreen({
    super.key,
    required this.pickup,
    required this.drop,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Confirm Ride")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Text("Pickup: $pickup"),
            Text("Drop: $drop"),
            const SizedBox(height: 10),
            const Text("Estimated Fare: ₹30"),
            const Text("Estimated Time: 10 mins"),
            const SizedBox(height: 30),
            ElevatedButton(
              child: const Text("Confirm Ride"),
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const DriverAssignedScreen(),
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
