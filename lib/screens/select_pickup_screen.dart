import 'package:flutter/material.dart';
import 'select_drop_screen.dart';

class SelectPickupScreen extends StatelessWidget {
  const SelectPickupScreen({super.key});

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
          "Select Pickup Point",
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

      /// ✅ BACKGROUND IMAGE + LIST
      body: Stack(
        children: [

          /// 🔹 BACKGROUND IMAGE
          Positioned.fill(
            child: Image.asset(
              "assets/images/pick_bg.jpeg",
              fit: BoxFit.cover,
            ),
          ),

          /// 🔹 CONTENT (List)
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
                        builder: (_) =>
                            SelectDropScreen(pickup: locations[index]),
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