import 'package:flutter/material.dart';

class DriverRideHistoryScreen extends StatelessWidget {
  const DriverRideHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {

    /// 🔹 DUMMY DRIVER DATA
    final rides = [
      {
        "pickup": "Main Gate",
        "drop": "Library",
        "earning": "₹30",
        "status": "Completed"
      },
      {
        "pickup": "Hostel Area",
        "drop": "Market Area",
        "earning": "₹40",
        "status": "Completed"
      },
    ];

    return Scaffold(

      /// 🔵 HEADER
      appBar: AppBar(
        backgroundColor: const Color(0xFF2F6F6D),
        title: const Text(
          "Driver Ride History",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            shadows: [
              Shadow(
                blurRadius: 4,
                color: Colors.black26,
                offset: Offset(1, 2),
              ),
            ],
          ),
        ),
        centerTitle: true,
      ),

      /// ✅ BODY WITH BACKGROUND
      body: Stack(
        children: [

          /// 🔹 BACKGROUND
          Positioned.fill(
            child: Image.asset(
              "assets/images/route.jpeg",
              fit: BoxFit.cover,
            ),
          ),

          /// 🔹 CONTENT
          Padding(
            padding: const EdgeInsets.all(16),
            child: ListView.builder(
              itemCount: rides.length,
              itemBuilder: (context, index) {
                final ride = rides[index];

                return Container(
                  margin: const EdgeInsets.only(bottom: 15),
                  padding: const EdgeInsets.all(12),

                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.85),
                    borderRadius: BorderRadius.circular(15),
                  ),

                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      /// ROUTE
                      Text(
                        "${ride["pickup"]} → ${ride["drop"]}",
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 5),

                      /// EARNING
                      Text(
                        "Earning: ${ride["earning"]}",
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                        ),
                      ),

                      const SizedBox(height: 5),

                      /// STATUS
                      Text(
                        "Status: ${ride["status"]}",
                        style: const TextStyle(
                          color: Colors.green,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}