import 'package:flutter/material.dart';

class BuyItemScreen extends StatefulWidget {
  const BuyItemScreen({super.key});

  @override
  State<BuyItemScreen> createState() => _BuyItemScreenState();
}

class _BuyItemScreenState extends State<BuyItemScreen> {
  final TextEditingController _searchController = TextEditingController();

  // Dummy items (later backend se aayenge)
  final List<Map<String, String>> items = [
    {
      "name": "Study Table",
      "price": "₹1200",
      "description": "Good condition wooden table",
      "hostel": "Apaji Hostel",
      "contact": "9876543210",
    },
    {
      "name": "Cycle",
      "price": "₹2500",
      "description": "Used cycle, smooth condition",
      "hostel": "Gandhi Hostel",
      "contact": "9123456780",
    },
  ];

  List<Map<String, String>> filteredItems = [];

  @override
  void initState() {
    super.initState();
    filteredItems = items;
  }

  void searchItem(String query) {
    setState(() {
      filteredItems = items
          .where((item) =>
          item["name"]!.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Buy Items"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            /// 🔍 Search Bar
            TextField(
              controller: _searchController,
              onChanged: searchItem,
              style: const TextStyle(
                color: Colors.black, // 🔑 typed text black
              ),
              decoration: const InputDecoration(
                hintText: "Search items...",
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 20),

            /// 📦 Item Listings
            Expanded(
              child: filteredItems.isEmpty
                  ? const Center(child: Text("No items found"))
                  : ListView.builder(
                itemCount: filteredItems.length,
                itemBuilder: (context, index) {
                  final item = filteredItems[index];
                  return Card(
                    elevation: 3,
                    margin: const EdgeInsets.only(bottom: 12),
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item["name"]!,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(item["description"]!),
                          const SizedBox(height: 5),
                          Text(
                            "Price: ${item["price"]}",
                            style: const TextStyle(
                                fontWeight: FontWeight.w600),
                          ),

                          const SizedBox(height: 10),

                          /// 📞 Contact Seller (Info Only)
                          Align(
                            alignment: Alignment.centerRight,
                            child: ElevatedButton(
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    title: const Text("Seller Details"),
                                    content: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Hostel: ${item["hostel"]}",
                                        ),
                                        const SizedBox(height: 8),
                                        Text(
                                          "Contact Number: ${item["contact"]}",
                                        ),
                                      ],
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () =>
                                            Navigator.pop(context),
                                        child: const Text("Close"),
                                      ),
                                    ],
                                  ),
                                );
                              },
                              child: const Text("Contact Seller"),
                            ),
                          ),
                        ],
                      ),
                    ),
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
