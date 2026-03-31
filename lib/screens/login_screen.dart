import 'package:flutter/material.dart';
import 'package:frontend/screens/home_screen.dart';
import 'package:frontend/screens/driver_home_screen.dart';
import 'package:frontend/screens/admin_home_screen.dart';
import 'package:frontend/screens/signup_screen.dart';
import '../services/api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'forgot_password_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();


  final ApiService apiService = ApiService();
  bool isLoading = false;

  // ✅ NEW: Password visibility
  bool isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [

          /// 🔵 TOP GRADIENT
          Container(
            height: MediaQuery.of(context).size.height * 0.20,
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
            alignment: Alignment.center,
            child: const Padding(
              padding: EdgeInsets.only(top: 44),
              child: Text(
                "Login",
                style: TextStyle(
                  fontSize: 32,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),

          /// 🔵 ROUNDED CONTAINER
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.85,
              padding: const EdgeInsets.all(25),
              decoration: BoxDecoration(
                image: const DecorationImage(
                  image: AssetImage("assets/images/route.jpeg"),
                  fit: BoxFit.cover,
                ),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.15),
                    blurRadius: 15,
                    offset: const Offset(0, -5),
                  ),
                ],
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [

                    const SizedBox(height: 20),

                    /// Email
                    TextFormField(
                      controller: emailController,
                      decoration: InputDecoration(
                        labelText: "Email",
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),

                    const SizedBox(height: 15),

                    /// Password (UPDATED)
                    TextFormField(
                      controller: passwordController,
                      obscureText: !isPasswordVisible,
                      decoration: InputDecoration(
                        labelText: "Password",
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            isPasswordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                          onPressed: () {
                            setState(() {
                              isPasswordVisible = !isPasswordVisible;
                            });
                          },
                        ),
                      ),
                    ),

                    /// ✅ Forgot Password Button
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const ForgotPasswordScreen(),
                            ),
                          );
                        },
                        child: const Text(
                          "Forgot Password?",
                          style: TextStyle(
                            color: Color(0xFF2F6F6D),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 10),

                    /// Login Button
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
    onPressed: () async {

    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(content: Text("All fields required")),
    );
    return;
    }

    setState(() => isLoading = true);

    await ApiService.pingServer();
    await Future.delayed(const Duration(seconds: 2));

    final result = await ApiService.login(email, password);

    setState(() => isLoading = false);

    if (!mounted) return;

    if (result["success"] == true && result["role"] != null) {
      /// ✅ SAVE TOKEN (MOST IMPORTANT)
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString("token", result["token"]);

    String role = result["role"];

    if (role == "driver") {
    Navigator.pushReplacement(
    context,
    MaterialPageRoute(builder: (_) => const DriverHomeScreen()),
    );
    } else if (role == "admin") {
    Navigator.pushReplacement(
    context,
    MaterialPageRoute(builder: (_) => const AdminHomeScreen()),
    );
    } else {
    Navigator.pushReplacement(
    context,
    MaterialPageRoute(builder: (_) => const HomeScreen()),
    );
    }

    } else {

    ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
    content: Text(
    result["message"] ?? "Invalid email or password",
    ),
    ),
    );

    }
    },
                        child: isLoading
                            ? const CircularProgressIndicator(color: Colors.white)
                            : const Text("Login"),
                      ),
                    ),

                    const SizedBox(height: 15),

                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const SignupScreen(),
                          ),
                        );
                      },
                      child: const Text(
                        "Don't have an account? Sign Up",
                        style: TextStyle(color: Color(0xFF2F6F6D)),
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