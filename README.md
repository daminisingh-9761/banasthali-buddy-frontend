BANASTHALI BUDDY – FRONTEND

1. OVERVIEW

Banasthali Buddy is a marketplace to buy & sell second hand items, e-rickshaw booking and real-time campus bus tracking application.
The frontend is developed using Flutter and allows students to sell & buy , book e-rickshaw and track buses on a live map, view routes, and get buses updates.
The application communicates with the backend using REST APIs.

The system provides separate interfaces for students, drivers, and admin.

2. FEATURES

Student

* Login and signup
* e-rickshaw booking from predefined post
* Track live bus location on map
* buy and sell second hand items 

Driver

* Driver login
* Start and stop ride
* Toggle online/offline
* Send live GPS location
* pending ride accepts

Admin

* Manage routes
* manages post items
* manages users

3. TECHNOLOGIES USED

* Flutter
* Dart
* Flutter Map and OSM 
* HTTP package
* LatLong2
* REST API

4. PROJECT STRUCTURE

lib
├── screens
│     ├── login_screen.dart
│     ├── signup_screen.dart
│     ├── bus_map_screen.dart
│     ├── driver_dashboard.dart
│     ├── admin_panel.dart
│
├── services
│     ├── api_service.dart
│     ├── auth_service.dart
│     ├── admin_api_service.dart
│
└── main.dart

5. REQUIREMENTS

* Flutter SDK
* Android Studio or VS Code
* Android Emulator or Android device
* Internet connection

6. INSTALLATION

Step 1: Install Flutter
Download Flutter SDK from:
https://docs.flutter.dev/get-started/install

Check installation:
flutter doctor

Step 2: Open project
Open the frontend folder in Android Studio or VS Code.

Step 3: Install dependencies
Run:
flutter pub get

7. CONFIGURATION

Open file:
lib/services/api_service.dart

Set backend URL:
http://localhost:8080/api
OR
http://<vm-ip>:8080/api
OR
https://banasthali-buddy-backend.onrender.com/api  (Backend is deployed on Render)

8. RUN APPLICATION

Connect device or start emulator.
Run:
flutter run
For VM 
run :
flutter run -d web-server

9. HOW IT WORKS

Driver turns on location.
Driver app sends GPS coordinates to backend.
Backend stores latest location.
Student app fetches location.
Bus location updates on map.

Student posts the item on post item feature and buy the item from buy item feature

10. API USED

POST /auth/login
POST /auth/signup
GET /bus/location
GET /routes

11. PURPOSE

This project is developed to demonstrate real-time tracking, erickshaw booking and marketplace to sell second hand itmes and to buy using Flutter and REST API.
