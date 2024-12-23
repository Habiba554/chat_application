import 'package:chat_app/constants/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationMessage extends StatelessWidget {
  final double latitude;
  final double longitude;
  const LocationMessage(
      {super.key, required this.latitude, required this.longitude});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Container(
          height: 200,
          width: 300,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.grey[300],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: GoogleMap(
              initialCameraPosition: CameraPosition(
                target: LatLng(latitude, longitude),
                zoom: 16,
              ),
              markers: {
                Marker(
                  markerId: const MarkerId(AppStrings.location),
                  position: LatLng(latitude, longitude),
                ),
              },
              myLocationButtonEnabled: false,
              zoomControlsEnabled: false,
              scrollGesturesEnabled: false,
            ),
          ),
        ),
      ),
    );
  }
}
