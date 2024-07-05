// import 'package:dio/dio.dart' as dio;
// import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';

// Future<List<SearchInfo>> addressSuggestion(String searchText,
//     {int limitInformation = 5}) async {
//   dio.Response response = await dio.Dio().get(
//     "https://photon.komoot.io/api/",
//     queryParameters: {
//       "q": searchText,
//       "limit": limitInformation == 0 ? "" : "$limitInformation"
//     },
//   );
//   final json = response.data;

//   return (json["features"] as List)
//       .map((d) => SearchInfo.fromPhotonAPI(d))
//       .toList();
// }
