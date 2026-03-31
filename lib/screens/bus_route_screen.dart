import 'package:flutter/material.dart';
import 'bus_status_screen.dart';

class BusRouteScreen extends StatelessWidget {
  const BusRouteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final routes = [
      "Main Gate to Old Market",
      "Old Market to Main Gate",
      "Hostel Area to Academic Block",
      "Academic Block to Hostel Area",
    ];

    return Scaffold(

      /// ✅ HEADER UPDATED
      appBar: AppBar(
        backgroundColor: const Color(0xFF2F6F6D),
        title: const Text(
          "Select Bus Route",
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

          /// 🔹 ROUTE LIST
          ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: routes.length,
            itemBuilder: (context, index) {

              return Container(
                margin: const EdgeInsets.only(bottom: 12),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.85),
                  borderRadius: BorderRadius.circular(15),
                ),

                child: ListTile(
                  leading: const Icon(
                    Icons.directions_bus,
                    color: Color(0xFF2F6F6D),
                  ),

                  title: Text(
                    routes[index],
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
                            BusStatusScreen(routeName: routes[index]),
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