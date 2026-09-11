import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:firebase_database/firebase_database.dart';
class DriverLocationPage extends StatefulWidget {
  const DriverLocationPage({super.key});

  @override
  State<DriverLocationPage> createState() => _DriverLocationPageState();
}

class _DriverLocationPageState extends State<DriverLocationPage> {
  bool locationSharing = false;

  Position? currentPosition;
  StreamSubscription<Position>? positionSubscription;

  Future<bool> checkLocationPermission() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      if (!mounted) return false;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please turn ON Location Services 📍'),
          behavior: SnackBarBehavior.floating,
        ),
      );

      await Geolocator.openLocationSettings();
      return false;
    }

    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.denied) {
      if (!mounted) return false;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Location permission denied.'),
          behavior: SnackBarBehavior.floating,
        ),
      );

      return false;
    }

    if (permission == LocationPermission.deniedForever) {
      if (!mounted) return false;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Location permission permanently denied. Open Settings.',
          ),
          behavior: SnackBarBehavior.floating,
        ),
      );

      await Geolocator.openAppSettings();
      return false;
    }

    return true;
  }

  Future<void> startLocationSharing() async {
    final hasPermission = await checkLocationPermission();

    if (!hasPermission) return;

    try {
      final position = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.high,
        ),
      );

      if (!mounted) return;

      setState(() {
        locationSharing = true;
        currentPosition = position;
      });

      positionSubscription = Geolocator.getPositionStream(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.high,
          distanceFilter: 5,
        ),
      ).listen((Position position) async {
  if (!mounted) return;

  setState(() {
    currentPosition = position;
  });

  await FirebaseDatabase.instance
      .ref('buses/bus1')
      .set({
    'latitude': position.latitude,
    'longitude': position.longitude,
    'accuracy': position.accuracy,
    'timestamp': ServerValue.timestamp,
  });
});

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Live GPS tracking started! 📍🔥'),
          behavior: SnackBarBehavior.floating,
        ),
      );
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Unable to get GPS location: $e'),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  void stopLocationSharing() {
    positionSubscription?.cancel();
    positionSubscription = null;

    setState(() {
      locationSharing = false;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Location sharing stopped.'),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void toggleLocation() {
    if (locationSharing) {
      stopLocationSharing();
    } else {
      startLocationSharing();
    }
  }

  @override
  void dispose() {
    positionSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FB),

      appBar: AppBar(
        title: const Text(
          'Update Location',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: const Color(0xFF172B4D),
        elevation: 0,
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),

          child: Column(
            children: [
              const SizedBox(height: 20),

              // LOCATION ICON
              Container(
                width: 110,
                height: 110,
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  locationSharing
                      ? Icons.gps_fixed
                      : Icons.location_on_rounded,
                  size: 60,
                  color: locationSharing
                      ? Colors.green.shade600
                      : Colors.blue.shade700,
                ),
              ),

              const SizedBox(height: 25),

              const Text(
                'Bus Location',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF172B4D),
                ),
              ),

              const SizedBox(height: 8),

              const Text(
                'Share your current bus location with students',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.grey,
                ),
              ),

              const SizedBox(height: 35),

              // STATUS CARD
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(22),

                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.06),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),

                child: Column(
                  children: [
                    Row(
                      children: [
                        Icon(
                          locationSharing
                              ? Icons.gps_fixed
                              : Icons.gps_not_fixed,
                          color: locationSharing
                              ? Colors.green
                              : Colors.orange,
                          size: 32,
                        ),

                        const SizedBox(width: 15),

                        Expanded(
                          child: Column(
                            crossAxisAlignment:
                                CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Location Status',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),

                              const SizedBox(height: 5),

                              Text(
                                locationSharing
                                    ? 'Live GPS tracking is ON'
                                    : 'Location sharing is OFF',
                                style: TextStyle(
                                  color: locationSharing
                                      ? Colors.green
                                      : Colors.orange,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 25),

                    // BUS INFO
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(18),

                      decoration: BoxDecoration(
                        color: Colors.blue.shade50,
                        borderRadius: BorderRadius.circular(15),
                      ),

                      child: const Row(
                        children: [
                          Icon(
                            Icons.directions_bus_rounded,
                            color: Color(0xFF1976D2),
                            size: 30,
                          ),

                          SizedBox(width: 15),

                          Column(
                            crossAxisAlignment:
                                CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Assigned Bus',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 13,
                                ),
                              ),

                              SizedBox(height: 4),

                              Text(
                                'Bus 1',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 20),

                    // GPS COORDINATES
                    if (currentPosition != null)
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(18),

                        decoration: BoxDecoration(
                          color: Colors.green.shade50,
                          borderRadius: BorderRadius.circular(15),
                        ),

                        child: Column(
                          crossAxisAlignment:
                              CrossAxisAlignment.start,
                          children: [
                            const Text(
                              '📍 Current GPS Location',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            const SizedBox(height: 12),

                            Text(
                              'Latitude: ${currentPosition!.latitude.toStringAsFixed(6)}',
                              style: const TextStyle(fontSize: 14),
                            ),

                            const SizedBox(height: 6),

                            Text(
                              'Longitude: ${currentPosition!.longitude.toStringAsFixed(6)}',
                              style: const TextStyle(fontSize: 14),
                            ),

                            const SizedBox(height: 6),

                            Text(
                              'Accuracy: ${currentPosition!.accuracy.toStringAsFixed(1)} m',
                              style: const TextStyle(fontSize: 14),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ),

              const SizedBox(height: 25),

              // START / STOP BUTTON
              SizedBox(
                width: double.infinity,
                height: 58,

                child: ElevatedButton.icon(
                  onPressed: toggleLocation,

                  icon: Icon(
                    locationSharing
                        ? Icons.stop_circle_outlined
                        : Icons.location_on_outlined,
                  ),

                  label: Text(
                    locationSharing
                        ? 'Stop Location Sharing'
                        : 'Start Location Sharing',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  style: ElevatedButton.styleFrom(
                    backgroundColor: locationSharing
                        ? Colors.red.shade600
                        : Colors.blue.shade700,
                    foregroundColor: Colors.white,

                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              const Text(
                'Your GPS location updates automatically while sharing 📍',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 13,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}