import '../model/activity.dart';

final _activity1 = Activity(
  category: 3,
  isLiked: [],
  latitude: 1,
  longitude: 1,
  title: 'Hiking Adventure',
  description:
      'Join us for an amazing hiking adventure through the scenic routes of Grand Canyon!',
  startDate: '2023-11-01',
  startTime: '08:00',
  endTime: '17:00',
  uid: 'user1',
  endDate: '2023-11-01',
  imageUrl:
      'https://images.unsplash.com/photo-1697237977156-903a35136bf6?auto=format&fit=crop&q=80&w=1887&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
  capacity: 20,
  price: 50.00,
);

final _activity2 = Activity(
  category: 2,
  isLiked: [],
  latitude: 1,
  longitude: 1,
  title: 'Yoga in the Park',
  description:
      'Relax and rejuvenate with our yoga session in the serene environment of Central Park.',
  startDate: '2023-11-15',
  startTime: '09:00',
  endTime: '10:30',
  uid: 'user2',
  endDate: '2023-11-15',
  imageUrl:
      'https://images.unsplash.com/photo-1697237977156-903a35136bf6?auto=format&fit=crop&q=80&w=1887&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
  capacity: 30,
  price: 25.00,
);

final _activity3 = Activity(
  category: 1,
  isLiked: [],
  latitude: 1,
  longitude: 1,
  title: 'Photography Workshop',
  description:
      'Learn the art of photography with our expert photographers in a fun and interactive workshop.',

  startDate: '2023-12-10',
  startTime: '11:00',
  endTime: '14:00',
  uid: 'user3',
  endDate: '2023-12-10',
  imageUrl:
      'https://images.unsplash.com/photo-1697237977156-903a35136bf6?auto=format&fit=crop&q=80&w=1887&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
  capacity: 15,
  price: 0, // veya price: null,
);

final List<Activity> activityList = [_activity1, _activity2, _activity3];
