// import 'package:flutter/material.dart';
// import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';

// class SuggetionList extends StatefulWidget {
//   final List<SearchInfo> toSuggestions;
//   const SuggetionList({super.key, required this.toSuggestions});

//   @override
//   State<SuggetionList> createState() => _SuggetionListState();
// }

// class _SuggetionListState extends State<SuggetionList> {
//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: 150,
//       child: ListView.builder(
//         itemCount: widget.toSuggestions.length,
//         itemBuilder: (context, index) {
//           return ListTile(
//             tileColor: Colors.amber,
//             title: Text(
//               widget.toSuggestions[index].address!.name!,
//               style: const TextStyle(color: Colors.black),
//             ),
//             onTap: () {
//               toController.text = widget.toSuggestions[index].address!.name!;
//               toPoint = widget.toSuggestions[index].point!;
//               _drawRoad();
//               setState(() {
//                 toSuggestions.clear();
//               });
//             },
//           );
//         },
//       ),
//     );
//   }
// }
