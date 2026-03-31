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
  LatLng busLocation = LatLng(26.399235, 75.881107);

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

    if(widget.routeName == "Main Gate to Old Market"){

      routePoints = [

        LatLng(26.399235, 75.881107),
        LatLng(26.401200, 75.878900),
        LatLng(26.402800, 75.876200),
        LatLng(26.403900, 75.873900),
        LatLng(26.405200, 75.870900),
        LatLng(26.407613, 75.860832),

      ];

    }

    else if(widget.routeName == "Old Market to Main Gate"){

      routePoints = [

        LatLng(26.407613, 75.860832),
        LatLng(26.405200, 75.870900),
        LatLng(26.403900, 75.873900),
        LatLng(26.402800, 75.876200),
        LatLng(26.401200, 75.878900),
        LatLng(26.399235, 75.881107),

      ];

    }

    else if(widget.routeName == "Hostel Area to Academic Block"){

      routePoints = [

        LatLng(26.397180, 75.874902),
        LatLng(26.399000, 75.875600),
        LatLng(26.401000, 75.874900),
        LatLng(26.403000, 75.873900),
        LatLng(26.404159, 75.871488),

      ];

    }

    else if(widget.routeName == "Academic Block to Hostel Area"){

      routePoints = [

        LatLng(26.404159, 75.871488),
        LatLng(26.403000, 75.873900),
        LatLng(26.401000, 75.874900),
        LatLng(26.399000, 75.875600),
        LatLng(26.397180, 75.874902),

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

      /// ✅ GREEN HEADER
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