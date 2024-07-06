import 'package:car_pool/utils/app_sizedbox.dart';
import 'package:car_pool/widget/customdrawer.dart';
import 'package:car_pool/widget/mapwidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  _MapScreenState createState() => _MapScreenState();
}

final controller = MapController.withUserPosition(
  trackUserLocation: const UserTrackingOption(
    enableTracking: true,
    unFollowUser: false,
  ),
);

final TextEditingController fromController = TextEditingController();
final TextEditingController toController = TextEditingController();
List<SearchInfo> fromSuggestions = [];
List<SearchInfo> toSuggestions = [];

GeoPoint? fromPoint;
GeoPoint? toPoint;

ScrollController _scrollController = ScrollController();

Future<void> _drawRoad() async {
  if (fromPoint != null && toPoint != null) {
    try {
      controller.clearAllRoads();
      await controller.drawRoad(
        fromPoint!,
        toPoint!,
        roadType: RoadType.car,
        roadOption: const RoadOption(
          roadWidth: 10,
          roadColor: Colors.blue,
          zoomInto: true,
        ),
      );
    } catch (e) {
      print('Error drawing road: $e');
    }
  } else {
    print('Please select both From and To locations.');
  }
}

class _MapScreenState extends State<MapScreen> {
  Future<void> getFromAddressSuggestions(String searchText) async {
    try {
      List<SearchInfo> results = await addressSuggestion(searchText);
      setState(() {
        fromSuggestions = results;
      });
    } catch (e) {
      print('Error fetching suggestions: $e');
    }
  }

// Function to fetch address suggestions for To Location
  Future<void> getToAddressSuggestions(String searchText) async {
    try {
      List<SearchInfo> results = await addressSuggestion(searchText);
      setState(() {
        toSuggestions = results;
      });
    } catch (e) {
      print('Error fetching suggestions: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 103, 98, 98),
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(
                Icons.menu,
                color: Colors.black,
              ),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
      ),
      drawer: const CustomDrawerWidget(),
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: MapWidget(
                  controller: controller,
                ),
              ),
            ],
          ),
          DraggableScrollableSheet(
            initialChildSize: 0.2,
            minChildSize: 0.2,
            maxChildSize: 0.6,
            builder: (BuildContext context, ScrollController scrollController) {
              _scrollController = scrollController;
              return Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(17),
                    topRight: Radius.circular(17),
                  ),
                ),
                child: SingleChildScrollView(
                  controller: scrollController,
                  child: Column(
                    children: [
                      const CustomSizedBoxHeight(0.01),
                      Container(
                        width: 60,
                        height: 06,
                        decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(12)),
                      ),
                      const CustomSizedBoxHeight(0.01),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          style: const TextStyle(color: Colors.black),
                          controller: fromController,
                          onChanged: getFromAddressSuggestions,
                          decoration: const InputDecoration(
                            prefixIcon: Icon(
                              Icons.location_on_outlined,
                              color: Colors.black,
                            ),
                            labelText: 'From Location',
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          style: const TextStyle(color: Colors.black),
                          controller: toController,
                          onChanged: getToAddressSuggestions,
                          decoration: const InputDecoration(
                            prefixIcon: Icon(
                              Icons.search,
                              color: Colors.black,
                            ),
                            labelText: 'Where would you go?',
                          ),
                        ),
                      ),
                      if (fromSuggestions.isNotEmpty)
                        SizedBox(
                          height: 150,
                          child: ListView.builder(
                            itemCount: fromSuggestions.length,
                            itemBuilder: (context, index) {
                              return ListTile(
                                leading: const CircleAvatar(
                                  backgroundColor: Colors.grey,
                                  child: Center(
                                    child: Icon(
                                      Icons.location_on,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                title: Text(
                                    fromSuggestions[index].address!.name!,
                                    style:
                                        const TextStyle(color: Colors.black)),
                                onTap: () {
                                  fromController.text =
                                      fromSuggestions[index].address!.name!;
                                  fromPoint = fromSuggestions[index].point!;
                                  _drawRoad();
                                  setState(() {
                                    fromSuggestions.clear();
                                  });
                                },
                              );
                            },
                          ),
                        ),
                      if (toSuggestions.isNotEmpty)
                        SizedBox(
                          height: 150,
                          child: ListView.builder(
                            itemCount: toSuggestions.length,
                            itemBuilder: (context, index) {
                              return ListTile(
                                leading: const CircleAvatar(
                                  backgroundColor: Colors.grey,
                                  child: Center(
                                    child: Icon(
                                      Icons.location_on,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                tileColor: Colors.amber,
                                title: Text(
                                  toSuggestions[index].address!.name!,
                                  style: const TextStyle(color: Colors.black),
                                ),
                                onTap: () {
                                  toController.text =
                                      toSuggestions[index].address!.name!;
                                  toPoint = toSuggestions[index].point!;
                                  _drawRoad();
                                  setState(() {
                                    toSuggestions.clear();
                                  });
                                },
                              );
                            },
                          ),
                        ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            buildBottomNavigationItem(
                icon: Icons.car_repair_sharp, label: 'Rides'),
            buildBottomNavigationItem(
                icon: Icons.view_in_ar_sharp, label: 'Trips'),
            buildBottomNavigationItem(
                icon: Icons.person_add_alt, label: 'Whiz +')
          ],
        ),
        color: Colors.white,
      ),
    );
  }

  // @override
  // void dispose() {
  //   fromController.dispose();
  //   toController.dispose();
  //   super.dispose();
  // }
}

Widget buildBottomNavigationItem(
    {required IconData icon, required String label}) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      Icon(icon, color: Colors.black),
      Text(label, style: const TextStyle(color: Colors.black)),
    ],
  );
}
