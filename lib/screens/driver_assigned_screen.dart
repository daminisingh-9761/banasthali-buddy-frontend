import 'package:flutter/material.dart';
import 'chat_screen.dart';

class DriverAssignedScreen extends StatelessWidget {
  const DriverAssignedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Driver Assigned")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const Text("Driver Name: Geeta"),
            const Text("E-Rickshaw No: RJ14 ER 2451"),
            const SizedBox(height: 30),
            ElevatedButton(
              child: const Text("Chat with Driver"),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const ChatScreen(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
