import 'package:flutter/material.dart';
import 'package:frontend/screens/student_exchange_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'login_screen.dart';
import 'edit_profile_screen.dart';
import 'my_items_screen.dart';
import 'student_ride_history_screen.dart';
import 'driver_ride_history_screen.dart';
import 'vehicle_details_screen.dart';
import 'driver_availability_screen.dart';


class SettingsScreen extends StatefulWidget {
  final String role;

  const SettingsScreen({super.key, required this.role});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {

  bool isAvailable = true; // 🔥 driver toggle
  @override
  Widget build(BuildContext context) {
    final role = widget.role.toLowerCase();
    print("ROLE IN SETTINGS: $role"); // 🔥 DEBUG

    return Scaffold(
      body: Stack(
        children: [

          /// 🔵 HEADER
          Container(
            height: MediaQuery.of(context).size.height * 0.35,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFF2F6F6D),
                  Color(0xFF4A9C97),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: const Padding(
              padding: EdgeInsets.only(top: 70),
              child: Center(
                child: Text(
                  "Settings",
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),

          /// ⚪ MAIN CONTAINER
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.75,
              padding: const EdgeInsets.all(25),
              decoration: BoxDecoration(
                color: const Color(0xFFE6F4F1),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.15),
                    blurRadius: 15,
                    offset: const Offset(0, -5),
                  ),
                ],
              ),

              child: ListView(
                children: [

                  /// 🔹 COMMON (ALL USERS)
                  _tile(context, "Edit Profile", Icons.person, () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const EditProfileScreen(),
                      ),
                    );
                  }),

                  _tile(context, "Change Password", Icons.lock, () {
                    _showChangePasswordDialog(context);
                  }),

                  /// 🎓 STUDENT
                  if (role == "student") ...[
                    _tile(context, "My Items", Icons.inventory, () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const MyItemsScreen(),
                        ),
                      );
                    }),

                    _tile(context, "Ride History", Icons.history, () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const StudentRideHistoryScreen(),
                        ),
                      );
                    }),
                  ],

                  /// 🚗 DRIVER
                  if (role == "driver") ...[
                    _tile(context, "Vehicle Details", Icons.directions_car, () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const VehicleDetailsScreen(),
                        ),
                      );
                    }),

                    _tile(context, "Ride History", Icons.history, () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const DriverRideHistoryScreen(),
                        ),
                      );
                    }),

                    _tile(context, "Availability", Icons.toggle_on, () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const DriverAvailabilityScreen(),
                        ),
                      );
                    }),
                  ],

                  /// 👨‍💼 ADMIN
                  if (role == "admin") ...[
                    ///no extra  content
                  ],
                  const SizedBox(height: 20),

                  /// 🚪 LOGOUT
                  _logoutTile(context),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// 🔹 TILE FUNCTION
  static Widget _tile(BuildContext context, String title, IconData icon, VoidCallback onTap) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: ListTile(
        leading: Icon(icon, color: const Color(0xFF2F6F6D)),
        title: Text(title),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: onTap,
      ),
    );
  }

  /// 🔹 PASSWORD DIALOG
  static void _showChangePasswordDialog(BuildContext context) {
    TextEditingController oldPass = TextEditingController();
    TextEditingController newPass = TextEditingController();
    TextEditingController confirmPass = TextEditingController();

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Change Password"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [

            TextField(
              controller: oldPass,
              obscureText: true,
              decoration: const InputDecoration(labelText: "Old Password"),
            ),

            TextField(
              controller: newPass,
              obscureText: true,
              decoration: const InputDecoration(labelText: "New Password"),
            ),

            TextField(
              controller: confirmPass,
              obscureText: true,
              decoration: const InputDecoration(labelText: "Confirm Password"),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () {

              if (newPass.text != confirmPass.text) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Passwords do not match")),
                );
                return;
              }

              Navigator.pop(context);

              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Password Updated")),
              );
            },
            child: const Text("Update"),
          ),
        ],
      ),
    );
  }

  /// 🔹 LOGOUT
  /// 🔹 LOGOUT
  Widget _logoutTile(BuildContext context) {

    return Card(

      shape: RoundedRectangleBorder(

        borderRadius: BorderRadius.circular(15),

      ),

      child: ListTile(

        leading: const Icon(Icons.logout, color: Colors.red),

        title: const Text("Logout"),

        onTap: () async {

          // clear saved login token

          final prefs = await SharedPreferences.getInstance();

          await prefs.clear();

          // go to login screen

          Navigator.pushAndRemoveUntil(

            context,

            MaterialPageRoute(

              builder: (_) => const LoginScreen(),

            ),

                (route) => false,

          );

        },

      ),

    );

  }
}