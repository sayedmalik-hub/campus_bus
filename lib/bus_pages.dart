import 'package:flutter/material.dart';


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
