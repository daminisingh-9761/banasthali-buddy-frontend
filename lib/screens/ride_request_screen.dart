import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/api_service.dart';

class RideRequestScreen extends StatefulWidget {
  const RideRequestScreen({super.key});

  @override
  State<RideRequestScreen> createState() =>
      _RideRequestScreenState();
}

class _RideRequestScreenState
    extends State<RideRequestScreen> {

  List bookings = [];
  String? token;
  bool isLoading = true;

  @override
  void initState(){
    super.initState();
    loadToken();
  }

  /// load token
  Future<void> loadToken() async {
    final prefs =
    await SharedPreferences.getInstance();

    token = prefs.getString("token");

    loadBookings();
  }

  /// get pending bookings
  Future<void> loadBookings() async {

    if(token == null) return;

    List all =
    await ApiService.getDriverBookings(token!);

    bookings =
        all.where(
                (b)=> b["status"]=="PENDING"
        ).toList();

    if (!mounted) return;

    setState(() {
      isLoading = false;
    });
  }

  /// accept ride
  Future<void> acceptRide(String bookingId) async {

    await ApiService.updateBookingStatus(
      token!,
      bookingId,
      "ACCEPTED",
    );

    loadBookings();
  }

  @override
  Widget build(BuildContext context){

    return Scaffold(

      /// 🔵 HEADER (THEME SAME + SHADOW TEXT)
      appBar: AppBar(
        backgroundColor: const Color(0xFF2F6F6D),
        title: const Text(
          "Ride Requests",
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
              "No ride requests",
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
                margin: const EdgeInsets.all(10),

                child: ListTile(

                  title: Text(
                    "Pickup: ${b["pickupPostId"]}",
                  ),

                  subtitle: Text(
                    "Destination: ${b["destinationPostId"]}",
                  ),

                  trailing: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF2F6F6D),
                    ),
                    onPressed: (){
                      acceptRide(b["id"]);
                    },
                    child: const Text("Accept"),
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