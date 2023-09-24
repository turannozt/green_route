class Activity {
  String title;
  String description;
  String location;
  String startDate;
  String startTime;
  String endTime;
  String uid;
  String endDate;
  String imageUrl;
  int capacity;
  double price;

  Activity({
    required this.price,
    required this.capacity,
    required this.imageUrl,
    required this.title,
    required this.endDate,
    required this.description,
    required this.location,
    required this.startDate,
    required this.startTime,
    required this.endTime,
    required this.uid,
  });

  // from map
  factory Activity.fromMap(Map<String, dynamic> map) {
    return Activity(
      price: map['price'],
      capacity: map['capacity'],
      imageUrl: map['imageUrl'],
      endDate: map['endDate'],
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      location: map['location'] ?? '',
      startDate: map['startDate'] ?? '',
      startTime: map['startTime'] ?? '',
      endTime: map['endTime'] ?? '',
      uid: map['uid'] ?? '',
    );
  }

  // to map
  Map<String, dynamic> toMap() {
    return {
      "price": price,
      "capacity": capacity,
      "imageUrl": imageUrl,
      "endDate": endDate,
      "title": title,
      "description": description,
      "uid": uid,
      "location": location,
      "startDate": startDate,
      "startTime": startTime,
      "endTime": endTime,
    };
  }
}
