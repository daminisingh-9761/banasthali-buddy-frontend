import 'package:flutter/material.dart';
import 'package:frontend/widgets/home_card.dart';
import 'student_exchange_screen.dart';
import 'erickshaw_booking_screen.dart';
import 'bus_tracking_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Banasthali Buddy"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            /// Student Exchange Hub
            HomeCard(
              title: "Student Exchange Hub",
              subtitle: "Buy & sell items among students",
              icon: Icons.swap_horiz,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const StudentExchangeScreen(),
                  ),
                );
              },
            ),

            const SizedBox(height: 20),

            /// Bus Tracking
            HomeCard(
              title: "Bus Tracking",
              subtitle: "Track campus buses in real time",
              icon: Icons.directions_bus,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const BusTrackingScreen(),
                  ),
                );
              },
            ),

            const SizedBox(height: 20),

            /// E-Rickshaw Booking
            HomeCard(
              title: "E-Rickshaw Booking",
              subtitle: "Book e-rickshaw inside campus",
              icon: Icons.electric_rickshaw,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const ErickshawBookingScreen(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}