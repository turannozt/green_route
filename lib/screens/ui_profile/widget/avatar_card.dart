import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../../utils/constants.dart';

class AvatarCard extends StatefulWidget {
  const AvatarCard({
    super.key,
  });

  @override
  State<AvatarCard> createState() => _AvatarCardState();
}

class _AvatarCardState extends State<AvatarCard> {
  Map<String, dynamic> userData = {}; // Firestore'dan gelen kullanıcı verileri
  bool isLoading = true; // Yükleme durumunu izlemek için bir değişken
  @override
  void initState() {
    super.initState();
    fetchUserData().then((data) {
      setState(() {
        userData = data;
        isLoading = false; // Yükleme tamamlandığında durumu false yapın
      });
    });
  }

// Firebase Auth'tan anlık kullanıcı kimliğini alma
  String? getCurrentUserID() {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    final uid = user?.uid;
    return uid;
  }

// Firestore'dan kullanıcı bilgilerini almak için bir fonksiyon
  Future<Map<String, dynamic>> fetchUserData() async {
    String? uid = getCurrentUserID();
    if (uid != null) {
      var userDoc =
          await FirebaseFirestore.instance.collection('users').doc(uid).get();
      return userDoc.data() as Map<String, dynamic>;
    } else {
      // Kullanıcı kimliği yoksa boş bir harita döndür
      return {};
    }
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Center(
            child:
                CircularProgressIndicator(), // Yükleme durumunda göstergeyi göster
          )
        : Row(
            children: [
              CircleAvatar(
                radius: 42,
                backgroundImage: NetworkImage(userData['profilePic'] ?? ''),
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    userData['name'] ?? '',
                    style: const TextStyle(
                      fontSize: kbigFontSize,
                      fontWeight: FontWeight.bold,
                      // color: kprimaryColor,
                    ),
                  ),
                  Text(
                    userData['bio'] ?? '',
                    style: const TextStyle(
                      fontSize: ksmallFontSize,
                      //color: Colors.grey.shade600,
                    ),
                  )
                ],
              )
            ],
          );
  }
}
