import 'package:flutter/material.dart';
import 'select_pickup_screen.dart';

class ErickshawBookingScreen extends StatelessWidget {
  const ErickshawBookingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("E-Rickshaw Booking")),
      body: Center(
        child: ElevatedButton(
          child: const Text("Book a Ride"),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const SelectPickupScreen(),
              ),
            );
          },
        ),
      ),
    );
  }
}
