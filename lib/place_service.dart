import 'dart:convert';
import 'package:flutter/foundation.dart';

import 'models/user_model.dart';
import 'package:http/http.dart' as http;
class PlaceService
{
  final String url="YOUR_API_KEY";
  final String url2="YOUR_API_KEY";

  Future<List<Place>> fetchShoppingCenter()async
  {
    final response = await http.get(Uri.parse(url));

    List<dynamic> resp= await jsonDecode(response.body)["shopping_center"];
    List<Place> places = List.empty(growable: true);

    for(var place in resp)
    {
      places.add(Place.fromJson(place));
    }
    if (kDebugMode) {
      print(places);
    }

    return places;
  }
  //Fulya korusu, Maçka parkı, yıldız parkı


  Future<List<Place>> fetchAllPlaces() async {
    final response = await http.get(Uri.parse(url));
    final response2 = await http.get(Uri.parse(url2));

    List<dynamic> shopResp = await jsonDecode(utf8.decode(response.bodyBytes))["shopping_center"];
    List<dynamic> greenResp = await jsonDecode(utf8.decode(response.bodyBytes))["green_areas"];
    List<dynamic> restResp = await jsonDecode(utf8.decode(response.bodyBytes))["restaurant"];
    List<dynamic> museumResp = await jsonDecode(utf8.decode(response.bodyBytes))["museum"];

    List<dynamic> aShopResp = await jsonDecode(utf8.decode(response2.bodyBytes))["shopping_center"];
    List<dynamic> aGreenResp = await jsonDecode(utf8.decode(response2.bodyBytes))["green_areas"];
    List<dynamic> aRestResp = await jsonDecode(utf8.decode(response2.bodyBytes))["restaurant"];
    List<dynamic> aMuseumResp = await jsonDecode(utf8.decode(response2.bodyBytes))["museum"];

    List<Place> allPlaces=[];
    for(var e1 in shopResp)
      {
        allPlaces.add(Place.fromJson(e1));
      }
    for(var e2 in greenResp)
      {
        allPlaces.add(Place.fromJson(e2));
      }
    for(var e3 in restResp)
    {
      allPlaces.add(Place.fromJson(e3));
    }
    for(var e4 in museumResp)
    {
      allPlaces.add(Place.fromJson(e4));
    }

    for(var a1 in aShopResp)
    {
      allPlaces.add(Place.fromJson(a1));
    }
    for(var a2 in aGreenResp)
    {
      allPlaces.add(Place.fromJson(a2));
    }
    for(var a3 in aRestResp)
    {
      allPlaces.add(Place.fromJson(a3));
    }
    for(var a4 in aMuseumResp)
    {
      allPlaces.add(Place.fromJson(a4));
    }

    return allPlaces;
  }

  /*Future<List<String>> fetchNames() async {
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      Map<String, dynamic> jsonData = json.decode(response.body);
      List<String> names = [];

      if (jsonData['shopping_center'] != null) {
        names.addAll((jsonData['shopping_center'] as List).map((item) => item['county'] as String).toList());
      }

      if (jsonData['green_areas'] != null) {
        names.addAll((jsonData['green_areas'] as List).map((item) => item['county'] as String).toList());
      }
      return names;
    } else {
      throw Exception('Failed to load names');
    }
  }*/
}