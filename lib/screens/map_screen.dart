import 'package:car_pool/utils/app_sizedbox.dart';
import 'package:car_pool/widget/customdrawer.dart';
import 'package:flutter/material.dart';
import 'package:car_pool/utils/mediaquery.dart';
import 'package:flutter/widgets.dart';
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
      // toPoint = null;
    } catch (e) {
      print('Error drawing road: $e');
    }
  } else {
    print('Please select both From and To locations.');
  }
}

class _MapScreenState extends State<MapScreen> {
  @override
  void initState() {
    super.initState();

    fromController.addListener(() {
      if (fromController.text.isNotEmpty) {
        // getFromAddressSuggestions(fromController.text);
      }
      if (fromPoint != null && toPoint != null) {
        _drawRoad();
      }
    });

    toController.addListener(() {
      if (toController.text.isNotEmpty) {
        // getToAddressSuggestions(toController.text);
      }
      if (fromPoint != null && toPoint != null) {
        _drawRoad();
      }
    });
  }
//   bool isExpanded = false;

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
      drawer: const CustomDrawerWidget(),
      body: Column(
        children: [
          Expanded(
            child: OSMFlutter(
              controller: controller,
              osmOption: OSMOption(
                userTrackingOption: const UserTrackingOption(
                  enableTracking: true,
                  unFollowUser: false,
                ),
                zoomOption: const ZoomOption(
                  initZoom: 12,
                  minZoomLevel: 3,
                  maxZoomLevel: 19,
                  stepZoom: 1.0,
                ),
                userLocationMarker: UserLocationMaker(
                  personMarker: const MarkerIcon(
                    icon: Icon(
                      Icons.location_history_rounded,
                      color: Colors.red,
                      size: 48,
                    ),
                  ),
                  directionArrowMarker: const MarkerIcon(
                    icon: Icon(
                      Icons.double_arrow,
                      size: 48,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: mediaqueryheight(0.02, context)),
            child: BottomSheet(
              onClosing: () {},
              builder: (context) {
                return Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(17),
                          topRight: Radius.circular(17))),
                  height: 350,
                  width: double.infinity,
                  child: Column(
                    children: [
                      const CustomSizedBoxHeight(0.01),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          style: TextStyle(color: Colors.black),
                          controller: fromController,
                          onChanged: getFromAddressSuggestions,
                          decoration: const InputDecoration(
                            labelText: 'From Location (latitude,longitude)',
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          style: TextStyle(color: Colors.black),
                          controller: toController,
                          onChanged: getToAddressSuggestions,
                          decoration: const InputDecoration(
                            labelText: 'To Location (latitude,longitude)',
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
                                // shape: Border.all(color: Colors.black),
                                // tileColor: Colors.amber,
                                title: Text(
                                  fromSuggestions[index].address!.name!,
                                  style: TextStyle(color: Colors.black),
                                ),
                                onTap: () {
                                  fromController.text =
                                      fromSuggestions[index].address!.name!;
                                  fromPoint = fromSuggestions[index].point!;
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
                                tileColor: Colors.amber,
                                title: Text(
                                  toSuggestions[index].address!.name!,
                                  style: TextStyle(color: Colors.black),
                                ),
                                onTap: () {
                                  toController.text =
                                      toSuggestions[index].address!.name!;
                                  toPoint = toSuggestions[index].point!;
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
                );
              },
            ),
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    fromController.dispose();
    toController.dispose();
    super.dispose();
  }
}
    //  const  ElevatedButton(
    //                   onPressed: _drawRoad,
    //                   child: const Text('Show Path'),
    //                 ),