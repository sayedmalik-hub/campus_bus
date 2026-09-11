import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'profile_selection_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

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
      home: const ProfileSelectionPage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F8FF),

      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: const Color(0xFF172B4D),
        title: const Text(
          'Campus Bus 👋🏻🚌',
          style: TextStyle(
            fontSize: 21,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              // Welcome section
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [
                      Color(0xFF1976D2),
                      Color(0xFF42A5F5),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(28),
                  boxShadow: [
                    BoxShadow(
                      color: const Color.fromARGB(51, 33, 150, 243),
                      blurRadius: 18,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    // Bus icon
                    Container(
                      width: 65,
                      height: 65,
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(46, 255, 255, 255),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Icon(
                        Icons.directions_bus_rounded,
                        color: Colors.white,
                        size: 38,
                      ),
                    ),

                    const SizedBox(height: 22),

                    const Text(
                      'Welcome to\nCampus Bus',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        height: 1.15,
                      ),
                    ),

                    const SizedBox(height: 12),

                    const Text(
                      'Track your LITES bus and know '
                      'where it is in real time.',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 15,
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 25),

              // Live tracking card
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color:const Color.fromARGB(13, 0, 0, 0),
                      blurRadius: 12,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),

                child: Row(
                  children: [

                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color:const Color.fromARGB(26, 0, 128, 0),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.location_on_rounded,
                        color: Colors.green,
                        size: 26,
                      ),
                    ),

                    const SizedBox(width: 14),

                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Live Bus Tracking',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            'Check your bus location anytime',
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),

                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(26, 0, 128, 0),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Text(
                        'LIVE',
                        style: TextStyle(
                          color: Colors.green,
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 25),

              const Text(
                'Ready to go?',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF172B4D),
                ),
              ),

              const SizedBox(height: 8),

              const Text(
                'Select your bus to start tracking.',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),

              const SizedBox(height: 18),

              // Find My Bus button
              SizedBox(
                width: double.infinity,
                height: 58,
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            const BusSelectionPage(),
                      ),
                    );
                  },
                  icon: const Icon(
                    Icons.directions_bus_rounded,
                    size: 24,
                  ),
                  label: const Text(
                    'Find My Bus',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1976D2),
                    foregroundColor: Colors.white,
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                  ),
                ),
              ),
            ],
          ),
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
    child: SizedBox(
      width: double.infinity,
      height: 68,
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => BusTrackingPage(
                busName: busName,
              ),
            ),
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: Colors.blue,
          elevation: 2,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: BorderSide(
              color: const Color.fromRGBO(33, 150, 243, 1),
              width: 1,
            ),
          ),
        ),
        child: Row(
          children: [
            const Icon(
              Icons.directions_bus_rounded,
              size: 28,
            ),

            const SizedBox(width: 16),

            Expanded(
              child: Text(
                busName,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),

            const Icon(
              Icons.arrow_forward_ios_rounded,
              size: 17,
            ),
          ],
        ),
      ),
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
    backgroundColor: const Color(0xFFF5F7FB),

    appBar: AppBar(
      title: Text(
        '$busName Tracking',
        style: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      backgroundColor: Colors.white,
      foregroundColor: Colors.black,
      elevation: 0,
    ),

    body: Padding(
      padding: const EdgeInsets.all(20),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [

          // BUS STATUS CARD
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),

            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: const Color.fromRGBO(0, 0, 0, 0.06),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),

            child: Row(
              children: [

                // Bus icon
                Container(
                  width: 65,
                  height: 65,

                  decoration: BoxDecoration(
                 color: const Color.fromRGBO(33, 150, 243, 0.1),
                    borderRadius: BorderRadius.circular(18),
                  ),

                  child: const Icon(
                    Icons.directions_bus,
                    size: 38,
                    color: Colors.blue,
                  ),
                ),

                const SizedBox(width: 16),

                // Bus information
                Expanded(
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,

                    children: [

                      Text(
                        busName,
                        style: const TextStyle(
                          fontSize: 21,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 6),

                      Row(
                        children: const [

                          Icon(
                            Icons.circle,
                            size: 10,
                            color: Colors.green,
                          ),

                          SizedBox(width: 6),

                          Text(
                            'Bus is on the route',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.green,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 25),

          // ROUTE TITLE
          const Text(
            'Bus Route',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 5),

          const Text(
            'Follow the bus stops',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey,
            ),
          ),

          const SizedBox(height: 15),

          // ROUTE STOPS
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
                  'Rajavoor',
                  'Upcoming',
                  Icons.location_on,false,
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

          const SizedBox(height: 15),

          // REFRESH BUTTON
          SizedBox(
            width: double.infinity,
            height: 55,

            child: ElevatedButton.icon(
              onPressed: () {

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      'Bus location refreshed',
                    ),
                  ),
                );
              },

              icon: const Icon(Icons.refresh),

              label: const Text(
                'Refresh Bus Location',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),

              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
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







