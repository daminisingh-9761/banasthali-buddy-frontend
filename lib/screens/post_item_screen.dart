import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/api_service.dart';
import 'home_screen.dart';
import 'package:permission_handler/permission_handler.dart';

class PostItemScreen extends StatefulWidget {
  const PostItemScreen({super.key});

  @override
  State<PostItemScreen> createState() => _PostItemScreenState();
}

class _PostItemScreenState extends State<PostItemScreen> {
  File? _itemImage;
  final ImagePicker _picker = ImagePicker();


  final TextEditingController itemNameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController categoryController = TextEditingController(); // ✅ ADDED
  final TextEditingController sellerPhoneController = TextEditingController();
  final TextEditingController sellerHostelController = TextEditingController();
  final TextEditingController sellerRoomController = TextEditingController();

  /// 🔹 IMAGE PICKER (UNCHANGED)
  Future<void> _pickImage() async {
    await Permission.camera.request();
    await Permission.storage.request();
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.close, color: Color(0xFF2F6F6D)),
                      onPressed: () => Navigator.pop(context),
                    ),

                    const Text(
                      "Add Picture",
                      style: TextStyle(
                        color: Color(0xFF2F6F6D),
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    IconButton(
                      icon: const Icon(Icons.delete, color: Color(0xFF2F6F6D)),
                      onPressed: () {
                        setState(() {
                          _itemImage = null;
                        });
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),

                const SizedBox(height: 20),
                ///camera
                ListTile(
                  leading: const Icon(Icons.camera_alt, color: Color(0xFF2F6F6D)),
                  title: const Text("Camera",
                      style: TextStyle(color: Color(0xFF2F6F6D))),
                  onTap: () async {
                    Navigator.pop(context);
                    /// check permission

                    var status = await Permission.camera.request();

                    if (!status.isGranted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Camera permission denied")),
                      );
                      return;
                    }


                    final XFile? image =
                    await _picker.pickImage(source: ImageSource.camera);

                    if (image != null) {
                      setState(() {
                        _itemImage = File(image.path);
                      });
                    }
                  },
                ),
                  /// gallery
                ListTile(
                  leading: const Icon(Icons.image, color: Color(0xFF2F6F6D)),
                  title: const Text("Gallery",
                      style: TextStyle(color: Color(0xFF2F6F6D))),
                  onTap: () async {
                    Navigator.pop(context);
                    /// ✅ ANDROID VERSION BASED FIX
                    var status = await Permission.photos.request(); // 🔥 IMPORTANT

                    if (!status.isGranted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Gallery permission denied")),
                      );
                      return;
                    }
                    final XFile? image =
                    await _picker.pickImage(source: ImageSource.gallery);

                    if (image != null) {
                      setState(() {
                        _itemImage = File(image.path);
                      });
                    }
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  /// 🔥 UPDATED FUNCTION
  Future<void> _postItem() async {

    if (_itemImage == null ||
        itemNameController.text.isEmpty ||
        priceController.text.isEmpty ||
        sellerPhoneController.text.isEmpty ||
        sellerHostelController.text.isEmpty ||
        sellerRoomController.text.isEmpty) {

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please fill all required fields"),
        ),
      );
      return;
    }

    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("token");

    if (token == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("User not logged in")),
      );
      return;
    }

    bool success = await ApiService.postItem(
      "",
      itemNameController.text.trim(),
      descriptionController.text.trim(),
      priceController.text.trim(),
      categoryController.text.trim(),
      sellerPhoneController.text.trim(),
      sellerHostelController.text.trim(),
      sellerRoomController.text.trim(),
      _itemImage,
    );

    if (!mounted) return;

    if (success) {

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Item Posted Successfully")),
      );

      Navigator.pop(context);

    } else {

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Failed to post item")),
      );

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        backgroundColor: const Color(0xFF2F6F6D),
        title: const Text(
          "Post Item",
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2,
            color: Colors.white,
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
        actions: [
          IconButton(
            icon: const Icon(Icons.home),
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (_) => const HomeScreen(),
                ),
                    (route) => false,
              );
            },
          ),
        ],
      ),

      body: Stack(
        children: [

          Positioned.fill(
            child: Image.asset(
              "assets/images/route.jpeg",
              fit: BoxFit.cover,
            ),
          ),

          SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [

                GestureDetector(
                  onTap: _pickImage,
                  child: Container(
                    height: 160,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.85),
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: _itemImage == null
                        ? const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.add_a_photo, size: 40),
                        SizedBox(height: 8),
                        Text("Add Item Image"),
                      ],
                    )
                        : Image.file(
                      _itemImage!,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                TextField(
                  controller: itemNameController,
                  decoration: InputDecoration(
                    labelText: "Item Name *",
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.9),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),

                const SizedBox(height: 15),

                TextField(
                  controller: descriptionController,
                  decoration: InputDecoration(
                    labelText: "Description",
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.9),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),

                const SizedBox(height: 15),

                /// ✅ CATEGORY FIELD ADDED
                TextField(
                  controller: categoryController,
                  decoration: InputDecoration(
                    labelText: "Category",
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.9),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),

                const SizedBox(height: 15),

                TextField(
                  controller: priceController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: "Price *",
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.9),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),

                const SizedBox(height: 25),

                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Seller Contact",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                ),

                const SizedBox(height: 10),

                TextField(
                  controller: sellerPhoneController,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    labelText: "Seller Phone *",
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.9),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),

                const SizedBox(height: 15),

                TextField(
                  controller: sellerHostelController,
                  decoration: InputDecoration(
                    labelText: "Seller Hostel *",
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.9),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),

                const SizedBox(height: 15),

                TextField(
                  controller: sellerRoomController,
                  decoration: InputDecoration(
                    labelText: "Seller Room *",
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.9),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  height: 45,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF2F6F6D),
                    ),
                    onPressed: _postItem,
                    child: const Text("Post Item"),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}