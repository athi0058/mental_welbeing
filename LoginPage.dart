import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'Admin/Admin_UserPage().dart';
import 'QuestionPage.dart';
import 'main.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController mobileController = TextEditingController();
  TextEditingController otpController = TextEditingController();
  String verificationId = '';
  bool isOtpSent = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    // Clean up controllers when the widget is disposed.
    mobileController.dispose();
    otpController.dispose();
    super.dispose();
  }

  void _navigateToQuestionPage(BuildContext context) {
    if ('+91${mobileController.text.trim()}' == '+919025111251') {
      // Navigate to Admin_UserPage
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Admin_UserPage()),
      );
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const QuestionPage()),
      );
    }
  }


  Future<void> verifyPhoneNumber() async {
    final phoneNumber = '+91${mobileController.text.trim()}';

    if (phoneNumber.length != 13) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Invalid phone number format')),
      );
      return;
    }

    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (PhoneAuthCredential credential) async {
        await FirebaseAuth.instance.signInWithCredential(credential);
        _navigateToQuestionPage(context);
      },
      verificationFailed: (FirebaseAuthException e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Verification failed!')),
         // SnackBar(content: Text('Verification failed: ${e.message}')),
        );
      },
      codeSent: (String verificationId, int? resendToken) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Code sent to $phoneNumber')),
        );
        setState(() {
          this.verificationId = verificationId;
          isOtpSent = true;
        });
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        setState(() {
          this.verificationId = verificationId;
        });
      },
    );
  }

  Future<void> signInWithOTP() async {
    final code = otpController.text.trim();
    if (code.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please enter the OTP')),
      );
      return;
    }

    try {
      final PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: code,
      );

      final UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
      print('User signed in: ${userCredential.user}');
      _navigateToQuestionPage(context);
    } on FirebaseAuthException catch (e) {
      String errorMessage = 'An error occurred';
      if (e.code == 'invalid-verification-code') {
        errorMessage = 'The verification code entered is invalid.';
      } else {
        errorMessage = 'Error signing in with OTP: ${e.message}';
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(errorMessage)),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            ClipPath(
              clipper: CircularAppBarClipper(),
              child: Container(
                height: 200,
                color: Color(0xFF9BB168),
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.only(top: 50.0),
                  child: Column(
                    children: [],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Text(
                    'Login',
                    style: TextStyle(
                      fontSize: 30,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 30),
                  TextField(
                    controller: mobileController,
                    decoration: InputDecoration(
                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Text(
                          '+91',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                      labelText: 'Mobile Number',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    keyboardType: TextInputType.phone,
                  ),
                  SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: verifyPhoneNumber,
                    child: Text('Get OTP'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF9BB168),
                      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                      textStyle: TextStyle(fontSize: 18),
                    ),
                  ),
                  if (isOtpSent) ...[
                    SizedBox(height: 10),
                    TextField(
                      controller: otpController,
                      decoration: InputDecoration(
                        labelText: 'Enter The OTP',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      keyboardType: TextInputType.number,
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                          onPressed: verifyPhoneNumber,
                          child: Text('Resend OTP'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color.fromARGB(255, 199, 197, 197),
                            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                            textStyle: TextStyle(fontSize: 18),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: signInWithOTP,
                          child: Text('Next'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFF9BB168),
                            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                            textStyle: TextStyle(fontSize: 18),
                          ),
                        ),
                      ],
                    ),
                  ],
                  SizedBox(height: 40),
                  Text(
                    'Trouble in Login? Contact',
                    style: TextStyle(fontSize: 16, color: Colors.black54),
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.phone, color: Color(0xFF9BB168)),
                      SizedBox(width: 10),
                      Text(
                        'Talk to an Expert',
                        style: TextStyle(fontSize: 16, color: Colors.black),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Text(
                    'support@me.com',
                    style: TextStyle(fontSize: 16, color: Color(0xFF9BB168)),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'or',
                    style: TextStyle(fontSize: 16, color: Colors.black54),
                  ),
                  SizedBox(height: 10),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => PersonalDetailsPage()),
                      );
                    },
                    child: Text(
                      'Create a new account',
                      style: TextStyle(
                        fontSize: 16,
                        color: Color(0xFF9BB168),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CircularAppBarClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, size.height - 50);
    path.quadraticBezierTo(
        size.width / 2, size.height, size.width, size.height - 50);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}