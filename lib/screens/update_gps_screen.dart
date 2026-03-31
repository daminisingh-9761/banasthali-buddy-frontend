import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'driver_home_screen.dart';

class UpdateGPSScreen extends StatefulWidget {
  const UpdateGPSScreen({super.key});

  @override
  State<UpdateGPSScreen> createState() => _UpdateGPSScreenState();
}

class _UpdateGPSScreenState extends State<UpdateGPSScreen> {

  bool isSharing = false;
  String locationStatus = "Location Sharing: OFF";
  String lastUpdated = "Not Updated Yet";

  Timer? timer;

  /// ✅ changed API endpoint
  String apiUrl =
      "https://banasthali-buddy-backend.onrender.com/api/driver/location";

  /// start GPS sharing
  void startSharing() async {

    bool serviceEnabled =
    await Geolocator.isLocationServiceEnabled();

    if(!serviceEnabled){
      locationStatus = "Turn ON device location";
      setState(() {});
      return;
    }

    LocationPermission permission =
    await Geolocator.checkPermission();

    if(permission == LocationPermission.denied){

      permission =
      await Geolocator.requestPermission();

    }

    setState(() {
      isSharing = true;
      locationStatus = "Location Sharing: ON";
    });

    timer = Timer.periodic(

      const Duration(seconds: 5),

          (timer) async {

        Position position =
        await Geolocator.getCurrentPosition();

        /// ✅ changed POST → PUT
        await http.put(

          Uri.parse(apiUrl),

          headers: {
            "Content-Type":"application/json"
          },

          /// ✅ removed busId
          body: jsonEncode({

            "latitude": position.latitude,

            "longitude": position.longitude

          }),

        );

        setState(() {

          lastUpdated =
              DateTime.now().toString();

        });

      },

    );

  }

  /// stop GPS sharing
  void stopSharing(){

    timer?.cancel();

    setState(() {

      isSharing = false;

      locationStatus = "Location Sharing: OFF";

      lastUpdated = DateTime.now().toString();

    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF2F6F6D),
      body: Column(
        children: [

          const SizedBox(height: 70),

          Row(
            children: [
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.arrow_back, color: Colors.white),
              ),
              const Expanded(
                child: Text(
                  "Update GPS Location",
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
              padding: const EdgeInsets.all(25),
              decoration: const BoxDecoration(
                color: Color(0xFFE6F4F1),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  const Text(
                    "Current Status",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),

                  const SizedBox(height: 10),

                  Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(locationStatus),
                          const SizedBox(height: 5),
                          Text("Last Updated: $lastUpdated"),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 25),

                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF2F6F6D),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: isSharing ? null : startSharing,
                      child: const Text("Start Sharing Location"),
                    ),
                  ),

                  const SizedBox(height: 15),

                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Color(0xFF2F6F6D)),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: isSharing ? stopSharing : null,
                      child: const Text(
                        "Stop Sharing Location",
                        style: TextStyle(color: Color(0xFF2F6F6D)),
                      ),
                    ),
                  ),

                  const Spacer(),

                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey.shade700,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const DriverHomeScreen()),
                              (route) => false,
                        );
                      },
                      child: const Text("Go to Driver Dashboard"),
                    ),
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