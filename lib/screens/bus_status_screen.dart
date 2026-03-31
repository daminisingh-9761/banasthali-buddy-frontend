import 'package:flutter/material.dart';
import 'bus_map_screen.dart';

class BusStatusScreen extends StatelessWidget {
  final String routeName;

  const BusStatusScreen({super.key, required this.routeName});

  @override
  Widget build(BuildContext context) {

    bool isBusActive = true;

    return Scaffold(

      appBar: AppBar(

        backgroundColor: const Color(0xFF2F6F6D),

        title: const Text(
          "Bus Status",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            letterSpacing: 1,
          ),
        ),

        centerTitle: true,
      ),

      body: Stack(

        children: [

          /// background same as route screen
          Positioned.fill(
            child: Image.asset(
              "assets/images/route.jpeg",
              fit: BoxFit.cover,
            ),
          ),

          /// content card style
          Center(

            child: Padding(

              padding: const EdgeInsets.all(20),

              child: Container(

                padding: const EdgeInsets.all(25),

                decoration: BoxDecoration(

                  color: Colors.white.withOpacity(0.9),

                  borderRadius: BorderRadius.circular(18),

                  boxShadow: [

                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                      offset: const Offset(0,4),
                    ),

                  ],

                ),

                child: isBusActive

                    ? Column(

                  mainAxisSize: MainAxisSize.min,

                  children: [

                    const Icon(
                      Icons.directions_bus,
                      size: 60,
                      color: Color(0xFF2F6F6D),
                    ),

                    const SizedBox(height: 10),

                    const Text(

                      "Bus is Active",

                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),

                    ),

                    const SizedBox(height: 20),

                    SizedBox(

                      width: double.infinity,

                      height: 50,

                      child: ElevatedButton(

                        style: ElevatedButton.styleFrom(

                          backgroundColor:
                          const Color(0xFF2F6F6D),

                          shape: RoundedRectangleBorder(
                            borderRadius:
                            BorderRadius.circular(12),
                          ),

                        ),

                        onPressed: () {

                          Navigator.push(

                            context,

                            MaterialPageRoute(
                              builder: (_) =>
                                  BusMapScreen(
                                      routeName: routeName),
                            ),

                          );

                        },

                        child: const Text(

                          "View Live Location",

                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),

                        ),

                      ),

                    ),

                  ],

                )

                    : const Text(

                  "Bus Not Active",

                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.red,
                  ),

                ),

              ),

            ),

          ),

        ],

      ),

    );

  }

}