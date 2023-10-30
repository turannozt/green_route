// ignore_for_file: use_build_context_synchronously, library_private_types_in_public_api

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart';
import 'package:permission_handler/permission_handler.dart';
import '../screens/activity_add.dart';

class MapWidget extends StatefulWidget {
  const MapWidget({Key? key}) : super(key: key);

  @override
  _MapWidgetState createState() => _MapWidgetState();
}

class _MapWidgetState extends State<MapWidget> {
  final Completer<GoogleMapController> _controller = Completer();
  int id = 1;
  Marker? selectedMarker;
  static const CameraPosition _initialPosition = CameraPosition(
    target: LatLng(39.9334, 32.8597), // Ankara koordinatları
    zoom: 12,
  );
  TextEditingController searchController = TextEditingController();

  void _createMap() {
    selectedMarker ??= Marker(
      markerId: const MarkerId('selected_location'),
      position: _initialPosition.target,
      infoWindow: const InfoWindow(title: 'Seçilen Konum'),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
    );
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _createMap();
    });
    _requestLocationPermission();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios),
        ),
        title: const Text('Konum Seçimi'),
        centerTitle: true,
        elevation: 0,
      ),
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: GoogleMap(
              mapType: MapType.terrain,
              myLocationButtonEnabled: true,
              myLocationEnabled: true,
              onTap: (LatLng latLng) {
                _updateSelectedMarker(latLng);
                debugPrint(
                    'Enlem: ${latLng.latitude}, Boylam: ${latLng.longitude}');
                setState(() {});
              },
              initialCameraPosition: _initialPosition,
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
              markers: selectedMarker != null
                  ? <Marker>{selectedMarker!}
                  : <Marker>{},
            ),
          ),
          ElevatedButton.icon(
            icon: const Icon(Icons.location_on),
            onPressed: () {
              _saveLocation();
            },
            style: ButtonStyle(
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50.0),
                ),
              ),
            ),
            label: const Text("Konumu Seç", style: TextStyle(fontSize: 16)),
          ),
          Positioned(
            top: 16,
            left: 16,
            right: 16,
            child: Container(
              color: Colors.white,
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: searchController,
                      decoration: const InputDecoration(
                        hintText: 'Haritada bir yer arayın',
                        contentPadding: EdgeInsets.all(16.0),
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      _searchLocation();
                    },
                    icon: const Icon(Icons.search),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _updateSelectedMarker(LatLng latLng) {
    setState(() {
      selectedMarker = Marker(
        markerId: const MarkerId('selected_location'),
        position: latLng,
        infoWindow: const InfoWindow(title: 'Seçilen Konum'),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
      );
    });
  }

  void _saveLocation() {
    if (selectedMarker != null) {
      LatLng selectedLocation = selectedMarker!.position;
      double latitude = selectedLocation.latitude;
      double longitude = selectedLocation.longitude;

      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => AddActivityPage(
            latitude: latitude,
            longitude: longitude,
          ),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Lütfen bir konum seçin."),
        ),
      );
    }
  }

  void _requestLocationPermission() async {
    var status = await Permission.location.request();
    if (status.isGranted) {
      // Kullanıcı izin verdiyse, harita sayfasını göster
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const MapWidget(),
        ),
      );
    } else if (status.isDenied) {
      // Kullanıcı izni reddetti, bir uyarı gösterilebilir
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Konum İzni Reddedildi'),
            content: const Text(
                'Uygulamanın konum hizmetlerini kullanabilmesi için konum iznine ihtiyacı vardır.'),
            actions: <Widget>[
              TextButton(
                child: const Text('Tamam'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    } else if (status.isPermanentlyDenied) {
      // Kullanıcı izni kalıcı olarak reddetti, yönlendirme yapılabilir
      openAppSettings();
    }
  }

  void _searchLocation() async {
    String query = searchController.text;
    List<Location> locations = await locationFromAddress(query);
    if (locations.isNotEmpty) {
      Location location = locations.first;
      LatLng latLng = LatLng(location.latitude, location.longitude);
      _updateSelectedMarker(latLng);
      final GoogleMapController controller = await _controller.future;
      controller.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: latLng, zoom: 10),
      ));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Konum bulunamadı."),
        ),
      );
    }
  }
}
