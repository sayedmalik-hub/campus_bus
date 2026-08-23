import 'package:flutter/material.dart';

void main() {
  runApp(const CampusBusApp());
}

class CampusBusApp extends StatelessWidget {
  const CampusBusApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Campus Bus',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
        ),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Campus Bus 🚌'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.directions_bus,
              size: 80,
            ),
            const SizedBox(height: 20),
            const Text(
              'Welcome to Campus Bus',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              
              onPressed: () {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => const BusSelectionPage(),
    ),
  );
},
              child: const Text('Find My Bus'),
            ),
          ],
        ),
      ),
    );
  }
}
class BusSelectionPage extends StatelessWidget {
  const BusSelectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Select Your Bus"),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          busButton(context, "Bus 1"),
          busButton(context, "Bus 2"),
          busButton(context, "Bus 3"),
          busButton(context, "Bus 4"),
        ],
      ),
    );
  }

  Widget busButton(BuildContext context, String busName) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: ElevatedButton.icon(
     onPressed: () {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => BusTrackingPage(busName: busName),
    ),
  );
},
        icon: const Icon(Icons.directions_bus),
        label: Text(busName),
      ),
    );
  }
}
class BusTrackingPage extends StatelessWidget {
  final String busName;

  const BusTrackingPage({
    super.key,
    required this.busName,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('$busName Tracking'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // Bus status
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    const Icon(
                      Icons.directions_bus,
                      size: 45,
                    ),
                    const SizedBox(width: 15),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          busName,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Text(
                          '● Bus is on the route',
                          style: TextStyle(
                            fontSize: 14,
                          ),
                        ),

                        const SizedBox(height: 20),

const Text(
  'Bus Route',
  style: TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
  ),
),


                    
                      ],
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 25),

            // Route
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Bus Route',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 15),

            // Route stops
            Expanded(
              child: ListView(
                children: [
                  routeStop(
                    'College',
                    'Starting Point',
                    Icons.school,
                    true,
                  ),
                  routeLine(),
                  routeStop(
                    'Stop 1',
                    'Next stop',
                    Icons.location_on,
                    false,
                  ),
                  routeLine(),
                  routeStop(
                    'Stop 2',
                    'Upcoming',
                    Icons.location_on,
                    false,
                  ),
                  routeLine(),
                  routeStop(
                    'Stop 3',
                    'Upcoming',
                    Icons.location_on,
                    false,
                  ),
                  routeLine(),
                  routeStop(
                    'Stop 4',
                    'Last stop',
                    Icons.location_on,
                    false,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 10),

            // Refresh button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Bus location refreshed'),
                    ),
                  );
                },
                icon: const Icon(Icons.refresh),
                label: const Text('Refresh Bus Location'),
              ),
            ),
          ],
        ),
      ),
    );
  }
Widget routePoint(String title, String subtitle) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8),
    child: Row(
      children: [
        const Icon(
          Icons.location_on,
          size: 22,
        ),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              subtitle,
              style: const TextStyle(
                fontSize: 13,
              ),
            ),
          ],
        ),
      ],
    ),
  );
}
  Widget routeStop(
    String title,
    String subtitle,
    IconData icon,
    bool isStart,
  ) {
    return Row(
      children: [
        Icon(
          icon,
          size: 32,
        ),
        const SizedBox(width: 15),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(subtitle),
          ],
        ),
      ],
    );
  }

  Widget routeLine() {
    return Container(
      margin: const EdgeInsets.only(left: 15),
      height: 30,
      width: 2,
    );
  }
}