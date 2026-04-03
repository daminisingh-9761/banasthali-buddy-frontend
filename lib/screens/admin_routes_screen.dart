import 'package:flutter/material.dart';
import '../services/admin_api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'admin_home_screen.dart'; // ✅ ADD THIS

class AdminRoutesScreen extends StatefulWidget {
  const AdminRoutesScreen({super.key});

  @override
  State<AdminRoutesScreen> createState() => _AdminRoutesScreenState();
}

class _AdminRoutesScreenState extends State<AdminRoutesScreen> {

  List routes = [];

  @override
  void initState() {
    super.initState();
    loadRoutes();
  }

  // Load routes from backend
  void loadRoutes() async {

    final prefs = await SharedPreferences.getInstance();
    String token = prefs.getString("token") ?? "";

    final data = await AdminApiService.getRoutes();

    setState(() {
      routes = data;
    });
  }

  // Delete route
  void deleteRoute(String id) async {

    final prefs = await SharedPreferences.getInstance();
    String token = prefs.getString("token") ?? "";

    await AdminApiService.deleteRoute(id);

    loadRoutes();
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
          title: const Text("Manage Routes",
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

        floatingActionButton: FloatingActionButton(
          backgroundColor: const Color(0xFF2F6F6D),
          onPressed: () {
            print("Add route pressed");
          },
          child: const Icon(Icons.add),
        ),

        /// 🔹 BODY WITH BACKGROUND
        body: Stack(
          children: [

            Positioned.fill(
              child: Image.asset(
                "assets/images/route.jpeg",
                fit: BoxFit.cover,
              ),
            ),

        routes.isEmpty
            ? const Center(child: Text("No routes found"))
            : ListView.builder(
            itemCount: routes.length,
            itemBuilder: (context, index) {

                final route = routes[index];

                return Column(
                  children: [

                    ListTile(
                      leading: const Icon(Icons.route),

                      title: Text(route["name"] ?? ""),

                      subtitle: Text("Stops: ${route["stops"]?.length ?? 0}"),

                      trailing: IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          deleteRoute(route["id"]);
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