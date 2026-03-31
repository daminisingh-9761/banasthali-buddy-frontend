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
            b["status"] == "ACCEPTED"
                ||
                b["status"] == "ARRIVED"
                ||
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

      appBar: AppBar(

        title:
        const Text("Active Ride"),

      ),

      body:

      isLoading

          ? const Center(

        child:
        CircularProgressIndicator(),

      )

          :

      bookings.isEmpty

          ? const Center(

        child:
        Text("No active ride"),

      )

          :

      ListView.builder(

        itemCount:
        bookings.length,

        itemBuilder: (_, i){

          var b = bookings[i];

          return Card(

            margin:
            const EdgeInsets.all(12),

            child: Padding(

              padding:
              const EdgeInsets.all(16),

              child: Column(

                crossAxisAlignment:
                CrossAxisAlignment.start,

                children: [

                  Text(

                    "Pickup: ${b["pickupPostId"]}",

                    style:
                    const TextStyle(

                      fontSize: 16,
                      fontWeight:
                      FontWeight.bold,

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

                        onPressed: (){

                          updateStatus(

                            b["id"],
                            "ARRIVED",

                          );

                        },

                        child:
                        const Text("Arrived"),

                      ),

                      ElevatedButton(

                        onPressed: (){

                          updateStatus(

                            b["id"],
                            "STARTED",

                          );

                        },

                        child:
                        const Text("Start"),

                      ),

                      ElevatedButton(

                        onPressed: (){

                          updateStatus(

                            b["id"],
                            "COMPLETED",

                          );

                        },

                        child:
                        const Text("Complete"),

                      ),

                    ],

                  ),

                ],

              ),

            ),

          );

        },

      ),

    );

  }

}