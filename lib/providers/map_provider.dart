import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import '../models/place_search.dart';
import '/services/place_service.dart';
import '/services/geolocator_service.dart';

class MapProvider extends ChangeNotifier {
  final locationService = LocationService();
  final PlaceService placeService = PlaceService();
  Position? currentLocation;
  List<PlaceSearch>? placeSearchResults;
  MapProvider() {
    setCurrentLocation();
  }

  setCurrentLocation() async {
    currentLocation = await locationService.getCurrentLocation();
    notifyListeners();
  }

  searchPlaces(String searchTerm) async {
    placeSearchResults = await placeService.getAutocomplete(searchTerm);
    notifyListeners();
  }
}
