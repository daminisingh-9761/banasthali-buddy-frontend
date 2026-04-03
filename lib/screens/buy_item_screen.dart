import 'package:flutter/material.dart';
import '../services/api_service.dart';
import 'home_screen.dart';

class BuyItemScreen extends StatefulWidget {
  const BuyItemScreen({super.key});

  @override
  State<BuyItemScreen> createState() => _BuyItemScreenState();
}

class _BuyItemScreenState extends State<BuyItemScreen> {

  final TextEditingController _searchController = TextEditingController();

  List items = [];
  List filteredItems = [];

  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadItems();
  }

  Future<void> loadItems() async {
    final data = await ApiService.getItems();
    print("ITEMS DATA: $data");

    if (!mounted) return;

    setState(() {
      items = data;
      filteredItems = data;
      isLoading = false;
    });
  }

  Future<void> searchItem(String query) async {

    if (query.isEmpty) {

      loadItems();

      return;

    }

    final data =
    await ApiService.searchItems(query);

    setState(() {

      filteredItems = data;

    });

  }

  Future<void> filterByCategory(String category) async {

    final data =
    await ApiService.getItemsByCategory(category);

    setState(() {

      filteredItems = data;

    });

  }

  Future<void> deleteItem(String id) async {

    await ApiService.deleteItem(id);

    loadItems();

  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(

        backgroundColor: const Color(0xFF2F6F6D),

        title: const Text("Buy Items"),

        centerTitle: true,

        actions: [

          IconButton(

            icon: const Icon(Icons.home),

            onPressed: () {

              Navigator.pushAndRemoveUntil(

                context,

                MaterialPageRoute(

                  builder: (_) =>
                  const HomeScreen(),

                ),

                    (route) => false,

              );

            },

          ),

        ],

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

            child: Column(

              children: [

                TextField(

                  controller:
                  _searchController,

                  onChanged:
                  searchItem,

                  decoration:
                  InputDecoration(

                    hintText:
                    "Search items...",

                    prefixIcon:
                    const Icon(Icons.search),

                    filled:
                    true,

                    fillColor:
                    Colors.white.withOpacity(0.9),

                    border:
                    OutlineInputBorder(

                      borderRadius:
                      BorderRadius.circular(15),

                      borderSide:
                      BorderSide.none,

                    ),

                  ),

                ),

                const SizedBox(height: 10),

                Row(

                  mainAxisAlignment:
                  MainAxisAlignment.spaceAround,

                  children: [

                    TextButton(

                      onPressed: loadItems,

                      child:
                      const Text("All"),

                    ),

                    TextButton(

                      onPressed: () =>

                          filterByCategory("Books"),

                      child:
                      const Text("Books"),

                    ),

                    TextButton(

                      onPressed: () =>

                          filterByCategory("Electronics"),

                      child:
                      const Text("Electronics"),

                    ),

                  ],

                ),

                const SizedBox(height: 10),

                Flexible(

                  child: isLoading

                      ? const Center(

                      child:
                      CircularProgressIndicator())

                      : filteredItems.isEmpty

                      ? const Center(

                      child: Text("No items found"))

                      : ListView.builder(

                    itemCount:

                    filteredItems.length,

                    itemBuilder:

                        (context, index) {

                      final item =
                      filteredItems[index];

                      return Stack(

                        children: [

                          Container(

                            margin:

                            const EdgeInsets.only(

                                bottom: 15),

                            padding:

                            const EdgeInsets.all(12),

                            decoration:

                            BoxDecoration(

                              color:

                              Colors.white.withOpacity(0.85),

                              borderRadius:

                              BorderRadius.circular(18),

                            ),

                            child: Row(

                              children: [

                                Container(

                                  height: 80,

                                  width: 80,

                                  decoration:

                                  BoxDecoration(

                                    color:

                                    const Color(0xFFCDEAE4),

                                    borderRadius:

                                    BorderRadius.circular(10),

                                  ),

                                  child:

                                  item["imageUrl"] != null &&

                                      item["imageUrl"]

                                          .toString()

                                          .isNotEmpty

                                      ? ClipRRect(

                                    borderRadius:

                                    BorderRadius.circular(10),

                                    child: Image.network(

                                      "https://banasthali-buddy.onrender.com${item["imageUrl"]}",

                                      fit:

                                      BoxFit.cover,

                                      errorBuilder:

                                          (context, error, stackTrace) {

                                        return const Icon(

                                            Icons.image);

                                      },

                                    ),

                                  )

                                      : const Icon(

                                      Icons.image),

                                ),

                                const SizedBox(

                                    width: 15),

                                Expanded(

                                  child: Column(

                                    crossAxisAlignment:

                                    CrossAxisAlignment.start,

                                    children: [

                                      Text(

                                        item["title"] ?? "",

                                        style:

                                        const TextStyle(

                                            fontSize:

                                            18,

                                            fontWeight:

                                            FontWeight.bold),

                                      ),

                                      Text(

                                        item["description"] ??

                                            "",

                                      ),

                                      Text(

                                        "₹${item["price"]}",

                                      ),

                                    ],

                                  ),

                                ),

                                Column(

                                  children: [

                                    ElevatedButton(

                                      onPressed:

                                      item["available"] == false

                                          ? null

                                          : () {

                                        showDialog(

                                          context:

                                          context,

                                          builder:

                                              (_) => AlertDialog(

                                            title:

                                            const Text(

                                                "Seller Details"),

                                            content:

                                            Column(

                                              mainAxisSize:

                                              MainAxisSize.min,

                                              children: [

                                                Text(

                                                    "Phone: ${item["sellerPhone"] ?? "Not available"}"),

                                                Text(

                                                    "Hostel: ${item["sellerHostel"] ?? "Not available"}"),

                                                Text(

                                                    "Room: ${item["sellerRoom"] ?? "Not available"}"),

                                              ],

                                            ),

                                          ),

                                        );

                                      },

                                      child: Text(

                                        item["available"] == false

                                            ? "Sold Out"

                                            : "Contact",

                                      ),

                                    ),

                                    IconButton(

                                      icon:

                                      const Icon(

                                          Icons.delete,

                                          color:

                                          Colors.red),

                                      onPressed:

                                      item["id"] == null

                                          ? null

                                          : () => deleteItem(

                                          item["id"]),

                                    ),

                                  ],

                                )

                              ],

                            ),

                          ),

                          if (item["available"] == false)

                            Positioned(

                              top: 5,

                              right: 10,

                              child:

                              Container(

                                padding:

                                const EdgeInsets.symmetric(

                                    horizontal: 10,

                                    vertical: 5),

                                color:

                                Colors.red,

                                child:

                                const Text(

                                  "SOLD",

                                  style:

                                  TextStyle(

                                      color:

                                      Colors.white),

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

        ],

      ),

    );

  }

}