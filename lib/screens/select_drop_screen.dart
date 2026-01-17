import 'package:flutter/material.dart';
import 'confirm_ride_screen.dart';

class SelectDropScreen extends StatelessWidget {
  final String pickup;
  const SelectDropScreen({super.key, required this.pickup});

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
      appBar: AppBar(title: const Text("Select Drop Point")),
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
                  builder: (_) => ConfirmRideScreen(
                    pickup: pickup,
                    drop: locations[index],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
