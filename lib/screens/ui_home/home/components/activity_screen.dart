// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../../../data/data.dart';
import '../../../../model/activity.dart';
import '../../../../utils/constants.dart';

class ActivityCards extends StatefulWidget {
  const ActivityCards({Key? key}) : super(key: key);

  @override
  _ActivityCardsState createState() => _ActivityCardsState();
}

class _ActivityCardsState extends State<ActivityCards> {
  late GoogleMapController mapController;
  late CameraPosition initialCameraPosition;
  late Set<Marker> markers;
  late Set<int> likedIndexes;

  @override
  void initState() {
    super.initState();
    markers = <Marker>{};
    likedIndexes = <int>{};
  }

  Widget _buildMapPreview(double latitude, double longitude, int index) {
    bool isLiked = likedIndexes.contains(index);
    return SizedBox(
      height: 180,
      width: MediaQuery.of(context).size.width,
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: _buildMap(latitude, longitude),
          ),
          Positioned(
            top: 10,
            right: 10,
            child: GestureDetector(
              onTap: () {
                setState(() {
                  if (isLiked) {
                    likedIndexes.remove(index);
                  } else {
                    likedIndexes.add(index);
                  }
                });
              },
              child: Icon(
                Icons.favorite,
                color: isLiked ? Colors.red : Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  GoogleMap _buildMap(double latitude, double longitude) {
    return GoogleMap(
      onMapCreated: (GoogleMapController controller) {
        mapController = controller;
        setState(() {
          markers.add(
            Marker(
              markerId: const MarkerId('activity_location'),
              position: LatLng(latitude, longitude),
            ),
          );
        });
      },
      initialCameraPosition: CameraPosition(
        target: LatLng(latitude, longitude),
        zoom: 15,
      ),
      markers: markers,
    );
  }
  Widget _buildActivity(BuildContext context, int index) {
    Activity activity = activityList[index];
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: appPadding,
        vertical: appPadding / 2,
      ),
      child: SizedBox(
        height: 250,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildMapPreview(activity.latitude, activity.longitude, index),
            Row(
              children: [
                Text(
                  activity.price == 0
                      ? 'Free'
                      : '\$${activity.price.toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Text(
                    "${activity.latitude}, ${activity.longitude}",
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 15,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Text(
                  'Start: ${activity.startDate} ',
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  'End: ${activity.endDate} ',
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  'Capacity: ${activity.capacity}',
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: activityList.length,
        itemBuilder: (context, index) {
          return _buildActivity(context, index);
        },
      ),
    );
  }
}
