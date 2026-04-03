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
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      /// 🔵 HEADER (THEME + WHITE TEXT + SHADOW)
      appBar: AppBar(
        backgroundColor: const Color(0xFF2F6F6D),
        title: const Text(
          "Driver Assigned",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            shadows: [
              Shadow(
                blurRadius: 4,
                color: Colors.black26,
                offset: Offset(1, 2),
              ),
            ],
          ),
        ),
        centerTitle: true,
      ),

      /// 🔹 BODY WITH BACKGROUND
      body: Stack(
        children: [

          /// 🔹 FULL BACKGROUND
          Positioned.fill(
            child: Image.asset(
              "assets/images/route.jpeg",
              fit: BoxFit.cover,
            ),
          ),

          /// 🔹 CONTENT (FIXED HEIGHT ISSUE)
          SizedBox.expand(   // ✅ ADD THIS
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: loading
                  ? const Center(child: CircularProgressIndicator())
                  : rides.isEmpty
                  ? const Center(child: Text("No Ride Found"))
                  : Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [

                  Container(
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.9),
                      borderRadius: BorderRadius.circular(15),
                    ),
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
                      ],
                    ),
                  ),

                  const SizedBox(height: 30),

                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF2F6F6D),
                    ),
                    child: const Text("Chat with Driver"),

                    onPressed: () {
                      String bookingId = rides.last["id"].toString();

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => ChatScreen(
                            bookingId: bookingId,
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}