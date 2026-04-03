import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/api_service.dart';
import 'driver_home_screen.dart';

class RideHistoryScreen extends StatefulWidget {
  const RideHistoryScreen({super.key});

  @override
  State<RideHistoryScreen> createState() => _RideHistoryScreenState();
}

class _RideHistoryScreenState extends State<RideHistoryScreen> {

  List rideHistory = [];
  String? token;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadToken();
  }

  Future<void> loadToken() async {
    final prefs =
    await SharedPreferences.getInstance();

    token =
        prefs.getString("token");

    loadRideHistory();
  }

  Future<void> loadRideHistory() async {

    if(token == null){
      setState(() {
        isLoading = false;
      });
      return;
    }

    List all =
    await ApiService.getDriverBookings(token!);

    rideHistory =
        all.where(
                (b) => b["status"] == "COMPLETED"
        ).toList();

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      /// 🔹 FULL BACKGROUND IMAGE
      body: Stack(
        children: [

          Positioned.fill(
            child: Image.asset(
              "assets/images/route.jpeg",
              fit: BoxFit.cover,
            ),
          ),

          Column(
            children: [

              const SizedBox(height: 70),

              /// 🔵 HEADER (UPDATED)
              Row(
                children: [

                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    ),
                  ),

                  const Expanded(
                    child: Text(
                      "Ride History",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        shadows: [
                          Shadow(
                            blurRadius: 4,
                            color: Colors.black26,
                            offset: Offset(1, 2),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(width: 48),
                ],
              ),

              const SizedBox(height: 20),

              /// 🔹 CONTENT CONTAINER
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(25),

                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.85), // ✅ FIX
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40),
                    ),
                  ),

                  child:
                  isLoading
                      ? const Center(
                    child: CircularProgressIndicator(),
                  )
                      :
                  rideHistory.isEmpty
                      ? const Center(
                    child: Text(
                      "No Ride History Available",
                    ),
                  )
                      :
                  ListView.builder(
                    itemCount: rideHistory.length,
                    itemBuilder:
                        (context, index) {

                      final ride =
                      rideHistory[index];

                      return Card(
                        color: Colors.white.withOpacity(0.9), // ✅ visibility
                        shape: RoundedRectangleBorder(
                          borderRadius:
                          BorderRadius.circular(15),
                        ),
                        margin:
                        const EdgeInsets.only(bottom: 15),

                        child: Padding(
                          padding:
                          const EdgeInsets.all(15),

                          child: Column(
                            crossAxisAlignment:
                            CrossAxisAlignment.start,

                            children: [

                              Text(
                                "Passenger ID: ${ride["passengerId"]}",
                                style: const TextStyle(
                                  fontWeight:
                                  FontWeight.bold,
                                ),
                              ),

                              const SizedBox(height: 5),

                              Text(
                                "${ride["pickupPostId"]} → ${ride["destinationPostId"]}",
                              ),

                              const SizedBox(height: 5),

                              Text(
                                "Status: ${ride["status"]}",
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),

              /// 🔹 BUTTON SECTION
              Container(
                color: Colors.white.withOpacity(0.85), // ✅ FIX
                padding: const EdgeInsets.fromLTRB(25, 0, 25, 25),

                child: SizedBox(
                  width: double.infinity,
                  height: 50,

                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF2F6F6D),
                    ),
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                          const DriverHomeScreen(),
                        ),
                            (route) => false,
                      );
                    },
                    child: const Text(
                      "Go to Driver Dashboard",
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}