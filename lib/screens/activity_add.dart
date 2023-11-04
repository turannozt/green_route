// ignore_for_file: prefer_typing_uninitialized_variables, use_build_context_synchronously, duplicate_ignore

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:green_route/widgets/custom_button.dart';
import 'package:green_route/widgets/map_widget.dart';
import 'package:intl/intl.dart';
import '../model/activity.dart';
import '../widgets/input_field.dart';
import 'ui_home/home/home_screen.dart';

class AddActivityPage extends StatefulWidget {
  final latitude;
  final longitude;

  const AddActivityPage({super.key, this.latitude, this.longitude});

  @override
  State<AddActivityPage> createState() => _AddActivityPageState();
}

class _AddActivityPageState extends State<AddActivityPage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _capacityController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  int _selectedCategory = 0;
  DateTime _selectedStartDate = DateTime.now();
  DateTime _selectedEndDate = DateTime.now();
  String _endTime = "9:30 PM";
  String _startTime = DateFormat('hh:mm a').format(DateTime.now()).toString();
  bool _isLoading = false; // İlerleme göstergesini kontrol edecek değişken

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context, Theme.of(context).brightness),
      body: Container(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MyInputField(
                title: 'Title',
                hint: 'Enter your title',
                controller: _titleController,
                type: TextInputType.text,
              ),
              MyInputField(
                title: 'Description',
                hint: 'Enter your text',
                controller: _descriptionController,
                type: TextInputType.text,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: MyInputField(
                      title: 'Capacity',
                      hint: 'Enter your capacity',
                      controller: _capacityController,
                      type: TextInputType.number,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: MyInputField(
                      title: 'Price',
                      hint: 'Enter your price',
                      controller: _priceController,
                      type: TextInputType.number,
                    ),
                  ),
                ],
              ),
              MyInputField(
                title: 'Activity Location',
                hint: widget.longitude != null
                    ? 'Location: ${widget.latitude.toStringAsFixed(2)}, ${widget.longitude.toStringAsFixed(2)}'
                    : "Enter Your Location",
                type: TextInputType.text,
                controller: _locationController,
                widget: IconButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const MapWidget(),
                    ));
                  },
                  icon: const Icon(Icons.map),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: MyInputField(
                      type: TextInputType.text,
                      title: 'Start Date',
                      hint: DateFormat.yMd().format(_selectedStartDate),
                      widget: IconButton(
                        onPressed: () {
                          _getStartDateFromUser();
                        },
                        icon: const Icon(
                          Icons.calendar_today_outlined,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: MyInputField(
                      type: TextInputType.text,
                      title: 'End Date',
                      hint: DateFormat.yMd().format(_selectedEndDate),
                      widget: IconButton(
                        onPressed: () {
                          _getEndDateFromUser();
                        },
                        icon: const Icon(
                          Icons.calendar_today_outlined,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: MyInputField(
                      type: TextInputType.text,
                      title: 'Start Time',
                      hint: _startTime,
                      widget: IconButton(
                        onPressed: () {
                          _getTimeFromUser(isStarTime: true);
                        },
                        icon: const Icon(
                          Icons.access_time_rounded,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: MyInputField(
                      type: TextInputType.text,
                      title: 'End Time',
                      hint: _endTime,
                      widget: IconButton(
                        onPressed: () {
                          _getTimeFromUser(isStarTime: false);
                        },
                        icon: const Icon(
                          Icons.access_time_rounded,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 18),
              const SizedBox(height: 18),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // _colorPallete(),
                  _categoryWidget(),
                  _isLoading
                      ? const CircularProgressIndicator() // İlerleme göstergesi
                      : CustomButton(
                          text: 'Save',
                          onPressed: _saveActivity,
                        )
                ],
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }

  Widget _categoryWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Category',
          style: GoogleFonts.openSans(fontSize: 16
              // Stilinizi burada tanımlayın
              ),
        ),
        const SizedBox(height: 8.0),
        Wrap(
          children: List<Widget>.generate(
            5,
            (index) {
              IconData categoryIcon;
              if (index == 0) {
                categoryIcon = Icons.sports; // Spor sembolü
              } else if (index == 1) {
                categoryIcon = Icons.party_mode; // Parti sembolü
              } else if (index == 2) {
                categoryIcon = Icons.person; // Yönlendirme sembolü
              } else if (index == 3) {
                categoryIcon = Icons.ac_unit;
              } // Yönlendirme sembolü
              else {
                categoryIcon =
                    Icons.track_changes_outlined; // Yönlendirme sembolü
              }

              return GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedCategory = index;
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: CircleAvatar(
                    radius: 14,
                    backgroundColor: Colors.transparent,
                    child: _selectedCategory == index
                        ? const Icon(
                            Icons.done,
                            color: Colors.indigo, // İstediğiniz renk
                            // size: 16,
                          )
                        : Icon(
                            categoryIcon,
                            color: Colors.black, // İstediğiniz renk
                            //size: 16,
                          ),
                  ),
                ),
              );
            },
          ),
        )
      ],
    );
  }

  AppBar appBar(BuildContext context, Brightness brightness) {
    Color backgroundColor = brightness == Brightness.dark
        ? Colors.black.withOpacity(0.0)
        : Colors.white;

    Color textColor =
        brightness == Brightness.dark ? Colors.white : Colors.black;

    return AppBar(
      backgroundColor: backgroundColor,
      title: Text(
        'Activity Add',
        style: GoogleFonts.openSans(
            color: textColor, fontSize: 20, fontWeight: FontWeight.w600),
      ),
      //backgroundColor: Colors.white,
      elevation: 0.0,
      centerTitle: true,
    );
  }

  _getStartDateFromUser() async {
    DateTime? pickerDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2015),
      lastDate: DateTime(2123),
    );
    if (pickerDate != null) {
      setState(() {
        _selectedStartDate = pickerDate;
      });
    } else {
      debugPrint('null');
    }
  }

  _getEndDateFromUser() async {
    DateTime? pickerDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2015),
      lastDate: DateTime(2123),
    );
    if (pickerDate != null) {
      setState(() {
        _selectedEndDate = pickerDate;
      });
    } else {
      debugPrint('null');
    }
  }

  _getTimeFromUser({required bool isStarTime}) async {
    var pickedTime = await _showTimePicker();
    // ignore: no_leading_underscores_for_local_identifiers, use_build_context_synchronously
    String _formatedTime = pickedTime.format(context);
    if (pickedTime == null) {
      debugPrint('Time Cancel');
    } else if (isStarTime == true) {
      setState(() {
        _startTime = _formatedTime;
      });
    } else if (isStarTime == false) {
      setState(() {
        _endTime = _formatedTime;
      });
    }
  }

  _showTimePicker() {
    return showTimePicker(
      initialEntryMode: TimePickerEntryMode.input,
      context: context,
      initialTime: TimeOfDay(
        hour: int.parse(_startTime.split(':')[0]),
        minute: int.parse(_startTime.split(':')[1].split(' ')[0]),
      ),
    );
  }

  String getCurrentUserUid() {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      return user.uid;
    } else {
      // Kullanıcı giriş yapmamışsa veya kimlik doğrulama başarısızsa null dönecektir.
      return 'Kullanıcı giriş yapmamış';
    }
  }

  void _saveActivity() async {
    Activity newActivity = Activity(
      category: _selectedCategory,
      isLiked: [],
      price: 10.00,
      capacity: 10,
      imageUrl: '',
      title: _titleController.text,
      description: _descriptionController.text,
      startDate: DateFormat.yMd().format(_selectedStartDate),
      endDate: DateFormat.yMd().format(_selectedEndDate),
      startTime: _startTime,
      endTime: _endTime,
      uid: getCurrentUserUid(),
      latitude: widget.latitude, // Add latitude
      longitude: widget.longitude, // Add longitude
    );

    setState(() {
      _isLoading = true; // İlerleme göstergesi başlamadan önce aktif olsun
    });

    try {
      // Firebase'in çalışmaya başlamasını bekleyin
      await Firebase.initializeApp();

      // Firestore veritabanına referans alın
      final firestore = FirebaseFirestore.instance;

      // 'activities' koleksiyonuna yeni bir belge ekleyin ve verileri kaydedin
      await firestore.collection('activities').add(newActivity.toMap());

      // Veriler başarıyla kaydedildiğinde kullanıcıya geribildirim gösterebilirsiniz.
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Activity has been successfully created.'),
        ),
      );

      // Başka bir sayfaya yönlendirebilirsiniz, örneğin:
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => const HomeScreen(),
      ));
    } catch (e) {
      debugPrint('Hata oluştu: $e');
      // Verilerin kaydedilmediğine dair bir hata mesajı gösterebilirsiniz.
    } finally {
      setState(() {
        _isLoading = false; // İlerleme göstergesini devre dışı bırak
      });
    }
  }
}
