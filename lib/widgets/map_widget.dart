import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../screens/activity_add.dart';

class MapWidget extends StatefulWidget {
  const MapWidget({super.key});

  @override
  State<MapWidget> createState() => _MapWidgetState();
}

class _MapWidgetState extends State<MapWidget> {
  // GoogleMapController to control the map
  final Completer<GoogleMapController> _controller = Completer();
  List<Marker> markers = [];
  int id = 1;
  GoogleMapController? _mapController;
  final Set<Polyline> _polylines = <Polyline>{};
  List<LatLng> polylineCoordinates = [];
  static const CameraPosition _initialPosition = CameraPosition(
    target: LatLng(41.0082, 28.9784),
    zoom: 12,
  );
  void _createMap() {
    setState(() {
      // Harita oluşturulduğunda kontrolcüyü almak için onMapCreated olayını kullanıyoruz
      _mapController
          ?.animateCamera(CameraUpdate.newCameraPosition(_initialPosition));
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _createMap();
    });
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
            child: Expanded(
              child: GoogleMap(
                mapType: MapType.terrain,
                trafficEnabled: true,
                myLocationButtonEnabled: true,
                myLocationEnabled: true,
                onTap: (LatLng latLng) {
                  // Mevcut markerları kaldırmak için listeyi temizle
                  markers.clear();

                  // Yeni tıklanan konuma marker ekle
                  Marker newMarker = Marker(
                    markerId: MarkerId('$id'),
                    position: LatLng(latLng.latitude, latLng.longitude),
                    infoWindow: const InfoWindow(title: 'Yeni Konum'),
                    icon: BitmapDescriptor.defaultMarkerWithHue(
                        BitmapDescriptor.hueBlue),
                  );
                  markers.add(newMarker);
                  id = id + 1;

                  // Enlem ve boylamı yazdır
                  debugPrint(
                      'Enlem: ${latLng.latitude}, Boylam: ${latLng.longitude}');

                  setState(() {});
                },
                initialCameraPosition: _initialPosition,
                onMapCreated: (GoogleMapController controller) {
                  _controller.complete(controller);
                },
                markers: markers.map((e) => e).toSet(),
                polylines: _polylines,
              ),
            ),
          ),
          ElevatedButton.icon(
            icon: const Icon(Icons.location_on),
            onPressed: () {
              // Kaydet butonuna tıklanınca yapılacak işlemleri burada tanımlayın
              _saveLocation();
            },
            style: ButtonStyle(
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                      50.0), // Yuvarlaklık için yüksek bir değer
                ),
              ),
            ),
            label: const Text("Konumu Seç",
                style: TextStyle(fontSize: 16)), // Düğme metni ve yazı stili
          ),
        ],
      ),
    );
  }

  void _saveLocation() {
    if (markers.isNotEmpty) {
      LatLng selectedLocation = markers.first.position;
      double latitude = selectedLocation.latitude;
      double longitude = selectedLocation.longitude;

      // Burada seçilen konumun enlem ve boylamını ActivityAdd sayfasına gönderebilirsiniz.
      // Örnek olarak Navigator ile yeni sayfaya geçiş yapabilirsiniz.
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => AddActivityPage(
            latitude: latitude,
            longitude: longitude,
          ),
        ),
      );
    } else {
      // Eğer hiçbir marker seçilmemişse kullanıcıyı uyarabilirsiniz.
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Lütfen bir konum seçin."),
        ),
      );
    }
  }
}
