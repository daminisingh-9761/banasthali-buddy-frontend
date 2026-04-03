import 'package:flutter/material.dart';
import '../services/admin_api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'admin_home_screen.dart'; // ✅ ADD THIS

class AdminUsersScreen extends StatefulWidget {
  const AdminUsersScreen({super.key});

  @override
  State<AdminUsersScreen> createState() => _AdminUsersScreenState();
}

class _AdminUsersScreenState extends State<AdminUsersScreen> {

  List users = [];

  @override
  void initState() {
    super.initState();
    loadUsers();
  }

  // Load users from backend
  void loadUsers() async {

    final prefs = await SharedPreferences.getInstance();
    String token = prefs.getString("token") ?? "";

    final data = await AdminApiService.getUsers();

    setState(() {
      users = data;
    });
  }

  // Delete user
  void deleteUser(String id) async {

    final prefs = await SharedPreferences.getInstance();
    String token = prefs.getString("token") ?? "";

    await AdminApiService.deleteUser(id);

    loadUsers();
  }

  @override
  Widget build(BuildContext context) {

    return WillPopScope(   // ✅ ADDED
      onWillPop: () async {

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const AdminHomeScreen()),
        );

        return false;
      },

      child: Scaffold(

        appBar: AppBar(
          backgroundColor: const Color(0xFF2F6F6D),
          title: const Text("Manage Users",
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

            /// 🔹 ORIGINAL LIST
            ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, index){

                final user = users[index];

                return Column(
                  children: [

                    ListTile(
                      leading: const CircleAvatar(
                        child: Icon(Icons.person),
                      ),

                      title: Text(user["username"] ?? ""),

                      subtitle: Text(user["role"] ?? ""),

                      trailing: IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          deleteUser(user["id"]);
                        },
                      ),
                    ),

                    const Divider(),

                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}