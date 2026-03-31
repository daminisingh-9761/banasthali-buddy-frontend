import 'package:flutter/material.dart';
import 'buy_item_screen.dart';
import 'post_item_screen.dart';

class StudentExchangeHome extends StatelessWidget {
  const StudentExchangeHome({super.key});

  @override
  Widget build(BuildContext context) {

    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        children: [

          /// PREMIUM HEADER
          Container(
            height: height * 0.32,
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

            child: Padding(
              padding: const EdgeInsets.only(
                top: 65,
                left: 18,
                right: 18,
              ),

              child: Column(
                children: [

                  Row(
                    children: [

                      IconButton(
                        icon: const Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),

                    ],
                  ),

                  const SizedBox(height: 5),

                  const Text(
                    "Student Exchange Hub",
                    style: TextStyle(
                      fontSize: 26,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2,
                    ),
                  ),

                  const SizedBox(height: 6),

                  const Text(
                    "Buy & Sell items easily within campus",
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                    ),
                  ),

                ],
              ),
            ),
          ),

          /// WHITE SECTION
          Align(
            alignment: Alignment.bottomCenter,

            child: Container(
              height: height * 0.72,
              padding: const EdgeInsets.symmetric(
                horizontal: 25,
                vertical: 30,
              ),

              decoration: BoxDecoration(
                color: const Color(0xFFE6F4F1),

                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(35),
                  topRight: Radius.circular(35),
                ),

                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.12),
                    blurRadius: 20,
                    offset: const Offset(0, -8),
                  ),
                ],
              ),

              child: Stack(
                children: [

                  /// background arrow graphic
                  Center(
                    child: Opacity(
                      opacity: 0.10,
                      child: Image.asset(
                        "assets/images/exchange_arrow.png",
                        width: 700,
                      ),
                    ),
                  ),

                  /// BUY BUTTON
                  Align(
                    alignment: const Alignment(0,-0.12),

                    child: Container(
                      width: double.infinity,
                      height: 75,

                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),

                        boxShadow: [

                          BoxShadow(
                            color: const Color(0xFF2F6F6D)
                                .withOpacity(0.35),
                            blurRadius: 18,
                            offset: const Offset(0,8),
                          ),

                        ],
                      ),

                      child: ElevatedButton.icon(

                        style: ElevatedButton.styleFrom(

                          backgroundColor:
                          const Color(0xFF2F6F6D),

                          shape:
                          RoundedRectangleBorder(
                            borderRadius:
                            BorderRadius.circular(20),
                          ),

                          padding:
                          const EdgeInsets.symmetric(
                              horizontal: 20
                          ),

                        ),

                        icon: const Icon(
                          Icons.shopping_bag,
                          size: 24,
                        ),

                        label: const Text(

                          "Buy Items",

                          style: TextStyle(
                            fontSize: 19,
                            fontWeight: FontWeight.bold,
                          ),

                        ),

                        onPressed: () {

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) =>
                              const BuyItemScreen(),
                            ),
                          );

                        },

                      ),
                    ),
                  ),

                  /// SELL BUTTON
                  Align(
                    alignment: const Alignment(0,0.35),

                    child: Container(
                      width: double.infinity,
                      height: 75,

                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),

                        boxShadow: [

                          BoxShadow(
                            color: const Color(0xFF4A9C97)
                                .withOpacity(0.35),
                            blurRadius: 18,
                            offset: const Offset(0,8),
                          ),

                        ],
                      ),

                      child: ElevatedButton.icon(

                        style: ElevatedButton.styleFrom(

                          backgroundColor:
                          const Color(0xFF4A9C97),

                          shape:
                          RoundedRectangleBorder(
                            borderRadius:
                            BorderRadius.circular(20),
                          ),

                          padding:
                          const EdgeInsets.symmetric(
                              horizontal: 20
                          ),

                        ),

                        icon: const Icon(
                          Icons.sell,
                          size: 24,
                        ),

                        label: const Text(

                          "Sell Items",

                          style: TextStyle(
                            fontSize: 19,
                            fontWeight: FontWeight.bold,
                          ),

                        ),

                        onPressed: () {

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) =>
                              const PostItemScreen(),
                            ),
                          );

                        },

                      ),
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