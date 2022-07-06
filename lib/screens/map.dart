import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:smart_health_assistant/providers/map_provider.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final Completer<GoogleMapController> _controller = Completer();

  static const LatLng _center = LatLng(11.574209, 37.361353);
  final TextEditingController searchController = TextEditingController();
  final Set<Marker> _markers = {};

  LatLng _lastMapPosition = _center;

  MapType _currentMapType = MapType.normal;

  void _onMapTypeButtonPressed() {
    setState(() {
      _currentMapType = _currentMapType == MapType.normal
          ? MapType.satellite
          : MapType.normal;
    });
  }

  void _onAddMarkerButtonPressed() {
    setState(() {
      _markers.add(Marker(
        // This marker id can be anything that uniquely identifies each marker.
        markerId: MarkerId(_lastMapPosition.toString()),
        position: _lastMapPosition,
        infoWindow: const InfoWindow(
          title: '',
          snippet: '5 Star Rating',
        ),
        icon: BitmapDescriptor.defaultMarker,
      ));
    });
  }

  void _onCameraMove(CameraPosition position) {
    _lastMapPosition = position.target;
  }

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  @override
  Widget build(BuildContext context) {
    final mapProvider = Provider.of<MapProvider>(context);
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: (mapProvider.currentLocation == null)
            ? const Center(child: CircularProgressIndicator())
            : Column(mainAxisSize: MainAxisSize.min, children: [
                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                        controller: searchController,
                        decoration: const InputDecoration(
                            hintText: "Search Location",
                            suffixIcon: Icon(Icons.search)),
                        onChanged: (value) => mapProvider.searchPlaces(value))),
                Stack(
                  children: <Widget>[
                    SizedBox(
                      height: 630.0,
                      child: GoogleMap(
                        onMapCreated: _onMapCreated,
                        initialCameraPosition: CameraPosition(
                          target: LatLng(mapProvider.currentLocation!.latitude,
                              mapProvider.currentLocation!.longitude),
                          zoom: 14.0,
                        ),
                        mapType: _currentMapType,
                        mapToolbarEnabled: true,
                        myLocationEnabled: true,
                        markers: _markers,
                        onCameraMove: _onCameraMove,
                      ),
                    ),
                    if (mapProvider.placeSearchResults != null &&
                        mapProvider.placeSearchResults!.isNotEmpty)
                      Container(
                        height: 300.0,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(.6),
                          backgroundBlendMode: BlendMode.darken,
                        ),
                      ),
                    if (mapProvider.placeSearchResults != null &&
                        mapProvider.placeSearchResults!.isNotEmpty)
                      SizedBox(
                        height: 300.0,
                        child: ListView.builder(
                            itemCount: mapProvider.placeSearchResults!.length,
                            itemBuilder: (context, index) => ListTile(
                                  title: Text(
                                    mapProvider
                                        .placeSearchResults![index].description,
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                )),
                      ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Align(
                          alignment: Alignment.topRight,
                          child: Column(
                            children: <Widget>[
                              FloatingActionButton(
                                onPressed: _onMapTypeButtonPressed,
                                materialTapTargetSize:
                                    MaterialTapTargetSize.padded,
                                backgroundColor: Colors.green,
                                child: const Icon(Icons.map, size: 36.0),
                              ),
                              const SizedBox(height: 16.0),
                              FloatingActionButton(
                                onPressed: _onAddMarkerButtonPressed,
                                materialTapTargetSize:
                                    MaterialTapTargetSize.padded,
                                backgroundColor: Colors.green,
                                child:
                                    const Icon(Icons.add_location, size: 36.0),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                )
              ]),
      ),
    );
  }
}
