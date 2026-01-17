import 'package:flutter/material.dart';
import 'select_drop_screen.dart';

class SelectPickupScreen extends StatelessWidget {
  const SelectPickupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final locations = [
      "Main Gate",
      "Hostel Area",
      "Library",
      "Market Area",
      "Academic Block"
    ];

    return Scaffold(
      appBar: AppBar(title: const Text("Select Pickup Point")),
      body: ListView.builder(
        itemCount: locations.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(locations[index]),
            trailing: const Icon(Icons.arrow_forward),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) =>
                      SelectDropScreen(pickup: locations[index]),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
