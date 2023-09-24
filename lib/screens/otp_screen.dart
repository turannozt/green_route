import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:green_route/provider/theme_provider.dart';
import 'package:green_route/responsive/mobile_screen_layout.dart';
import 'package:green_route/responsive/responsive_layout.dart';
import 'package:green_route/responsive/web_screen_layout.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';
import '../provider/auth_provider.dart';
import '../utils/utils.dart';
import '../widgets/custom_button.dart';
import 'user_information_screen.dart';

class OtpScreen extends StatefulWidget {
  final String verificationId;
  const OtpScreen({super.key, required this.verificationId});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  String? otpCode;

  @override
  Widget build(BuildContext context) {
    final isLoading =
        Provider.of<AuthProvider>(context, listen: true).isLoading;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: GestureDetector(
          onTap: () => Navigator.of(context).pop(),
          child: const Icon(Icons.arrow_back_ios_new_rounded),
        ),
        centerTitle: true,
        title: Text(
          'Verification Page',
          style: TextStil.titleHead1,
        ),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: isLoading == true
              ? const Center(
                  child: CircularProgressIndicator(
                    color: Colors.purple,
                  ),
                )
              : Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 25, horizontal: 30),
                    child: Column(
                      children: [
                        Container(
                          width: 200,
                          height: 200,
                          padding: const EdgeInsets.all(20.0),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.purple.shade50,
                          ),
                          child: Image.asset(
                            "assets/images/image2.png",
                          ),
                        ),
                        const SizedBox(height: 20),
                        Text("Verification", style: TextStil.titleHead2),
                        const SizedBox(height: 10),
                        Text(
                          "Enter the OTP send to your phone number",
                          style: TextStil.normalText,
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 20),
                        Pinput(
                          length: 6,
                          showCursor: true,
                          defaultPinTheme: PinTheme(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: Colors.indigo.shade200,
                              ),
                            ),
                            textStyle: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          onCompleted: (value) {
                            setState(() {
                              otpCode = value;
                            });
                          },
                        ),
                        const SizedBox(height: 25),
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: 50,
                          child: CustomButton(
                            text: "Verify",
                            onPressed: () {
                              if (otpCode != null) {
                                verifyOtp(context, otpCode!);
                              } else {
                                showSnackBar(context, "Enter 6-Digit code");
                              }
                            },
                          ),
                        ),
                        const SizedBox(height: 20),
                        Text("Didn't receive any code?",
                            style: TextStil.normalText),
                        const SizedBox(height: 15),
                        GestureDetector(
                          onTap: () {
                            // Call the function to resend the OTP code here
                            resendOtp(context);
                          },
                          child: Text(
                            "Resend New Code",
                            style: GoogleFonts.openSans(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.grey,
                            ),
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

  void resendOtp(BuildContext context) {
    final ap = Provider.of<AuthProvider>(context, listen: false);
    ap.resendOtp(
      onSuccess: () {
        showSnackBar(context, "New code sent successfully!");
      },
      onError: () {
        showSnackBar(context, "Failed to resend code. Please try again.");
      },
    );
  }

  // verify otp
  void verifyOtp(BuildContext context, String userOtp) {
    final ap = Provider.of<AuthProvider>(context, listen: false);
    ap.verifyOtp(
      context: context,
      verificationId: widget.verificationId,
      userOtp: userOtp,
      onSuccess: () {
        // checking whether user exists in the db
        ap.checkExistingUser().then(
          (value) async {
            if (value == true) {
              // user exists in our app
              ap.getDataFromFirestore().then(
                    (value) => ap.saveUserDataToSP().then(
                          (value) => ap.setSignIn().then(
                                (value) => Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const ResponsiveLayout(
                                        mobileScreenLayout:
                                            MobileScreenLayout(),
                                        webScreenLayout: WebScreenLayout(),
                                      ),
                                    ),
                                    (route) => false),
                              ),
                        ),
                  );
            } else {
              // new user
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const UserInfromationScreen(),
                  ),
                  (route) => false);
            }
          },
        );
      },
    );
  }
}
