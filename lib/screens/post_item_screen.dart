import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

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
  final TextEditingController hostelController = TextEditingController();
  final TextEditingController contactController = TextEditingController();

  Future<void> _pickImage() async {
    final XFile? image =
    await _picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        _itemImage = File(image.path);
      });
    }
  }

  void _postItem() {
    if (_itemImage == null ||
        itemNameController.text.isEmpty ||
        priceController.text.isEmpty ||
        hostelController.text.isEmpty ||
        contactController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please fill all required fields"),
        ),
      );
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Item Posted Successfully")),
    );

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Post Item"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              /// IMAGE PICKER
              GestureDetector(
                onTap: _pickImage,
                child: Container(
                  height: 160,
                  width: double.infinity,
                  decoration: BoxDecoration(
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

              /// ITEM NAME
              TextField(
                controller: itemNameController,
                decoration: const InputDecoration(
                  labelText: "Item Name *",
                  border: OutlineInputBorder(),
                ),
              ),

              const SizedBox(height: 15),

              /// DESCRIPTION
              TextField(
                controller: descriptionController,
                decoration: const InputDecoration(
                  labelText: "Description",
                  border: OutlineInputBorder(),
                ),
              ),

              const SizedBox(height: 15),

              /// PRICE
              TextField(
                controller: priceController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: "Price *",
                  border: OutlineInputBorder(),
                ),
              ),

              const SizedBox(height: 25),

              /// SELLER CONTACT DETAILS
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Seller Contact",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),

              const SizedBox(height: 10),

              /// HOSTEL NAME
              TextField(
                controller: hostelController,
                decoration: const InputDecoration(
                  labelText: "Hostel Name *",
                  border: OutlineInputBorder(),
                ),
              ),

              const SizedBox(height: 15),

              /// CONTACT NUMBER
              TextField(
                controller: contactController,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  labelText: "Contact Number *",
                  border: OutlineInputBorder(),
                ),
              ),

              const SizedBox(height: 25),

              /// POST BUTTON
              SizedBox(
                width: double.infinity,
                height: 45,
                child: ElevatedButton(
                  onPressed: _postItem,
                  child: const Text("Post Item"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
