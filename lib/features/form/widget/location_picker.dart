import 'package:blood_donation/features/form/controller/google_map_provider.dart';
import 'package:blood_donation/features/widgets/custom_elevated_button.dart';
import 'package:blood_donation/features/widgets/loader.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class LocationPickerScreen extends StatefulWidget {
  const LocationPickerScreen({super.key});

  @override
  State<LocationPickerScreen> createState() => _LocationPickerScreenState();
}

class _LocationPickerScreenState extends State<LocationPickerScreen> {
  GoogleMapController? mapController;

  @override
  void initState() {
    super.initState();
    Provider.of<GoogleMapProvider>(context, listen: false).getCurrentLocation();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final provider = Provider.of<GoogleMapProvider>(context);
    return Scaffold(
      appBar: AppBar(title: const Text("Pick Location")),
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: CameraPosition(
              target: provider.currentPosition!,
              zoom: 15,
            ),
            onMapCreated: (controller) {
              mapController = controller;
            },
            myLocationEnabled: true,
            markers: {
              if (provider.pickedPosition != null)
                Marker(
                  markerId: const MarkerId("picked"),
                  position: provider.pickedPosition!,
                  draggable: true,
                  onDragEnd: provider.updatePickedPosition,
                ),
            },
            onTap: provider.updatePickedPosition,
          ),
          Positioned(
            bottom: 100,
            left: 20,
            right: 20,
            child: Card(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Text(
                  provider.address,
                  style: const TextStyle(fontSize: 16),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 20,
            left: 20,
            right: 20,
            child: SizedBox(
              height: size.height * 0.07,
              width: size.width * 1,
              child: CustomElevatedButton(
                onPressed: () {
                  final picked = provider.pickedPosition;
                  if (picked != null) {
                    const Loader();
                    Navigator.pop(context);
                  }
                },
                child: const Text(
                  "Confirm Location",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
