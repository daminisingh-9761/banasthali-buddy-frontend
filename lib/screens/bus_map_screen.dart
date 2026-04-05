import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';

class BusMapScreen extends StatefulWidget {

  final String routeName;

  const BusMapScreen({super.key, required this.routeName});

  @override
  State<BusMapScreen> createState() => _BusMapScreenState();
}

class _BusMapScreenState extends State<BusMapScreen> {

  MapController mapController = MapController();

  LatLng busLocation = LatLng(26.400705, 75.877674);

  String baseUrl =
      "https://banasthali-buddy-backend.onrender.com/api/users/bus/location";

  Timer? timer;

  List<LatLng> routePoints = [];

  int currentIndex = 0;

  @override
  void initState() {

    super.initState();

    setInitialLocation();

    fetchLocation();

    timer = Timer.periodic(
      Duration(seconds: 5),
          (timer) => fetchLocation(),
    );

  }

  void startBusSimulation(){

    Timer.periodic(

      Duration(seconds: 2),

          (timer){

        if(routePoints.isEmpty) return;

        setState(() {

          currentIndex =
              (currentIndex + 1) % routePoints.length;

          busLocation =
          routePoints[currentIndex];

        });

      },

    );

  }

  void setInitialLocation(){

    /// MAIN GATE → OLD MARKET
    if(widget.routeName == "Main Gate to Old Market"){

      routePoints = [

        LatLng(26.400705, 75.877674), // Guest House
        LatLng(26.401127, 75.876502), // Saudh Hostel
        LatLng(26.401815, 75.875053), // AIM & ACT
        LatLng(26.402122, 75.874294), // Vidya Mandir
        LatLng(26.403147, 75.872037), // Vani Mandir
        LatLng(26.403575, 75.870870), // Surya Mandir
        LatLng(26.406205, 75.864842), // Sarda Mandir
        LatLng(26.407123, 75.862140), // Khadi Bhandar

      ];

    }

    /// OLD MARKET → MAIN GATE
    else if(widget.routeName == "Old Market to Main Gate"){

      routePoints = [

        LatLng(26.407123, 75.862140),
        LatLng(26.406205, 75.864842),
        LatLng(26.403575, 75.870870),
        LatLng(26.403147, 75.872037),
        LatLng(26.402122, 75.874294),
        LatLng(26.401815, 75.875053),
        LatLng(26.401127, 75.876502),
        LatLng(26.400705, 75.877674),

      ];

    }

    /// HOSTEL AREA → ACADEMIC BLOCK
    else if(widget.routeName == "Hostel Area to Academic Block"){

      routePoints = [

        LatLng(26.397906, 75.875318), // Vasti Hostel
        LatLng(26.398950, 75.875902), // Vasam Hostel
        LatLng(26.401815, 75.875053), // AIM & ACT
        LatLng(26.402122, 75.874294), // Vidya Mandir
        LatLng(26.403147, 75.872037), // Vani Mandir

      ];

    }

    /// ACADEMIC BLOCK → HOSTEL AREA
    else if(widget.routeName == "Academic Block to Hostel Area"){

      routePoints = [

        LatLng(26.403147, 75.872037),
        LatLng(26.402122, 75.874294),
        LatLng(26.401815, 75.875053),
        LatLng(26.398950, 75.875902),
        LatLng(26.397906, 75.875318),

      ];

    }

    busLocation = routePoints.first;

  }

  Future fetchLocation() async {

    try{

      final response =
      await http.get(Uri.parse(baseUrl));

      if(response.statusCode == 200){

        var data =
        jsonDecode(response.body);

        if(data.isNotEmpty){

          LatLng newLocation =
          LatLng(

            data[0]["latitude"],
            data[0]["longitude"],

          );

          setState(() {

            busLocation =
                newLocation;

          });

          mapController.move(
            newLocation,
            16,
          );

        }

      }

    }
    catch(e){

      print(
          "waiting for driver GPS..."
      );

    }

  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(

        backgroundColor: const Color(0xFF2F6F6D),

        title: Text(

          widget.routeName,

          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            letterSpacing: 1,
          ),

        ),

        centerTitle: true,

      ),

      body: FlutterMap(

        mapController: mapController,

        options: MapOptions(
          initialCenter: busLocation,
          initialZoom: 16,
        ),

        children: [

          TileLayer(

            urlTemplate:
            "https://tile.openstreetmap.org/{z}/{x}/{y}.png",

            userAgentPackageName:
            "com.banasthali.buddy.frontend",

          ),

          PolylineLayer(

            polylines: [

              Polyline(

                points: routePoints,

                strokeWidth: 4,

                color: Colors.blue,

              ),

            ],

          ),

          MarkerLayer(

            markers: [

              Marker(

                point: busLocation,

                width: 50,
                height: 50,

                child: Icon(
                  Icons.directions_bus,
                  size: 40,
                  color: Colors.red,
                ),

              ),

            ],

          ),

        ],

      ),

    );

  }

}