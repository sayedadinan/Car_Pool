// import 'package:flutter/material.dart';
// import 'package:car_pool/utils/mediaquery.dart';

// class MapScreen extends StatefulWidget {
//   const MapScreen({super.key});

//   @override
//   _MapScreenState createState() => _MapScreenState();
// }

// class _MapScreenState extends State<MapScreen> {
//   bool isExpanded = false; // Track if the container is expanded

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       // backgroundColor: Colors.white,
//       body: Stack(
//         children: [
//           Positioned.fill(
//             child: Container(
//               color: Colors.blue, // Replace with your map content
//             ),
//           ),
//           // Animated container at the bottom
//           AnimatedContainer(
//             duration: const Duration(milliseconds: 300),
//             curve: Curves.easeInOut,
//             height: isExpanded
//                 ? mediaqueryheight(0.6, context) // Expanded height
//                 : mediaqueryheight(0.84, context), // Collapsed height
//             width: double.infinity,
//             alignment: Alignment.bottomCenter,
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.vertical(
//                   top: Radius.circular(20.0), bottom: Radius.circular(15)),
//             ),
//             child: GestureDetector(
//               onTap: () {
//                 setState(() {
//                   isExpanded = !isExpanded; // Toggle expanded state
//                 });
//               },
//               child: const Icon(
//                 Icons.arrow_circle_up,
//                 size: 40,
//                 color: Colors.blue,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
import 'package:car_pool/screens/test_page.dart';
import 'package:car_pool/utils/app_sizedbox.dart';
import 'package:car_pool/utils/app_text.dart';
import 'package:flutter/material.dart';
import 'package:car_pool/utils/mediaquery.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Map Screen'),
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(),
              child: Row(
                children: [
                  CircleAvatar(),
                  CustomSizedBoxWidth(0.04),
                  CustomText(text: 'Sithara Thomas', fontSize: 0.05)
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.speed),
              title: const Text('Ride History'),
              onTap: () {
                Get.to(const MapPage());
              },
            ),
            const ListTile(
                leading: Icon(Icons.trending_up_sharp), title: Text('Trips')),
            const ListTile(
                leading: Icon(Icons.picture_in_picture_alt),
                title: Text('Whiz')),
            const ListTile(
                leading: Icon(Icons.payment), title: Text('Payments')),
            const ListTile(
                leading: Icon(Icons.settings), title: Text('Settings')),
            const ListTile(leading: Icon(Icons.person), title: Text('Profile')),
            const ListTile(
                leading: Icon(Icons.logout_outlined), title: Text('Sign Out')),
          ],
        ),
      ),
      body: Stack(
        children: [
          Positioned.fill(child: Container(color: Colors.blue)),
          AnimatedPositioned(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            top: isExpanded
                ? mediaqueryheight(0.5, context)
                : mediaqueryheight(0.76, context),
            left: 0,
            right: 0,
            child: GestureDetector(
              onTap: () {
                setState(() {
                  isExpanded = !isExpanded;
                });
              },
              child: Container(
                height: mediaqueryheight(0.5, context),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(20.0),
                  ),
                ),
                child: Column(
                  children: [
                    const SizedBox(height: 8),
                    Container(
                      height: 4,
                      width: 40,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: 'Enter starting point',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: 'Enter destination',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
