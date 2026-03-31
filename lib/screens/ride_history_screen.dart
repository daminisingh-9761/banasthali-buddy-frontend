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
    if(token == null) return;
    List all =
    await ApiService.getDriverBookings(token!);
    rideHistory =
        all.where(
                (b) =>
            b["status"] == "COMPLETED"
        ).toList();
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
      const Color(0xFF2F6F6D),
      body: Column(
        children: [
          const SizedBox(height: 70),
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
                  ),
                ),
              ),
              const SizedBox(width: 48),
            ],
          ),
          const SizedBox(height: 20),
          Expanded(
            child: Container(
              padding:
              const EdgeInsets.all(25),
              decoration:
              const BoxDecoration(
                color:
                Color(0xFFE6F4F1),
                borderRadius:
                BorderRadius.only(
                  topLeft:
                  Radius.circular(40),
                  topRight:
                  Radius.circular(40),
                ),
              ),
              child:
              isLoading
                  ? const Center(
                child:
                CircularProgressIndicator(),
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
                itemCount:
                rideHistory.length,
                itemBuilder:
                    (context, index) {
                  final ride =
                  rideHistory[index];
                  return Card(
                    shape:
                    RoundedRectangleBorder(
                      borderRadius:
                      BorderRadius.circular(15),
                    ),
                    margin:
                    const EdgeInsets.only(
                        bottom: 15),
                    child: Padding(
                      padding:
                      const EdgeInsets.all(15),
                      child: Column(
                        crossAxisAlignment:
                        CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Passenger ID: ${ride["passengerId"]}",
                            style:
                            const TextStyle(
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
          Container(
            color:
            const Color(0xFFE6F4F1),
            padding:
            const EdgeInsets.fromLTRB(
                25,
                0,
                25,
                25),
            child: SizedBox(
              width:
              double.infinity,
              height: 50,
              child: ElevatedButton(
                style:
                ElevatedButton.styleFrom(
                  backgroundColor:
                  Colors.grey.shade700,
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
    );
  }
}