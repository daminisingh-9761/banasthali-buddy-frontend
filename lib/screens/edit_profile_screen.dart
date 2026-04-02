import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {

  final TextEditingController nameController =
  TextEditingController(text: "Banasthali Student");

  final TextEditingController emailController =
  TextEditingController(text: "student@banasthali.in");

  File? profileImage;
  final ImagePicker _picker = ImagePicker();

  Future<void> pickImage() async {
    final XFile? image =
    await _picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        profileImage = File(image.path);
      });
    }
  }

  void saveProfile() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Profile Updated Successfully")),
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        backgroundColor: const Color(0xFF2F6F6D),
        title: const Text(
          "Edit Profile",
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

      /// ✅ FIXED BODY
      body: Stack(
        children: [

          /// 🔥 FULL SCREEN BACKGROUND (FIX)
          Positioned.fill(
            child: Image.asset(
              "assets/images/route.jpeg",
              fit: BoxFit.cover,
            ),
          ),

          /// 🔥 LIGHT OVERLAY (UI IMPROVEMENT)
          Positioned.fill(
            child: Container(
              color: Colors.white.withOpacity(0.1),
            ),
          ),

          /// 🔹 CONTENT
          SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: MediaQuery.of(context).size.height,
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [

                    const SizedBox(height: 20),

                    /// PROFILE IMAGE
                    GestureDetector(
                      onTap: pickImage,
                      child: CircleAvatar(
                        radius: 55,
                        backgroundColor: const Color(0xFF2F6F6D),
                        backgroundImage:
                        profileImage != null ? FileImage(profileImage!) : null,
                        child: profileImage == null
                            ? const Icon(Icons.camera_alt,
                            size: 30, color: Colors.white)
                            : null,
                      ),
                    ),

                    const SizedBox(height: 30),

                    /// NAME
                    TextField(
                      controller: nameController,
                      style: const TextStyle(fontWeight: FontWeight.w500),
                      decoration: InputDecoration(
                        labelText: "Full Name",
                        filled: true,
                        fillColor: Colors.white.withOpacity(0.9),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        prefixIcon: const Icon(Icons.person),
                      ),
                    ),

                    const SizedBox(height: 15),

                    /// EMAIL
                    TextField(
                      controller: emailController,
                      style: const TextStyle(fontWeight: FontWeight.w500),
                      decoration: InputDecoration(
                        labelText: "Email",
                        filled: true,
                        fillColor: Colors.white.withOpacity(0.9),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        prefixIcon: const Icon(Icons.email),
                      ),
                    ),

                    const SizedBox(height: 30),

                    /// SAVE BUTTON
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF2F6F6D),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          elevation: 5,
                        ),
                        onPressed: saveProfile,
                        child: const Text(
                          "Save Changes",
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ),

                    const SizedBox(height: 40),
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