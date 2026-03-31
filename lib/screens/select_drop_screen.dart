import 'package:flutter/material.dart';
import 'confirm_ride_screen.dart';

class SelectDropScreen extends StatelessWidget {
  final String pickup;
  const SelectDropScreen({super.key, required this.pickup});

  @override
  Widget build(BuildContext context) {
    final locations = [
      "Main Gate",
      "Hostel Area",
      "Library",
      "Market Area",
      "Academic Block"
    ];

    return Scaffold(

      /// ✅ HEADER UPDATED
      appBar: AppBar(
        backgroundColor: const Color(0xFF2F6F6D),
        title: const Text(
          "Select Drop Point",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            letterSpacing: 1,
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

      /// ✅ BACKGROUND + LIST
      body: Stack(
        children: [

          /// 🔹 BACKGROUND IMAGE
          Positioned.fill(
            child: Image.asset(
              "assets/images/pick_bg.jpeg",
              fit: BoxFit.cover,
            ),
          ),

          /// 🔹 LIST CONTENT
          ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: locations.length,
            itemBuilder: (context, index) {

              return Container(
                margin: const EdgeInsets.only(bottom: 12),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.85),
                  borderRadius: BorderRadius.circular(15),
                ),

                child: ListTile(
                  leading: const Icon(
                    Icons.location_on,
                    color: Color(0xFF2F6F6D),
                  ),

                  title: Text(
                    locations[index],
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  trailing: const Icon(
                    Icons.arrow_forward_ios,
                    size: 18,
                    color: Color(0xFF2F6F6D),
                  ),

                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ConfirmRideScreen(
                          pickup: pickup,
                          drop: locations[index],
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}