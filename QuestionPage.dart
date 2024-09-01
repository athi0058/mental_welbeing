import 'package:flutter/material.dart';
import 'package:mental_wellbeing/QuestionPage 2/questionnairescreen.dart';
import 'package:mental_wellbeing/QuestionPage1.dart';
import 'package:mental_wellbeing/QuestionPage3.dart';

class QuestionPage extends StatefulWidget {
  const QuestionPage({super.key});
  @override
  _QuestionPageState createState() => _QuestionPageState();
}

class _QuestionPageState extends State<QuestionPage> {
  Map<String, List<String>> _answers = {};

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
                      padding: EdgeInsets.only(top: 0.0, left: 16.0, right: 16.0),
                      child: Text(
                        'Welcome Mr.ABC',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
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
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: _buildQuestions(),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Color.fromRGBO(155, 177, 104, 1.0),
                      width: 1.0,
                    ),
                    borderRadius: BorderRadius.circular(8.0), // Optional: rounded corners
                  ),
                    child: TextButton(
                      onPressed: () {
                        // Show a confirmation dialog before logging out
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('Confirm Logout'),
                              content: Text('Are you sure you want to logout?'),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    // Close the dialog
                                    Navigator.of(context).pop();
                                  },
                                  child: Text(
                                    'Cancel',
                                    style: TextStyle(color: Colors.black54),
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    // Perform logout and navigate back
                                    Navigator.of(context).pop(); // Close the dialog
                                    Navigator.pop(context); // Navigate back to the previous screen
                                  },
                                  child: Text(
                                    'Logout',
                                    style: TextStyle(
                                      color: Color.fromRGBO(155, 177, 104, 1.0),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      child: Text(
                        'Logout',
                        style: TextStyle(
                          color: Color.fromRGBO(155, 177, 104, 1.0),
                        ),
                      ),
                    ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildQuestions() {
    return [
      const SizedBox(height: 40),
      ElevatedButton(
        onPressed: () {
          print('below 18 years...');
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const QuestionPage1()),
          );
        },
        child: Text(
          'Upto 18 yrs    ',
          style: TextStyle(color: Colors.white), // Change text color to white
        ),
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
          textStyle: TextStyle(fontSize: 18),
          backgroundColor: const Color.fromRGBO(155, 177, 104, 1.0),
        ),
      ),
      const SizedBox(height: 20),
      ElevatedButton(
        onPressed: () {
          print('18-60 years...');
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => QuestionnaireScreen()),
          );
        },
        child: Text(
          '18yrs - 60yrs  ',
          style: TextStyle(color: Colors.white), // Change text color to white
        ),
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
          textStyle: TextStyle(fontSize: 18),
          backgroundColor: const Color.fromRGBO(155, 177, 104, 1.0),
        ),
      ),
      const SizedBox(height: 20),
      ElevatedButton(
        onPressed: () {
          print('Above 60-years...');
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => QuestionPage3()),
          );
        },
        child: Text(
          'above 60 years',
          style: TextStyle(color: Colors.white), // Change text color to white
        ),
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
          textStyle: TextStyle(fontSize: 18),
          backgroundColor: const Color.fromRGBO(155, 177, 104, 1.0),
        ),
      ),
    ];
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

class DiamondPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Color.fromRGBO(155, 177, 104, 1.0)
      ..style = PaintingStyle.fill;

    Path path = Path()
      ..moveTo(size.width / 2, 0)
      ..lineTo(size.width, size.height / 2)
      ..lineTo(size.width / 2, size.height)
      ..lineTo(0, size.height / 2)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
