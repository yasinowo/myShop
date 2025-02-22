import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class MapScreen extends StatelessWidget {
  const MapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FlutterMap(
          options: const MapOptions(
              initialCenter: LatLng(31.897234, 54.356635), initialZoom: 15),
          children: [
            TileLayer(
              urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
              userAgentPackageName: 'com.example.aplle_shop_pj',
            ),
            const MarkerLayer(
              markers: [
                Marker(
                  point: LatLng(31.897234, 54.356635),
                  width: 80,
                  height: 80,
                  child: FlutterLogo(),
                ),
              ],
            ),
          ]),
    );
  }
}
