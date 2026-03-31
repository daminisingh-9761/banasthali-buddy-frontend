import 'package:flutter/material.dart';

class DriverAvailabilityScreen extends StatefulWidget {
  const DriverAvailabilityScreen({super.key});

  @override
  State<DriverAvailabilityScreen> createState() => _DriverAvailabilityScreenState();
}

class _DriverAvailabilityScreenState extends State<DriverAvailabilityScreen> {

  bool isAvailable = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      /// 🔵 HEADER
      appBar: AppBar(
        backgroundColor: const Color(0xFF2F6F6D),
        title: const Text(
          "Availability",
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

      /// 🔹 BODY
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
          Center(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Container(
                padding: const EdgeInsets.all(20),

                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.85),
                  borderRadius: BorderRadius.circular(20),
                ),

                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [

                    /// 🚗 TITLE
                    const Text(
                      "Driver Status",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 20),

                    /// 🔘 SWITCH
                    Switch(
                      value: isAvailable,
                      activeColor: const Color(0xFF2F6F6D),
                      onChanged: (value) {
                        setState(() {
                          isAvailable = value;
                        });

                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              isAvailable
                                  ? "You are now ONLINE"
                                  : "You are now OFFLINE",
                            ),
                          ),
                        );
                      },
                    ),

                    const SizedBox(height: 10),

                    /// 🔹 STATUS TEXT
                    Text(
                      isAvailable ? "ONLINE" : "OFFLINE",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: isAvailable ? Colors.green : Colors.red,
                      ),
                    ),

                    const SizedBox(height: 25),

                    /// 💾 SAVE BUTTON (optional but good UX)
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF2F6F6D),
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onPressed: () {

                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Availability Updated"),
                            ),
                          );

                        },
                        child: const Text(
                          "Save Status",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}