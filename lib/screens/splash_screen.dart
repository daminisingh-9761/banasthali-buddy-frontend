import 'dart:async';
import 'package:flutter/material.dart';
import 'package:frontend/screens/login_screen.dart';
import '../services/api_service.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();

    // wake up render backend
    ApiService.pingServer();

    // navigate to login after delay
    Timer(const Duration(seconds: 10), () {

      if(mounted){

        Navigator.pushReplacement(

          context,

          MaterialPageRoute(

            builder: (_) => const LoginScreen(),

          ),

        );

      }

    });

  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body: Container(

        decoration: const BoxDecoration(

          gradient: LinearGradient(

            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,

            colors: [

              Color(0xFFE6F4F1),
              Color(0xFFCDEAE4),

            ],

          ),

        ),

        child: Center(

          child: Column(

            mainAxisAlignment: MainAxisAlignment.center,

            children: [

              // LOGO
              Image.asset(

                'assets/images/LOGO.png',
                height: 600,

              ),

              const SizedBox(height: 20),

              const CircularProgressIndicator(),

              const SizedBox(height: 10),

              const Text(

                "Loading...",
                style: TextStyle(

                  color: Colors.black54,
                  fontSize: 16,

                ),

              )

            ],

          ),

        ),

      ),

    );

  }

}