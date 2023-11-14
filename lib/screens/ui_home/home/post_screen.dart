import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:gradient_slide_to_act/gradient_slide_to_act.dart';
import 'package:green_route/screens/ui_home/home/control.dart';
import 'package:intl/intl.dart';
import '../../../model/activity.dart';
import '../widgets/post_appbar.dart';

class PostScreen extends StatelessWidget {
  final Activity activity;

  const PostScreen({Key? key, required this.activity}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DateTime myDateTimeStart;
    DateTime myDateTimeEnd;

    try {
      // Veritabanından gelen stringi uygun formata dönüştür
      String formattedStartDate = '${activity.startDate} 00:00:00';
      myDateTimeStart = DateTime.parse(formattedStartDate);
    } catch (e) {
      debugPrint('Error parsing startDate: $e');
      debugPrint('activity.startDate: ${activity.startDate}');
      myDateTimeStart = DateTime.now();
    }

    try {
      // Veritabanından gelen stringi uygun formata dönüştür
      String formattedEndDate = '${activity.endDate} 00:00:00';
      myDateTimeEnd = DateTime.parse(formattedEndDate);
    } catch (e) {
      debugPrint('Error parsing endDate: $e');
      debugPrint('activity.endDate: ${activity.endDate}');
      myDateTimeEnd = DateTime.now();
    }

    debugPrint('myDateTimeStart: $myDateTimeStart');
    debugPrint('myDateTimeEnd: $myDateTimeEnd');

    String formattedStartDate =
        DateFormat('MMMM d', 'en_US').format(myDateTimeStart);
    String formattedEndDate =
        DateFormat('MMMM d', 'en_US').format(myDateTimeEnd);

    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(activity.imageUrl),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
            Colors.black.withOpacity(0.7),
            BlendMode.dstATop,
          ),
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: const PreferredSize(
          preferredSize: Size.fromHeight(90),
          child: PostAppBarWidget(),
        ),
        bottomNavigationBar: Container(
          height: MediaQuery.of(context).size.height / 1.5,
          padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
          decoration: BoxDecoration(
            color: Theme.of(context).brightness == Brightness.dark
                ? Colors.black26.withOpacity(0.8)
                : Colors.white.withOpacity(0.9),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(40),
              topRight: Radius.circular(40),
            ),
          ),
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 5, right: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          activity.title,
                          style: GoogleFonts.openSans(
                            fontSize: 22,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Row(
                          children: [
                            const Icon(
                              Icons.star,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Text(
                                '\$${activity.price.toStringAsFixed(1)}',
                                style: GoogleFonts.openSans(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          getCategoryName(activity.category),
                          style: GoogleFonts.openSans(
                            fontSize: 15,
                            color: Colors.grey,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const Spacer(),
                        const Icon(
                          Icons.person,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 15),
                          child: Text(
                            '${activity.capacity}/0',
                            style: GoogleFonts.openSans(
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "Date",
                      style: GoogleFonts.openSans(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                      textAlign: TextAlign.justify,
                    ),
                    const SizedBox(height: 5),
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Icon(
                              Icons.date_range,
                            ),
                            const SizedBox(width: 5),
                            Text(
                              formattedStartDate,
                              style: GoogleFonts.openSans(
                                //color: Colors.black54,
                                fontWeight: FontWeight.w600,
                                fontSize: 15,
                              ),
                              textAlign: TextAlign.justify,
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Icon(
                              Icons.event,
                            ),
                            const SizedBox(width: 5),
                            Text(
                              formattedEndDate,
                              style: GoogleFonts.openSans(
                                //color: Colors.black54,
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                              ),
                              textAlign: TextAlign.justify,
                            ),
                          ],
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Text(
                      activity.description,
                      style: const TextStyle(
                        //color: Colors.black54,
                        fontSize: 16,
                      ),
                      textAlign: TextAlign.justify,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return Dialog(
                                  child: SizedBox(
                                    height: 400,
                                    width: 400,
                                    child: GoogleMap(
                                      myLocationButtonEnabled: true,
                                      initialCameraPosition: CameraPosition(
                                        target: LatLng(
                                          activity.latitude,
                                          activity.longitude,
                                        ),
                                        zoom: 14,
                                      ),
                                      markers: {
                                        Marker(
                                          markerId: const MarkerId(
                                            'Selected Location',
                                          ),
                                          position: LatLng(activity.latitude,
                                              activity.longitude),
                                        ),
                                      },
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(right: 5),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black38
                                        .withOpacity(0.2), // Gölgenin rengi
                                    spreadRadius: 5, // Gölge yayılma yarıçapı
                                    blurRadius: 7, // Gölge bulanıklığı
                                    offset:
                                        const Offset(0, 3), // Gölgenin konumu
                                  ),
                                ],
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Image.asset(
                                  "assets/images/image5.jpg",
                                  fit: BoxFit.cover,
                                  width: BitmapDescriptor.hueAzure,
                                  height: 100,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Icon(
                                  Icons.access_time_rounded,
                                ),
                                const SizedBox(width: 3),
                                Text(
                                  activity.startTime,
                                  style: GoogleFonts.openSans(
                                    //color: Colors.black54,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  textAlign: TextAlign.justify,
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Icon(
                                  Icons.access_time_filled_rounded,
                                ),
                                const SizedBox(width: 3),
                                Text(
                                  activity.endTime,
                                  style: GoogleFonts.openSans(
                                    //color: Colors.black54,

                                    fontWeight: FontWeight.w600,
                                  ),
                                  textAlign: TextAlign.justify,
                                ),
                              ],
                            )
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),
                    Row(
                      // mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(35),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.shade600
                                      .withOpacity(0.4), // Gölge rengi
                                  spreadRadius: 4, // Yayılma yarıçapı
                                  blurRadius: 5, // Bulanıklık yarıçapı
                                  offset: const Offset(0, 0), // Gölge konumu
                                ),
                              ],
                            ),
                            child: GradientSlideToAct(
                              width: 350, // Aynı genişliği burad,a da kullanın

                              textStyle: GoogleFonts.openSans(
                                  fontSize: 15, fontWeight: FontWeight.w700),
                              backgroundColor: Theme.of(context).brightness ==
                                      Brightness.dark
                                  ? Colors.black26.withOpacity(0.7)
                                  : Colors.white.withOpacity(0.7),
                              submittedIcon: Icons.check_sharp,
                              iconSize: 27,

                              text: "Swipe for pay...",
                              onSubmit: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => const CreditCarddss(),
                                ));
                              },
                              height: 60,
                              //initialSliderSize: 60,
                              //dragableIconBackgroundColor: Colors.white,
                              sliderButtonIcon: Icons.chevron_right,
                              gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [
                                  Colors.white70,
                                  Colors.indigo.shade800.withOpacity(0.5),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ],
          ),
        ),
        body: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [],
          ),
        ),
      ),
    );
  }

  String getCategoryName(int category) {
    switch (category) {
      case 0:
        return 'Sport';
      case 1:
        return 'Party';
      case 2:
        return 'Developers';
      case 3:
        return 'Activity';
      case 4:
        return 'Communities';
      default:
        return 'Unknown';
    }
  }
}
