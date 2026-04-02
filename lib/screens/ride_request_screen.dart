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

    /// show only PENDING rides

    bookings =
        all.where(

                (b)=>
            b["status"]=="PENDING"

        ).toList();

    if (!mounted) return;

    setState(() {

      isLoading = false;

    });

  }


  /// accept ride
  Future<void> acceptRide(

      String bookingId

      ) async {

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

      appBar: AppBar(

        title:
        const Text("Ride Requests"),

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

        child: Text(

          "No ride requests",

        ),

      )

          :

      ListView.builder(

        itemCount:
        bookings.length,

        itemBuilder: (_, i){

          var b = bookings[i];

          return Card(

            margin:
            const EdgeInsets.all(10),

            child: ListTile(

              title: Text(

                "Pickup: ${b["pickupPostId"]}",

              ),

              subtitle: Text(

                "Destination: ${b["destinationPostId"]}",

              ),

              trailing: ElevatedButton(

                onPressed: (){

                  acceptRide(

                    b["id"],

                  );

                },

                child:
                const Text("Accept"),

              ),

            ),

          );

        },

      ),

    );

  }

}