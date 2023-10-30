// ignore_for_file: deprecated_member_use
import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:green_route/provider/theme_provider.dart';
import 'package:provider/provider.dart';
import '../provider/auth_provider.dart';
import '../widgets/custom_button.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController phoneController = TextEditingController();
  bool isLoading = false;
  bool isCompleted = false;
  Country selectedCountry = Country(
    phoneCode: "90",
    countryCode: "TR",
    e164Sc: 0,
    geographic: true,
    level: 1,
    name: "Turkey",
    example: "Turkey",
    displayName: "Turkey",
    displayNameNoCountryCode: "TR",
    e164Key: "",
  );

  @override
  Widget build(BuildContext context) {
    phoneController.selection = TextSelection.fromPosition(
      TextPosition(
        offset: phoneController.text.length,
      ),
    );
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 35),
              child: Column(
                children: [
                  Container(
                    width: 200,
                    height: 200,
                    padding: const EdgeInsets.all(20.0),
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      // color: Colors.purple.shade50,
                    ),
                    child: Image.asset(
                      "assets/images/image2.png",
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    "Register",
                    style: TextStil.titleHead2,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "Add your phone number. We'll send you a verification code",
                    style: TextStil.normalText,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    cursorColor: Colors.indigo,
                    controller: phoneController,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    onChanged: (value) {
                      setState(() {
                        phoneController.text = value;
                      });
                    },
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: "Enter phone number",
                      hintStyle: TextStil.normalText,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.grey.shade400),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.grey.shade400),
                      ),
                      prefixIcon: Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 14, horizontal: 10),
                        child: InkWell(
                          onTap: () {
                            showCountryPicker(
                                context: context,
                                countryListTheme: const CountryListThemeData(
                                  bottomSheetHeight: 550,
                                ),
                                onSelect: (value) {
                                  setState(() {
                                    selectedCountry = value;
                                  });
                                });
                          },
                          child: Text(
                            "${selectedCountry.flagEmoji} + ${selectedCountry.phoneCode}",
                            style: const TextStyle(
                              fontSize: 18,
                              //color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      suffixIcon: phoneController.text.length > 9
                          ? Container(
                              height: 30,
                              width: 30,
                              margin: const EdgeInsets.all(2),
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.done,
                                size: 24,
                              ),
                            )
                          : null,
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: CustomButton(
                      text: "Login",
                      onPressed: () {
                        sendPhoneNumber();
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> sendPhoneNumber() async {
    setState(() {
      isLoading = true;
    });

    final ap = Provider.of<AuthProvider>(context, listen: false);
    String phoneNumber = phoneController.text.trim();

    try {
      ap.signInWithPhone(context, "+${selectedCountry.phoneCode}$phoneNumber");
      setState(() {
        isLoading = false;
        isCompleted = true; // Set this to true when the process is completed.
      });
    } catch (error) {
      setState(() {
        isLoading = false;
      });
      debugPrint("Hata: $error");
    }
  }
}
