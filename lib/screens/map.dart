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
  MapProvider? mapProvider;
  MapType _currentMapType = MapType.normal;
  @override
  void initState() {
    mapProvider = Provider.of<MapProvider>(context, listen: false);
    mapProvider!.setCurrentLocation();
    super.initState();
  }

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
    return SafeArea(
        child: Scaffold(
            resizeToAvoidBottomInset: false,
            body: Stack(
              children: <Widget>[
                SizedBox(
                  child: GoogleMap(
                    onMapCreated: _onMapCreated,
                    initialCameraPosition: const CameraPosition(
                      target: LatLng(11.574209, 37.361353),
                      zoom: 14.0,
                    ),
                    mapType: _currentMapType,
                    mapToolbarEnabled: true,
                    myLocationEnabled: true,
                    markers: _markers,
                    onCameraMove: _onCameraMove,
                  ),
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
                            materialTapTargetSize: MaterialTapTargetSize.padded,
                            backgroundColor: Colors.green,
                            child: const Icon(Icons.map, size: 36.0),
                          ),
                          const SizedBox(height: 16.0),
                          FloatingActionButton(
                            onPressed: _onAddMarkerButtonPressed,
                            materialTapTargetSize: MaterialTapTargetSize.padded,
                            backgroundColor: Colors.green,
                            child: const Icon(Icons.add_location, size: 36.0),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: (() => Navigator.pop(context)),
                  child: const Padding(
                    padding: EdgeInsets.only(top: 10.0, left: 20.0),
                    child: Positioned(
                        top: 0,
                        left: 0,
                        child: Icon(
                          Icons.arrow_back_ios_sharp,
                          color: Colors.red,
                          size: 30.0,
                        )),
                  ),
                )
              ],
            )));
  }
}
