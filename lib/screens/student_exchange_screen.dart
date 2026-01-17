import 'package:flutter/material.dart';
import 'post_item_screen.dart';
import 'buy_item_screen.dart';

class StudentExchangeScreen extends StatelessWidget {
  const StudentExchangeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Student Exchange Hub"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Card(
              child: ListTile(
                leading: const Icon(Icons.add_box, size: 40),
                title: const Text("Post Item"),
                subtitle: const Text("Sell your old items to students"),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const PostItemScreen(),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 25),
            Card(
              child: ListTile(
                leading: const Icon(Icons.shopping_cart, size: 40),
                title: const Text("Buy Item"),
                subtitle: const Text("Browse items posted by students"),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const BuyItemScreen(),
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
