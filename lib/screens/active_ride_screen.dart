import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/api_service.dart';

class ActiveRideScreen extends StatefulWidget {
  const ActiveRideScreen({super.key});

  @override
  State<ActiveRideScreen> createState() =>
      _ActiveRideScreenState();
}

class _ActiveRideScreenState
    extends State<ActiveRideScreen> {

  List bookings = [];
  String? token;
  bool isLoading = true;

  @override
  void initState(){
    super.initState();
    loadToken();
  }

  /// get token
  Future<void> loadToken() async {
    final prefs =
    await SharedPreferences.getInstance();

    token = prefs.getString("token");

    loadActiveRide();
  }

  /// get active ride
  Future<void> loadActiveRide() async {

    if(token == null) return;

    List all =
    await ApiService.getDriverBookings(token!);

    bookings =
        all.where(
                (b) =>
            b["status"] == "ACCEPTED" ||
                b["status"] == "ARRIVED" ||
                b["status"] == "STARTED"
        ).toList();

    setState(() {
      isLoading = false;
    });
  }

  /// update ride status
  Future<void> updateStatus(
      String bookingId,
      String status
      ) async {

    await ApiService.updateBookingStatus(
      token!,
      bookingId,
      status,
    );

    loadActiveRide();
  }

  @override
  Widget build(BuildContext context){

    return Scaffold(

      /// 🔵 HEADER (THEME + SHADOW)
      appBar: AppBar(
        backgroundColor: const Color(0xFF2F6F6D),
        title: const Text(
          "Active Ride",
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

          /// 🔹 BACKGROUND IMAGE
          Positioned.fill(
            child: Image.asset(
              "assets/images/route.jpeg",
              fit: BoxFit.cover,
            ),
          ),

          /// 🔹 CONTENT
          isLoading
              ? const Center(
            child: CircularProgressIndicator(),
          )
              : bookings.isEmpty
              ? const Center(
            child: Text(
              "No active ride",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          )
              : ListView.builder(
            itemCount: bookings.length,
            itemBuilder: (_, i){

              var b = bookings[i];

              return Card(
                color: Colors.white.withOpacity(0.9), // ✅ visible on bg
                margin: const EdgeInsets.all(12),

                child: Padding(
                  padding: const EdgeInsets.all(16),

                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [

                      Text(
                        "Pickup: ${b["pickupPostId"]}",
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 6),

                      Text(
                        "Destination: ${b["destinationPostId"]}",
                      ),

                      const SizedBox(height: 15),

                      Wrap(
                        spacing: 10,

                        children: [

                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF2F6F6D),
                            ),
                            onPressed: (){
                              updateStatus(
                                b["id"],
                                "ARRIVED",
                              );
                            },
                            child: const Text("Arrived"),
                          ),

                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF2F6F6D),
                            ),
                            onPressed: (){
                              updateStatus(
                                b["id"],
                                "STARTED",
                              );
                            },
                            child: const Text("Start"),
                          ),

                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF2F6F6D),
                            ),
                            onPressed: (){
                              updateStatus(
                                b["id"],
                                "COMPLETED",
                              );
                            },
                            child: const Text("Complete"),
                          ),

                        ],
                      ),

                    ],
                  ),
                ),
              );

            },
          ),
        ],
      ),
    );
  }
}