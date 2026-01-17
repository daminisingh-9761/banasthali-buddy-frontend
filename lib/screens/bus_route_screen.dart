import 'package:flutter/material.dart';
import 'bus_status_screen.dart';

class BusRouteScreen extends StatelessWidget {
  const BusRouteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final routes = [
      "Main Gate to Old Market",
      "Old Market to Main Gate",
      "Hostel Area to Academic Block",
      "Academic Block to Hostel Area",
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Select Bus Route"),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: routes.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              title: Text(routes[index]),
              trailing: const Icon(Icons.arrow_forward),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) =>
                        BusStatusScreen(routeName: routes[index]),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
