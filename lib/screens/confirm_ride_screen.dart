import 'package:flutter/material.dart';
import '../services/booking_service.dart';
import 'driver_assigned_screen.dart';

class ConfirmRideScreen extends StatefulWidget {
  final String pickup;
  final String drop;

  const ConfirmRideScreen({
    super.key,
    required this.pickup,
    required this.drop,
  });

  @override
  State<ConfirmRideScreen> createState() => _ConfirmRideScreenState();
}

class _ConfirmRideScreenState extends State<ConfirmRideScreen> {

  final BookingService bookingService = BookingService();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      /// ✅ HEADER UPDATED
      appBar: AppBar(
        backgroundColor: const Color(0xFF2F6F6D),
        title: const Text(
          "Confirm Ride",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            letterSpacing: 1,
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

      /// ✅ BODY WITH BACKGROUND
      body: Stack(
        children: [

          /// 🔹 BACKGROUND IMAGE
          Positioned.fill(
            child: Image.asset(
              "assets/images/pick_bg.jpeg",
              fit: BoxFit.cover,
            ),
          ),

          /// 🔹 CONTENT
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [

                /// 🟢 CARD FOR DETAILS
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.85),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    children: [

                      Row(
                        children: [
                          const Icon(Icons.my_location,
                              color: Color(0xFF2F6F6D)),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              "Pickup: ${widget.pickup}",
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 10),

                      Row(
                        children: [
                          const Icon(Icons.location_on,
                              color: Color(0xFF2F6F6D)),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              "Drop: ${widget.drop}",
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 15),

                      const Divider(),

                      const SizedBox(height: 10),

                      const Text(
                        "Estimated Fare: ₹30",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),

                      const SizedBox(height: 5),

                      const Text(
                        "Estimated Time: 10 mins",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 40),

                /// 🔘 BUTTON
                isLoading
                    ? const CircularProgressIndicator()
                    : SizedBox(
                  width: 200,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF2F6F6D),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      "Confirm Ride",
                      style: TextStyle(fontSize: 16),
                    ),
                    onPressed: () async {

                      setState(() {
                        isLoading = true;
                      });

                      final result = await bookingService.requestRide(
                        widget.pickup,
                        widget.drop,
                      );

                      print(result);

                      setState(() {
                        isLoading = false;
                      });

                      if (result != null) {

                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Ride requested successfully"),
                          ),
                        );

                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                            const DriverAssignedScreen(),
                          ),
                        );
                      } else {

                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Ride request failed"),
                          ),
                        );
                      }
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