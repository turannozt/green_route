// ignore_for_file: prefer_typing_uninitialized_variables

class Activity {
  String title;
  String description;
  String startDate;
  String startTime;
  String endTime;
  String uid;
  String endDate;
  String imageUrl;
  int capacity;
  double price;
  double latitude;
  double longitude;
  final isLiked;
  Activity({
    required this.isLiked,
    required this.latitude,
    required this.longitude,
    required this.price,
    required this.capacity,
    required this.imageUrl,
    required this.title,
    required this.endDate,
    required this.description,
    required this.startDate,
    required this.startTime,
    required this.endTime,
    required this.uid,
  });

  // from map
  factory Activity.fromMap(Map<String, dynamic> map) {
    return Activity(
      isLiked: map['isLiked'],
      latitude: map['latitude'],
      longitude: map['longitude'],
      price: map['price'],
      capacity: map['capacity'],
      imageUrl: map['imageUrl'],
      endDate: map['endDate'],
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      startDate: map['startDate'] ?? '',
      startTime: map['startTime'] ?? '',
      endTime: map['endTime'] ?? '',
      uid: map['uid'] ?? '',
    );
  }

  // to map
  Map<String, dynamic> toMap() {
    return {
      "isLiked": isLiked,
      "latitude": latitude,
      "longitude": longitude,
      "price": price,
      "capacity": capacity,
      "imageUrl": imageUrl,
      "endDate": endDate,
      "title": title,
      "description": description,
      "uid": uid,
      "startDate": startDate,
      "startTime": startTime,
      "endTime": endTime,
    };
  }
}
