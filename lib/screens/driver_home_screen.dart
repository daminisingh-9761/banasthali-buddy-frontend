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
  }


  /// load token
  Future<void> loadToken() async {

    final prefs =
    await SharedPreferences.getInstance();

    token = prefs.getString("token");

    Future.delayed(const Duration(seconds: 2), () {
      loadBookings();
    });
  }


  /// get bookings from backend
  Future<void> loadBookings() async {

    if(token == null) return;

    bookings =
    await ApiService.getDriverBookings(token!);

    setState(() {});

  }


  /// toggle online/offline
  Future<void> updateDriverStatus(bool value) async {

    if(token == null) return;

    await ApiService.driverOnline(token!);

    setState(() {

      isOnline = value;

    });

  }


  /// logout
  Future<void> logout() async {

    final prefs =
    await SharedPreferences.getInstance();

    await prefs.clear();

    Navigator.pop(context);

  }


  @override
  Widget build(BuildContext context) {

    final height =
        MediaQuery.of(context).size.height;

    return Scaffold(

      body: Stack(

        children: [

          /// HEADER
          Container(

            height: height * 0.35,

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

                mainAxisAlignment:
                MainAxisAlignment.spaceBetween,

                children: [

                  IconButton(

                    icon: const Icon(

                      Icons.settings,
                      color: Colors.white,

                    ),

                    onPressed: () {

                      Navigator.push(

                        context,

                        MaterialPageRoute(

                          builder: (_) =>
                          const SettingsScreen(

                            role: "driver",

                          ),

                        ),

                      );

                    },

                  ),

                  const Text(

                    "Driver Dashboard",

                    style: TextStyle(

                      fontSize: 24,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,

                    ),

                  ),

                  const SizedBox(width: 40),

                ],

              ),

            ),

          ),


          /// BODY
          Align(

            alignment: Alignment.bottomCenter,

            child: Container(

              height: height * 0.75,

              padding:
              const EdgeInsets.symmetric(

                  horizontal: 25),

              decoration: BoxDecoration(

                color:
                const Color(0xFFE6F4F1),

                borderRadius:
                const BorderRadius.only(

                  topLeft:
                  Radius.circular(40),

                  topRight:
                  Radius.circular(40),

                ),

              ),

              child: Column(

                mainAxisAlignment:
                MainAxisAlignment.center,

                children: [

                  /// DRIVER INFO
                  _menuTile(

                    title:

                    driverName.isEmpty
                        ? "Driver"
                        : driverName,

                    subtitle:

                    vehicleNumber.isEmpty
                        ? "Vehicle"
                        : vehicleNumber,

                    trailingWidget:

                    Row(

                      mainAxisSize:
                      MainAxisSize.min,

                      children: [

                        const Text("Online"),

                        Switch(

                          value: isOnline,

                          activeColor:
                          const Color(
                              0xFF2F6F6D),

                          onChanged:
                          updateDriverStatus,

                        ),

                      ],

                    ),

                    onTap: () {

                      Navigator.push(

                        context,

                        MaterialPageRoute(

                          builder: (_) =>
                          const DriverProfileScreen(),

                        ),

                      );

                    },

                  ),

                  const SizedBox(height: 20),

                  /// ride requests count
                  _simpleTile(

                    title:
                    "${bookings.length} Pending Ride Requests",

                    onTap: () {

                      Navigator.push(

                        context,

                        MaterialPageRoute(

                          builder: (_) =>
                          const RideRequestScreen(),

                        ),

                      );

                    },

                  ),

                  const SizedBox(height: 20),

                  _simpleTile(

                    title: "Active Ride",

                    onTap: () {

                      Navigator.push(

                        context,

                        MaterialPageRoute(

                          builder: (_) =>
                          const ActiveRideScreen(),

                        ),

                      );

                    },

                  ),

                  const SizedBox(height: 20),

                  _simpleTile(

                    title: "Update GPS Location",

                    onTap: () {

                      Navigator.push(

                        context,

                        MaterialPageRoute(

                          builder: (_) =>
                          const UpdateGPSScreen(),

                        ),

                      );

                    },

                  ),

                  const SizedBox(height: 20),

                  _simpleTile(

                    title: "Ride History",

                    onTap: () {

                      Navigator.push(

                        context,

                        MaterialPageRoute(

                          builder: (_) =>
                          const RideHistoryScreen(),

                        ),

                      );

                    },

                  ),

                  const SizedBox(height: 30),

                  /// logout
                  SizedBox(

                    width: double.infinity,

                    height: 55,

                    child: OutlinedButton(

                      onPressed: logout,

                      child: const Text(

                        "Logout",

                        style: TextStyle(

                          fontSize: 16,

                          color:
                          Color(0xFF2F6F6D),

                        ),

                      ),

                    ),

                  ),

                ],

              ),

            ),

          ),

        ],

      ),

    );

  }



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

          color: Colors.white,

          borderRadius:
          BorderRadius.circular(18),

        ),

        child: Column(

          crossAxisAlignment:
          CrossAxisAlignment.start,

          children: [

            Text(

              title,

              style: const TextStyle(

                fontWeight:
                FontWeight.bold,

                fontSize: 16,

              ),

            ),

            const SizedBox(height: 4),

            Text(

              subtitle,

              style:
              const TextStyle(

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



  Widget _simpleTile({

    required String title,

    required VoidCallback onTap,

  }) {

    return SizedBox(

      width: double.infinity,

      height: 65,

      child: ElevatedButton(

        style: ElevatedButton.styleFrom(

          backgroundColor:
          const Color(0xFF2F6F6D),

        ),

        onPressed: onTap,

        child: Text(

          title,

          style:
          const TextStyle(

            fontSize: 16,

          ),

        ),

      ),

    );

  }

}