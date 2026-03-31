import 'package:flutter/material.dart';
import 'student_exchange_screen.dart';
import 'erickshaw_booking_screen.dart';
import 'bus_tracking_screen.dart';
import 'settings_screen.dart';
import 'package:animated_background/animated_background.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with TickerProviderStateMixin {

  Widget buildSection({
    required BuildContext context,
    required String title,
    required String subtitle,
    required String imagePath,
    required VoidCallback onTap,
  }) {

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 10),

      child: InkWell(
        borderRadius: BorderRadius.circular(30),
        onTap: onTap,

        child: Container(

          padding: const EdgeInsets.all(18),

          decoration: BoxDecoration(

            color: Colors.white.withOpacity(0.9),

            borderRadius: BorderRadius.circular(30),

            border: Border.all(
              color: Colors.white.withOpacity(0.6),
            ),

            boxShadow: [

              BoxShadow(
                color: Colors.black.withOpacity(0.08),
                blurRadius: 25,
                offset: const Offset(0,10),
              ),

              BoxShadow(
                color: Colors.white.withOpacity(0.9),
                blurRadius: 10,
                offset: const Offset(-4,-4),
              ),

            ],

          ),

          child: Row(

            children: [

              Container(

                width: 70,
                height: 70,

                decoration: BoxDecoration(

                  shape: BoxShape.circle,

                  gradient: const LinearGradient(

                    colors: [
                      Color(0xFFE6F4F1),
                      Colors.white
                    ],

                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,

                  ),

                  boxShadow: [

                    BoxShadow(
                      color: const Color(0xFF2F6F6D)
                          .withOpacity(0.15),
                      blurRadius: 15,
                      offset: const Offset(0,6),
                    )

                  ],

                ),

                child: Padding(
                  padding: const EdgeInsets.all(12),

                  child: Image.asset(
                    imagePath,
                    fit: BoxFit.contain,
                  ),

                ),

              ),

              const SizedBox(width: 18),

              Expanded(

                child: Column(

                  crossAxisAlignment:
                  CrossAxisAlignment.start,

                  children: [

                    Text(

                      title,

                      style: const TextStyle(

                        fontSize: 18,

                        fontWeight: FontWeight.bold,

                        letterSpacing: 0.4,

                      ),

                    ),

                    const SizedBox(height: 5),

                    Text(

                      subtitle,

                      style: TextStyle(

                        fontSize: 13,

                        color: Colors.grey.shade600,

                      ),

                    ),

                  ],

                ),

              ),

              Container(

                padding: const EdgeInsets.all(10),

                decoration: BoxDecoration(

                  color: const Color(0xFF2F6F6D),

                  borderRadius:
                  BorderRadius.circular(16),

                  boxShadow: [

                    BoxShadow(
                      color: const Color(0xFF2F6F6D)
                          .withOpacity(0.4),
                      blurRadius: 12,
                      offset: const Offset(0,6),
                    )

                  ],

                ),

                child: const Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.white,
                  size: 16,
                ),

              ),

            ],

          ),

        ),

      ),

    );

  }

  @override
  Widget build(BuildContext context) {

    final height =
        MediaQuery.of(context).size.height;

    return Scaffold(

      body: Stack(

        children: [

          /// ✅ background image added
          Positioned.fill(
            child: Image.asset(
              "assets/images/route.jpeg",
              fit: BoxFit.cover,
            ),
          ),

          AnimatedBackground(

            behaviour: RandomParticleBehaviour(

              options: ParticleOptions(

                baseColor: Colors.white,

                spawnOpacity: 0.10,

                opacityChangeRate: 0.25,

                minOpacity: 0.05,

                maxOpacity: 0.15,

                spawnMinSpeed: 10,

                spawnMaxSpeed: 25,

                particleCount: 22,

              ),

            ),

            vsync: this,

            child: Container(

              height: height * 0.30,

              decoration: const BoxDecoration(

                gradient: LinearGradient(

                  colors: [

                    Color(0xFF2F6F6D),
                    Color(0xFF4A9C97),

                  ],

                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,

                ),

              ),

              child: Stack(

                children: [

                  Opacity(

                    opacity: 0.15,

                    child: Image.asset(

                      "assets/images/bg.png",

                      fit: BoxFit.cover,

                      width: double.infinity,
                      height: double.infinity,

                    ),

                  ),

                  Padding(

                    padding: const EdgeInsets.only(
                        top: 75,
                        left: 24,
                        right: 24
                    ),

                    child: Column(

                      crossAxisAlignment:
                      CrossAxisAlignment.start,

                      children: [

                        Row(

                          mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,

                          children: [

                            const Text(

                              "Banasthali Buddy",

                              style: TextStyle(

                                fontSize: 24,

                                fontWeight: FontWeight.bold,

                                color: Colors.white,

                                letterSpacing: 1.2,

                              ),

                            ),

                            Container(

                              decoration: BoxDecoration(

                                color: Colors.white
                                    .withOpacity(0.2),

                                shape: BoxShape.circle,

                              ),

                              child: IconButton(

                                icon: const Icon(
                                    Icons.settings,
                                    color: Colors.white
                                ),

                                onPressed: () {

                                  Navigator.push(

                                    context,

                                    MaterialPageRoute(

                                      builder: (_) =>
                                      const SettingsScreen(
                                          role: "student"
                                      ),

                                    ),

                                  );

                                },

                              ),

                            ),

                          ],

                        ),

                        const SizedBox(height: 22),

                        const Text(

                          "Welcome back 👋",

                          style: TextStyle(

                            fontSize: 24,

                            color: Colors.white,

                            fontWeight: FontWeight.bold,

                          ),

                        ),

                        const SizedBox(height: 6),

                        const Text(

                          "Your campus services in one place",

                          style: TextStyle(

                            color: Colors.white70,

                            fontSize: 15,

                          ),

                        ),

                      ],

                    ),

                  ),

                ],

              ),

            ),

          ),

          Align(

            alignment: Alignment.bottomCenter,

            child: Container(

              height: height * 0.72,

              padding: const EdgeInsets.only(
                  top: 30
              ),

              decoration: BoxDecoration(

                color: const Color(0xFFE6F4F1),

                borderRadius: BorderRadius.zero,

                boxShadow: [

                  BoxShadow(

                    color: Colors.black.withOpacity(0.15),

                    blurRadius: 25,

                    offset: const Offset(0,-10),

                  ),

                ],

              ),

              child: Column(

                children: [

                  buildSection(

                    context: context,

                    title:
                    "Student Exchange Hub",

                    subtitle:
                    "Buy & sell easily",

                    imagePath:
                    "assets/images/exchange.png",

                    onTap: () {

                      Navigator.push(

                        context,

                        MaterialPageRoute(

                          builder: (_) =>
                          const StudentExchangeHome(),

                        ),

                      );

                    },

                  ),

                  buildSection(

                    context: context,

                    title:
                    "Bus Tracking",

                    subtitle:
                    "Live campus bus tracking",

                    imagePath:
                    "assets/images/bus.png",

                    onTap: () {

                      Navigator.push(

                        context,

                        MaterialPageRoute(

                          builder: (_) =>
                          const BusTrackingScreen(),

                        ),

                      );

                    },

                  ),

                  buildSection(

                    context: context,

                    title:
                    "E-Rickshaw Booking",

                    subtitle:
                    "Book ride instantly",

                    imagePath:
                    "assets/images/rickshaw.png",

                    onTap: () {

                      Navigator.push(

                        context,

                        MaterialPageRoute(

                          builder: (_) =>
                          const ErickshawBookingScreen(),

                        ),

                      );

                    },

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