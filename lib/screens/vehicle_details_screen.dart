import 'package:flutter/material.dart';

class VehicleDetailsScreen extends StatefulWidget {
  const VehicleDetailsScreen({super.key});

  @override
  State<VehicleDetailsScreen> createState() => _VehicleDetailsScreenState();
}

class _VehicleDetailsScreenState extends State<VehicleDetailsScreen> {

  final TextEditingController vehicleNumber = TextEditingController();
  final TextEditingController vehicleType = TextEditingController();
  final TextEditingController driverName = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      /// 🔵 HEADER
      appBar: AppBar(
        backgroundColor: const Color(0xFF2F6F6D),
        title: const Text(
          "Vehicle Details",
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

          /// 🔹 FORM
          Padding(
            padding: const EdgeInsets.all(16),
            child: SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.all(16),

                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.85),
                  borderRadius: BorderRadius.circular(20),
                ),

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    /// 🚗 VEHICLE NUMBER
                    _inputField("Vehicle Number", vehicleNumber),

                    const SizedBox(height: 15),

                    /// 🚙 VEHICLE TYPE
                    _inputField("Vehicle Type (E-Rickshaw)", vehicleType),

                    const SizedBox(height: 15),

                    /// 👤 DRIVER NAME
                    _inputField("Driver Name", driverName),

                    const SizedBox(height: 25),

                    /// ✅ SAVE BUTTON
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
                              content: Text("Vehicle Details Saved"),
                            ),
                          );

                        },
                        child: const Text(
                          "Save Details",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                          ),
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

  /// 🔹 INPUT FIELD UI
  Widget _inputField(String label, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        Text(
          label,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
          ),
        ),

        const SizedBox(height: 5),

        TextField(
          controller: controller,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ],
    );
  }
}