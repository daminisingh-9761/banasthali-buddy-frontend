import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'driver_profile_screen.dart';
import 'ride_request_screen.dart';
import 'active_ride_screen.dart';
import 'update_gps_screen.dart';
import 'ride_history_screen.dart';
import 'settings_screen.dart';
import '../services/api_service.dart';

class DriverHomeScreen extends StatefulWidget {
  const DriverHomeScreen({super.key});

  @override
  State<DriverHomeScreen> createState() => _DriverHomeScreenState();
}

class _DriverHomeScreenState extends State<DriverHomeScreen> {

  bool isOnline = false;
  List bookings = [];
  String driverName = "";
  String vehicleNumber = "";
  String? token;

  @override
  void initState() {
    super.initState();
    ApiService.pingServer();
    loadToken();


    Future.doWhile(() async {
      await Future.delayed(const Duration(seconds: 5));
      await loadBookings();
      return true;
    });
  }

  Future<void> loadToken() async {
    final prefs = await SharedPreferences.getInstance();
    token = prefs.getString("token");

    Future.delayed(const Duration(seconds: 2), () {
      loadBookings();
    });
  }

  Future<void> loadBookings() async {
    if(token == null) return;

    bookings = await ApiService.getDriverBookings(token!);
    setState(() {});
  }

  Future<void> updateDriverStatus(bool value) async {
    if(token == null) return;

    await ApiService.driverOnline(token!, value);

    setState(() {
      isOnline = value;
    });
  }

  @override
  Widget build(BuildContext context) {

    final height = MediaQuery.of(context).size.height;

    return Scaffold(

      body: Stack(
        children: [

          /// 🔹 FULL BACKGROUND IMAGE
          Positioned.fill(
            child: Image.asset(
              "assets/images/route.jpeg",
              fit: BoxFit.cover,
            ),
          ),

          /// 🔵 HEADER
          Container(
            height: height * 0.30,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFF2F6F6D),
                  Color(0xFF4A9C97),
                ],
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.only(
                top: 70,
                left: 20,
                right: 20,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [

                  IconButton(
                    icon: const Icon(Icons.settings, color: Colors.white),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const SettingsScreen(role: "driver"),
                        ),
                      );
                    },
                  ),

                  const Text(
                    "Driver Dashboard",
                    style: TextStyle(
                      fontSize: 22,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(width: 40),
                ],
              ),
            ),
          ),

          /// 🔹 BODY
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: height * 0.75,
              padding: const EdgeInsets.symmetric(
                  horizontal: 22,
                  vertical: 25
              ),

              decoration: BoxDecoration(
                color: Colors.transparent, // ✅ FIXED
                borderRadius: BorderRadius.zero,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.15),
                    blurRadius: 25,
                    offset: const Offset(0,-10),
                  ),
                ],
              ),

              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  /// DRIVER CARD
                  _menuTile(
                    title: driverName.isEmpty ? "Driver" : driverName,
                    subtitle: vehicleNumber.isEmpty ? "Vehicle" : vehicleNumber,
                    trailingWidget: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text("Online"),
                        Switch(
                          value: isOnline,
                          activeColor: const Color(0xFF2F6F6D),
                          onChanged: updateDriverStatus,
                        ),
                      ],
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const DriverProfileScreen(),
                        ),
                      );
                    },
                  ),

                  const SizedBox(height: 18),

                  _simpleTile(
                    title: "${bookings.length} Pending Ride Requests",
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const RideRequestScreen(),
                        ),
                      );
                    },
                  ),

                  const SizedBox(height: 15),

                  _simpleTile(
                    title: "Active Ride",
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const ActiveRideScreen(),
                        ),
                      );
                    },
                  ),

                  const SizedBox(height: 15),

                  _simpleTile(
                    title: "Update GPS Location",
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const UpdateGPSScreen(),
                        ),
                      );
                    },
                  ),

                  const SizedBox(height: 15),

                  _simpleTile(
                    title: "Ride History",
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const RideHistoryScreen(),
                        ),
                      );
                    },
                  ),

                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// 🔹 DRIVER TILE
  Widget _menuTile({
    required String title,
    required String subtitle,
    required Widget trailingWidget,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.95),
          borderRadius: BorderRadius.circular(22),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 18,
              offset: const Offset(0,8),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 17,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              subtitle,
              style: const TextStyle(
                color: Colors.black54,
              ),
            ),
            const SizedBox(height: 10),
            trailingWidget,
          ],
        ),
      ),
    );
  }

  /// 🔹 BUTTON TILE
  Widget _simpleTile({
    required String title,
    required VoidCallback onTap,
  }) {
    return SizedBox(
      width: double.infinity,
      height: 60,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF2F6F6D),
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        onPressed: onTap,
        child: Text(
          title,
          style: const TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}