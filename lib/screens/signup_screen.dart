import 'package:flutter/material.dart';
import 'package:frontend/screens/home_screen.dart';
import 'package:frontend/screens/driver_home_screen.dart';
import 'package:frontend/screens/admin_home_screen.dart';
import '../services/api_service.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();


  final ApiService apiService = ApiService();
  bool isLoading = false;

  String selectedRole = "Student";

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      /// ✅ HEADER
      appBar: AppBar(
        backgroundColor: const Color(0xFF2F6F6D),
        title: const Text(
          "Sign Up",
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

      /// ✅ BODY
      body: Stack(
        children: [

          /// 🔹 FULL BACKGROUND
          Positioned.fill(
            child: Image.asset(
              "assets/images/route.jpeg",
              fit: BoxFit.cover,
            ),
          ),

          SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(20),
              constraints: BoxConstraints(
                minHeight: MediaQuery.of(context).size.height,
              ),
              child: Column(
                children: [

                  const SizedBox(height: 20),

                  /// ROLE
                  DropdownButtonFormField<String>(
                    value: selectedRole,
                    decoration: InputDecoration(
                      labelText: "Select Role",
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.9),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    items: ["Student", "Driver", "Admin"]
                        .map((role) => DropdownMenuItem(
                      value: role,
                      child: Text(role),
                    ))
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedRole = value!;
                      });
                    },
                  ),

                  const SizedBox(height: 15),

                  /// NAME
                  TextFormField(
                    controller: nameController,
                    decoration: InputDecoration(
                      labelText: "Full Name",
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.9),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),

                  const SizedBox(height: 15),

                  /// EMAIL
                  TextFormField(
                    controller: emailController,
                    decoration: InputDecoration(
                      labelText: "Email",
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.9),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),

                  const SizedBox(height: 15),

                  /// PASSWORD
                  TextFormField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: "Password",
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.9),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),

                  const SizedBox(height: 25),

                  /// BUTTON
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

                          final name = nameController.text.trim();
                          final email = emailController.text.trim();
                          final password = passwordController.text.trim();

                          // 🔥 DEBUG PRINT (IMPORTANT)
                          print("NAME: $name");
                          print("EMAIL: $email");
                          print("PASSWORD: $password");

                          // ✅ VALIDATION
                          if (name.isEmpty || email.isEmpty || password.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text("All fields are required")),
                            );
                            return;
                          }

                          setState(() => isLoading = true);
                          await ApiService.pingServer();

                          final success = await ApiService.signup(
                            name,
                            email,
                            password,
                            selectedRole.toLowerCase(),
                          );

                          setState(() => isLoading = false);

                          if (!mounted) return;

                          if (success) {

                            if (selectedRole == "Driver") {

                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => const DriverHomeScreen(),
                                ),
                              );

                            } else if (selectedRole == "Admin") {

                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => const AdminHomeScreen(),
                                ),
                              );

                            } else {

                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => const HomeScreen(),
                                ),
                              );
                            }

                          } else {

                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text("Signup failed")),
                            );
                          }
                        },
                      child: isLoading
                          ? const CircularProgressIndicator(color: Colors.white)
                          : const Text("Sign Up"),
                    ),
                  ),

                  const SizedBox(height: 15),

                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text(
                      "Already have an account? Login",
                      style: TextStyle(color: Color(0xFF2F6F6D)),
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