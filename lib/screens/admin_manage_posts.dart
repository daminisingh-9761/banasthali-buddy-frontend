import 'package:flutter/material.dart';
import '../services/api_service.dart';
import 'admin_home_screen.dart'; // ✅ ADD THIS

class AdminManagePostsScreen extends StatefulWidget {
  const AdminManagePostsScreen({super.key});

  @override
  State<AdminManagePostsScreen> createState() => _AdminManagePostsScreenState();
}

class _AdminManagePostsScreenState extends State<AdminManagePostsScreen> {

  List items = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadItems();
  }

  Future<void> loadItems() async {
    final data = await ApiService.getAllItems();

    if (!mounted) return;

    setState(() {
      items = data;
      isLoading = false;
    });
  }

  Future<void> deleteItem(String id) async {
    await ApiService.deleteItem(id);
    loadItems();
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
          title: const Text("Manage Posts",
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

        body: Stack(
          children: [

            Positioned.fill(
              child: IgnorePointer(
                child: Image.asset(
                  "assets/images/route.jpeg",
                  fit: BoxFit.cover,
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(16),

              child: isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : items.isEmpty
                  ? const Center(child: Text("No items found"))
                  : ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, index){

                  final item = items[index];

                  return Stack(
                    children: [

                      Container(
                        margin: const EdgeInsets.only(bottom: 15),
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.85),
                          borderRadius: BorderRadius.circular(15),
                        ),

                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            Text(
                              item["title"] ?? "",
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            const SizedBox(height: 5),

                            Text(item["description"] ?? ""),

                            const SizedBox(height: 5),

                            Text("₹${item["price"]}"),

                            const SizedBox(height: 10),

                            Text("Phone: ${item["sellerPhone"] ?? ""}"),
                            Text("Hostel: ${item["sellerHostel"] ?? ""}"),
                            Text("Room: ${item["sellerRoom"] ?? ""}"),

                            const SizedBox(height: 10),

                            Align(
                              alignment: Alignment.centerRight,
                              child: IconButton(
                                icon: const Icon(Icons.delete, color: Colors.red),
                                onPressed: item["id"] == null
                                    ? null
                                    : () => deleteItem(item["id"]),
                              ),
                            ),
                          ],
                        ),
                      ),

                      if (item["sold"] == true)
                        Positioned(
                          top: 5,
                          right: 10,
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                            color: Colors.red,
                            child: const Text(
                              "SOLD",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}