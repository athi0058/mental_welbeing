import 'dart:async';
import 'package:flutter/material.dart';
import 'package:mental_wellbeing/LanguageSwitchPage.dart';
import 'package:mental_wellbeing/LoginPage.dart';
import 'package:firebase_core/firebase_core.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp(options: const FirebaseOptions(
        apiKey: "AIzaSyCOOz0K4VhIfOF5T1V4uxz6AuPs-7uqyMw",
        authDomain: "mental-well-being-569f8.firebaseapp.com",
        projectId: "mental-well-being-569f8",
        storageBucket: "mental-well-being-569f8.appspot.com",
        messagingSenderId: "537568471428",
        appId: "1:537568471428:web:5fa14bbadf8265f48215d1"));
    print('Firebase initialized');
  } catch (e) {
    print('Error initializing Firebase: $e');
  }
/*  WidgetsFlutterBinding.ensureInitialized();

  if(kIsWeb) {
    await Firebase.initializeApp(options: const FirebaseOptions(
        apiKey: "AIzaSyCOOz0K4VhIfOF5T1V4uxz6AuPs-7uqyMw",
        authDomain: "mental-well-being-569f8.firebaseapp.com",
        projectId: "mental-well-being-569f8",
        storageBucket: "mental-well-being-569f8.appspot.com",
        messagingSenderId: "537568471428",
        appId: "1:537568471428:web:5fa14bbadf8265f48215d1"));
  }else{
    Firebase.initializeApp();
  }*/
  runApp(MyApp());
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
      const Duration(seconds: 5),
          () =>
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => LanguageSwitchPage(),
            ),
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(188, 233, 169, 1.0),
      body: Center(
        child: SizedBox(
          width: 200, // Set the desired width
          height: 200, // Set the desired height
          child: Image.asset('assets/logo.jpg'),
        ),
      ),
    );
  }
}



class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}

class PersonalDetailsPage extends StatefulWidget {
  const PersonalDetailsPage({super.key});

  @override
  _PersonalDetailsPageState createState() => _PersonalDetailsPageState();
}

class _PersonalDetailsPageState extends State<PersonalDetailsPage> {
  String? _gender;
  String? _locality;
  String? _qualification;
  String? _working;
  String? _workExperience;
  bool _acceptedTerms = false;
  bool _shareDetails = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Stack(
            children: [
              ClipPath(
                clipper: RoundedAppBarClipper(curveHeight: 30.0),
                child: Container(
                  color: const Color.fromRGBO(155, 177, 104, 1.0),
                  height: 180,
                  child: const Center(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 0.0, left: 16.0, right: 16.0),
                      child: Text(
                        'Personal Details',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16.0),
              children: [
                buildTextField('Name:'),
                SizedBox(height: 20),
                buildTextField('Age:   ', keyboardType: TextInputType.number),
                SizedBox(height: 20),
                buildRadioGroup('Gender:', ['Male', 'Female', 'Other'], _gender, (value) {
                  setState(() {
                    _gender = value;
                  });
                }),
                SizedBox(height: 20),
                buildRadioGroup('Locality:', ['Urban', 'Suburban', 'Rural'], _locality, (value) {
                  setState(() {
                    _locality = value;
                  });
                }),
                SizedBox(height: 20),
                buildRadioGroup('Qualification:', ['SSLC', 'HSC', 'UG', 'PG', 'PhD', 'None'], _qualification, (value) {
                  setState(() {
                    _qualification = value;
                  });
                }),
                SizedBox(height: 20),
                buildRadioGroup('Working:', ['Yes', 'No'], _working, (value) {
                  setState(() {
                    _working = value;
                    if (value == 'No') _workExperience = null;
                  });
                }),
                if (_working == 'Yes') SizedBox(height: 20),
                if (_working == 'Yes')
                  buildRadioGroup('Work Experience:', ['Below 5 years', 'Above 5 years'], _workExperience, (value) {
                    setState(() {
                      _workExperience = value;
                    });
                  }),
                SizedBox(height: 20),
                Text(
                  'Disclaimer:',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Row(
                  children: [
                    Checkbox(
                      value: _shareDetails,
                      onChanged: (value) {
                        setState(() {
                          _shareDetails = value!;
                        });
                      },
                    ),
                    Expanded(child: Text('I agree to share my details to the medical professionals.')),
                  ],
                ),
                Row(
                  children: [
                    Checkbox(
                      value: _acceptedTerms,
                      onChanged: (value) {
                        setState(() {
                          _acceptedTerms = value!;
                        });
                      },
                    ),
                    Expanded(child: Text('I accept the terms and conditions and privacy policy.')),
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 20.0),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Color.fromRGBO(155, 177, 104, 1.0),
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => LoginPage()),
                          );
                        },
                        child: Text(
                          'Back',
                          style: TextStyle(
                            color: Color.fromRGBO(155, 177, 104, 1.0),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 20.0),
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(155, 177, 104, 1.0),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: TextButton(
                        onPressed: () {
                          if (_acceptedTerms && _shareDetails) {
                            print('${_gender} : ${_locality}');
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Registered Successfully...'),
                              ),
                            );
                            // Submit the form
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Please fill in all essential credentials and accept the terms and conditions.'),
                              ),
                            );
                          }
                        },
                        child: Text(
                          'Submit',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildTextField(String label, {TextInputType keyboardType = TextInputType.text}) {
    return Row(
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 16),
        ),
        SizedBox(width: 10),
        Expanded(
          child: TextField(
            keyboardType: keyboardType,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildRadioGroup(String label, List<String> options, String? groupValue, ValueChanged<String?> onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 16),
        ),
        Wrap(
          spacing: 10.0,
          runSpacing: 10.0,
          children: options.map((option) {
            return Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Radio<String>(
                  value: option,
                  groupValue: groupValue,
                  onChanged: onChanged,
                ),
                Text(option),
              ],
            );
          }).toList(),
        ),
      ],
    );
  }
}


class RoundedAppBarClipper extends CustomClipper<Path> {
  final double curveHeight;

  RoundedAppBarClipper({this.curveHeight = 30.0});

  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height - curveHeight);
    path.quadraticBezierTo(size.width / 2, size.height, size.width, size.height - curveHeight);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}