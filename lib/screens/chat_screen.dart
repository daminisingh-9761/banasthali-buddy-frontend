import 'package:flutter/material.dart';
import 'booking_success_screen.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Chat with Driver")),
      body: Column(
        children: [
          const ListTile(
            title: Text("Driver: I am near the library"),
          ),
          const ListTile(
            title: Text("You: I am waiting at hostel gate"),
          ),
          const Spacer(),
          ElevatedButton(
            child: const Text("Complete Booking"),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (_) => const BookingSuccessScreen(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
