import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:geolocator/geolocator.dart';

class MapSample extends StatefulWidget {
  const MapSample({Key? key}) : super(key: key);

  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  final Completer<GoogleMapController> _controller =
  Completer<GoogleMapController>();
  final Geolocator _geolocator = Geolocator();
  LatLng _currentLocation = LatLng(21.028511, 105.8542); // Default location
  late CameraPosition _position;
  Placemark place = Placemark();
  Marker? _currentLocationMarker;

  @override
  void initState() {
    super.initState();
    _position = CameraPosition(
      bearing: 192.8334901395799,
      target: _currentLocation,
      tilt: 59.440717697143555,
      zoom: 19.151926040649414,
    );
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      place = placemarks[0];

      setState(() {
        _currentLocation = LatLng(position.latitude, position.longitude);
        _position = CameraPosition(
          bearing: 192.8334901395799,
          target: _currentLocation,
          tilt: 59.440717697143555,
          zoom: 19.151926040649414,
        );

        _updateMarker();

        print(
          'Current Location: ${_currentLocation.latitude}, ${_currentLocation.longitude}',
        );
        print(
            'City: ${place.locality}, District: ${place.subAdministrativeArea}, Country: ${place.country}');
      });
    } catch (e) {
      print('Error getting location: $e');
    }
  }

  void _updateMarker() {
    // Tạo một Marker mới với màu đỏ tại vị trí hiện tại
    _currentLocationMarker = Marker(
      markerId: MarkerId('currentLocation'),
      position: _currentLocation,
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
      infoWindow: InfoWindow(
        title: 'vị trí hiện tại',
        snippet:
        'City: ${place.locality}, District: ${place.subAdministrativeArea}, Country: ${place.country}',
      ),
    );
  }
  void _returnDataToCaller(Placemark place, bool isMap) {
    Map<String, dynamic> result = {
      'place': place,
      'isMap': isMap,
    };
    Navigator.pop(context, result);
  }
  void _returnDataToOder(Placemark place, bool isMap) {
    _returnDataToCaller(place, isMap);
  }
  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 646/896,
      expand: false,
      builder: (_, ScrollController scrollController) {
        return SingleChildScrollView(
            controller: scrollController,
            child: Container(
              height: 600,
              child: Scaffold(
                body: Column(
                  children: [
                    Expanded(
                      child: GoogleMap(
                        mapType: MapType.hybrid,
                        initialCameraPosition: CameraPosition(
                          target: _currentLocation,
                          zoom: 14.4746,
                        ),
                        markers: Set<Marker>.of(
                            _currentLocationMarker != null ? [_currentLocationMarker!] : []),
                        onMapCreated: (GoogleMapController controller) {
                          _controller.complete(controller);
                        },
                      ),
                    ),
                    SizedBox(height: 40,),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(9,0, 9, 0),
                      child: Text(
                        ' Đường: ${place.thoroughfare}, District: ${place.subAdministrativeArea}, District: ${place.street}',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                    SizedBox(height: 20,),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Align(alignment: Alignment.centerLeft,
                          child: ElevatedButton(
                            onPressed: () {
                              _returnDataToOder(place,false);
                            },
                            child: Text('Chọn vị trí'),
                          ),
                      ),
                    )
                  ],
                ),
                floatingActionButton: FloatingActionButton.extended(
                  onPressed: _currentPosition,
                  label: const Text('Vị trí hiện tại'),
                  icon: const Icon(Icons.location_searching_outlined),
                ),
              ),
            )
        );
      }
      ,
    );
  }

  Future<void> _currentPosition() async {
    final GoogleMapController controller = await _controller.future;

    // Request location permission
    var status = await Permission.location.request();
    if (status.isGranted) {
      // If permission is granted, move to the lake position on the map
      await controller.animateCamera(CameraUpdate.newCameraPosition(_position));
      print(place.toString());
    } else {
      // Handle when permission is denied
      print('Location permission denied');
    }
  }
}
