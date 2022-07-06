import 'dart:convert';

import 'package:smart_health_assistant/models/place_search.dart';
import 'package:http/http.dart' as http;

class PlaceService {
  final String key = "AIzaSyDZyUg1Sultr9KJEuO_RgKkUr8eipborKc";
  Future<List<PlaceSearch>> getAutocomplete(String search) async {
    var url =
        'https://maps.googleapis.com/maps/api/place/findplacefromtext/json?input=$search&types={cities}&key=$key';
    var response = await http.get(Uri.parse(url));
    var placeJsonDecode = jsonDecode(response.body);
    var placeResults = placeJsonDecode['predictions'] as List;
    return placeResults.map((place) => PlaceSearch.fromJson(place)).toList();
  }
}
