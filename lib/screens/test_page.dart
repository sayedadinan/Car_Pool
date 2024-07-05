import 'package:flutter/material.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';

class MapPage extends StatefulWidget {
  const MapPage({Key? key}) : super(key: key);

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
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
  GeoPoint? fromPoint; // Selected from point
  GeoPoint? toPoint; // Selected to point

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
        toPoint = null;
      } catch (e) {
        print('Error drawing road: $e');
      }
    } else {
      print('Please select both From and To locations.');
    }
  }

  // Function to fetch address suggestions for From Location
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
      appBar: AppBar(
        title: const Text('OSM Map Demo'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
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
              controller: toController,
              onChanged: getToAddressSuggestions,
              decoration: const InputDecoration(
                labelText: 'To Location (latitude,longitude)',
              ),
            ),
          ),
          if (fromSuggestions.isNotEmpty)
            Expanded(
              child: ListView.builder(
                itemCount: fromSuggestions.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    tileColor: Colors.amber,
                    title: Text(fromSuggestions[index].address!.name!),
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
            Expanded(
              child: ListView.builder(
                itemCount: toSuggestions.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    tileColor: Colors.amber,
                    title: Text(toSuggestions[index].address!.name!),
                    onTap: () {
                      toController.text = toSuggestions[index].address!.name!;
                      toPoint = toSuggestions[index].point!;
                      setState(() {
                        toSuggestions.clear();
                      });
                    },
                  );
                },
              ),
            ),
          ElevatedButton(
            onPressed: _drawRoad,
            child: const Text('Show Path'),
          ),
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
