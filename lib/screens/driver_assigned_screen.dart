import 'package:flutter/material.dart';
import 'dart:async';
import '../services/booking_service.dart';
import 'chat_screen.dart';

class DriverAssignedScreen extends StatefulWidget {
  const DriverAssignedScreen({super.key});

  @override
  State<DriverAssignedScreen> createState() => _DriverAssignedScreenState();
}

class _DriverAssignedScreenState extends State<DriverAssignedScreen> {

  final bookingService = BookingService();

  List rides = [];
  bool loading = true;

  Timer? timer;

  @override
  void initState() {
    super.initState();
    loadRide();

    /// 🔵 AUTO REFRESH EVERY 5 SECONDS
    timer = Timer.periodic(
      const Duration(seconds: 5),
          (Timer t) => loadRide(),
    );
  }

  Future loadRide() async {

    final result = await bookingService.getStudentBookings();

    setState(() {
      rides = result;
      loading = false;
    });
  }

  @override
  void dispose() {
    timer?.cancel();   // stop timer when screen closes
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: const Text("Driver Assigned")),

      body: loading
          ? const Center(child: CircularProgressIndicator())
          : rides.isEmpty
          ? const Center(child: Text("No Ride Found"))
          : Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [

            Text(
              "Pickup: ${rides.last["pickupPostId"]}",
              style: const TextStyle(fontSize: 18),
            ),

            Text(
              "Drop: ${rides.last["destinationPostId"]}",
              style: const TextStyle(fontSize: 18),
            ),

            const SizedBox(height: 10),

            Text(
              "Ride Status: ${rides.last["status"]}",
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 30),

            ElevatedButton(
              child: const Text("Chat with Driver"),

              onPressed: () {

                String bookingId =
                rides.last["id"].toString();

                // 🔴 ADD THIS LINE
                print("BOOKING ID PASSING TO CHAT: $bookingId");

                Navigator.push(

                  context,

                  MaterialPageRoute(

                    builder: (_)

                    => ChatScreen(

                      bookingId: bookingId,

                    ),

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