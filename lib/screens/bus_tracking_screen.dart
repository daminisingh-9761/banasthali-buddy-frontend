import 'package:flutter/material.dart';
import 'bus_route_screen.dart';

class BusTrackingScreen extends StatelessWidget {
  const BusTrackingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Bus Tracking"),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const BusRouteScreen(),
              ),
            );
          },
          child: const Text("Select Bus Route"),
        ),
      ),
    );
  }
}
