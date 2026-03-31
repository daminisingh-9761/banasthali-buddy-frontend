import 'package:flutter/material.dart';
import 'admin_dashboard_screen.dart';
import 'admin_users_screen.dart';
import 'admin_routes_screen.dart';
import 'admin_manage_posts.dart';

class AdminHomeScreen extends StatefulWidget {
  const AdminHomeScreen({super.key});

  @override
  State<AdminHomeScreen> createState() => _AdminHomeScreenState();
}

class _AdminHomeScreenState extends State<AdminHomeScreen> {

  int currentIndex = 0;

  final List<Widget> pages = [
    const AdminDashboard(),
    const AdminUsersScreen(),
    const AdminRoutesScreen(),
    const AdminManagePostsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: pages[currentIndex],

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        selectedItemColor: const Color(0xFF2F6F6D),
        unselectedItemColor: Colors.grey,

        /// 🔥 Equal spacing fix
        type: BottomNavigationBarType.fixed,

        onTap: (index){
          setState(() {
            currentIndex = index;
          });
        },

        items: const [

          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: "Dashboard",
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: "Users",
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.route),
            label: "Routes",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.store),
            label: "Posts",
          ),
        ],
      ),
    );
  }
}