import 'package:flutter/material.dart';

class StudentRideHistoryScreen extends StatelessWidget {
  const StudentRideHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {

    /// 🔹 DUMMY DATA (later backend se replace hoga)
    final rides = [
      {
        "pickup": "Main Gate",
        "drop": "Library",
        "fare": "₹30",
        "time": "10 mins"
      },
      {
        "pickup": "Hostel Area",
        "drop": "Market Area",
        "fare": "₹40",
        "time": "12 mins"
      },
    ];

    return Scaffold(

      /// 🔵 HEADER
      appBar: AppBar(
        backgroundColor: const Color(0xFF2F6F6D),
        title: const Text(
          "Ride History",
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

          /// 🔹 BACKGROUND IMAGE
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

                      /// DETAILS
                      Text("Fare: ${ride["fare"]}"),
                      Text("Time: ${ride["time"]}"),

                      const SizedBox(height: 8),

                      /// STATUS
                      const Text(
                        "Status: Completed",
                        style: TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.w600,
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