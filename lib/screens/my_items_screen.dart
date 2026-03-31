import 'package:flutter/material.dart';
import '../services/api_service.dart';

class MyItemsScreen extends StatefulWidget {
  const MyItemsScreen({super.key});

  @override
  State<MyItemsScreen> createState() => _MyItemsScreenState();
}

class _MyItemsScreenState extends State<MyItemsScreen> {

  List items = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadItems();
  }

  Future<void> loadItems() async {
    final data = await ApiService.getMyItems();

    if (!mounted) return; // ✅ FIX

    setState(() {
      items = data;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        backgroundColor: const Color(0xFF2F6F6D),
        title: const Text("My Items"),
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
                ? const Center(child: Text("No items found")) // ✅ FIX
                : ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {

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

                          Text(item["title"] ?? "",
                              style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold)),

                          const SizedBox(height: 5),

                          Text(item["description"] ?? ""),

                          const SizedBox(height: 5),

                          Text("Price: ₹${item["price"]}"),

                          const SizedBox(height: 10),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [

                              ElevatedButton(
                                onPressed: item["sold"] == true
                                    ? null
                                    : () async {
                                  await ApiService.markItemAsSold(item["id"]);
                                  loadItems();
                                },
                                child: Text(
                                  item["sold"] == true ? "Sold" : "Mark Sold",
                                ),
                              ),

                              TextButton(
                                onPressed: item["id"] == null
                                    ? null
                                    : () async {
                                  await ApiService.deleteItem(item["id"]);
                                  loadItems();

                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(content: Text("Item deleted")),
                                  );
                                },
                                child: const Text("Delete",
                                    style: TextStyle(color: Colors.red)),
                              ),
                            ],
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
                          child: const Text("SOLD",
                              style: TextStyle(color: Colors.white)),
                        ),
                      ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}