import 'package:flutter/material.dart';
import '../services/admin_api_service.dart';
import 'settings_screen.dart'; // ✅ ADD

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({super.key});

  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {

  int students = 0;
  int drivers = 0;
  int rides = 0;
  int listings = 0;

  @override
  void initState() {
    super.initState();
    loadDashboard();
  }

  void loadDashboard() async {
    String token = "YOUR_JWT_TOKEN";

    final data = await AdminApiService.getDashboardStats();

    setState(() {
      students = data["students"];
      drivers = data["drivers"];
      rides = data["activeRides"];
      listings = data["listings"];
    });
  }

  Widget dashboardCard(String title, String value, IconData icon) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.85),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            Icon(icon, size: 35, color: const Color(0xFF2F6F6D)),

            const SizedBox(height: 10),

            Text(
              value,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 5),

            Text(title),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      /// 🔵 HEADER (WITH SETTINGS ICON)
      appBar: AppBar(
        backgroundColor: const Color(0xFF2F6F6D),

        leading: IconButton(
          icon: const Icon(Icons.settings, color: Colors.white),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const SettingsScreen(role: "admin"),
              ),
            );
          },
        ),

        title: const Text("Admin Dashboard",
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

      /// 🔹 BODY WITH BACKGROUND
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

            child: GridView.count(
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,

              children: [

                dashboardCard("Students", students.toString(), Icons.school),

                dashboardCard("Drivers", drivers.toString(), Icons.drive_eta),

                dashboardCard("Active Rides", rides.toString(), Icons.directions_car),

                dashboardCard("Listings", listings.toString(), Icons.store),


              ],
            ),
          ),
        ],
      ),
    );
  }
}