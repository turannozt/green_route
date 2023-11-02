// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../data/data.dart';
import '../../../../model/activity.dart';
import '../../../../utils/constants.dart';

class ActivityCards extends StatefulWidget {
  const ActivityCards({Key? key}) : super(key: key);

  @override
  _ActivityCardsState createState() => _ActivityCardsState();
}

class _ActivityCardsState extends State<ActivityCards> {
  late Set<int> likedIndexes;

  @override
  void initState() {
    super.initState();
    likedIndexes = <int>{};
  }

  Widget _buildMapPreview(Activity activity, int index) {
    bool isLiked = likedIndexes.contains(index);
    return Container(
      height: 180,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        image: DecorationImage(
          image: NetworkImage(activity.imageUrl),
          fit: BoxFit.cover,
        ),
      ),
      child: Stack(
        children: [
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
                size: 28,
                isLiked ? Icons.favorite : Icons.favorite_border,
                color: isLiked ? Colors.red : Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActivity(BuildContext context, int index) {
    Activity activity = activityList[index];

    DateTime startTime = DateTime.parse(activity.startDate);
    DateTime endTime = DateTime.parse(activity.endDate);

    var formattedStartTime = DateFormat('hh:mm a').format(startTime);
    var formattedEndTime = DateFormat('hh:mm a').format(endTime);

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: appPadding,
        vertical: appPadding / 3,
      ),
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                activity.title,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  //color: Colors.black, // Başlık rengi düzenlendi
                ),
              ),
              const SizedBox(height: 10),
              _buildMapPreview(activity, index),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    activity.price == 0
                        ? 'Free'
                        : '\$${activity.price.toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      //color: Colors.blue,
                    ),
                  ),
                  Text(
                    'Capacity: ${activity.capacity}',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      //color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Start: $formattedStartTime ',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                     // color: Colors.grey[600],
                    ),
                  ),
                  Text(
                    'End: $formattedEndTime ',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                     // color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ],
          ),
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
