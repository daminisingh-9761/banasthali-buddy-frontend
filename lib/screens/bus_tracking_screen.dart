import 'package:flutter/material.dart';
import 'bus_route_screen.dart';

class BusTrackingScreen extends StatelessWidget {
  const BusTrackingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(

        /// ✅ same green color as Select Bus Route screen
        backgroundColor: const Color(0xFF2F6F6D),

        title: const Text(
          "Bus Tracking",

          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            letterSpacing: 1,
          ),
        ),

        centerTitle: true,
      ),

      body: Stack(

        children: [

          /// BACKGROUND IMAGE
          Positioned.fill(
            child: Image.asset(
              "assets/images/route.jpeg",
              fit: BoxFit.cover,
            ),
          ),

          /// CONTENT
          Padding(
            padding: const EdgeInsets.all(20),

            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,

              children: [

                const Icon(
                  Icons.directions_bus,
                  size: 80,
                  color: Color(0xFF2F6F6D),
                ),

                const SizedBox(height: 20),

                const Text(
                  "Track Campus Bus",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 8),

                const Text(
                  "View real-time location of Banasthali buses",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black54,
                  ),
                ),

                const SizedBox(height: 40),

                Card(
                  elevation: 6,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),

                  child: SizedBox(
                    width: double.infinity,
                    height: 55,

                    child: ElevatedButton.icon(

                      icon: const Icon(Icons.route),

                      label: const Text(
                        "Select Bus Route",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),

                      onPressed: () {

                        Navigator.push(

                          context,

                          MaterialPageRoute(
                            builder: (_) => const BusRouteScreen(),
                          ),

                        );

                      },

                    ),

                  ),

                ),

              ],

            ),

          ),

        ],

      ),

    );
  }
}