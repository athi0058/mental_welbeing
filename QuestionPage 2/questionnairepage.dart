import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mental_wellbeing/QuestionPage%202/questions.dart';

import '../ResultPage.dart';

class QuestionnairePage extends StatefulWidget {
  final int pageIndex;
  final List<Question> questions;
  final Function onNext;
  final Function onBack;
  final bool isLastPage;

  QuestionnairePage({
    required this.pageIndex,
    required this.questions,
    required this.onNext,
    required this.onBack,
    this.isLastPage = false,
  });

  @override
  _QuestionnairePageState createState() => _QuestionnairePageState();
}

class _QuestionnairePageState extends State<QuestionnairePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Stack(
              children: [
                ClipPath(
                  clipper: RoundedAppBarClipper(curveHeight: 30.0),
                  child: Container(
                    color: Color.fromRGBO(155, 177, 104, 1.0),
                    height: 180,
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Text(
                          'Do you have any of the following\nsymptoms for 7 days or more?',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.openSans(
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: Container(
                      width: 40,
                      height: 40,
                      child: CustomPaint(
                        painter: DiamondPainter(),
                        child: Center(
                          child: Text(
                            '${widget.pageIndex + 1}',
                            style: GoogleFonts.openSans(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 30),
            Text(
              'Answer the questions',
              textAlign: TextAlign.center,
              style: GoogleFonts.openSans(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: widget.questions.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.questions[index].questionText,
                          style: GoogleFonts.openSans(
                            fontSize: 16,
                            color: Colors.black87,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Row(
                              children: [
                                Radio<bool>(
                                  value: true,
                                  groupValue: widget.questions[index].answer,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      widget.questions[index].answer = value;
                                    });
                                  },
                                  activeColor: Colors.lightGreen[700],
                                ),
                                Text('Yes', style: GoogleFonts.openSans()),
                              ],
                            ),
                            Row(
                              children: [
                                Radio<bool>(
                                  value: false,
                                  groupValue: widget.questions[index].answer,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      widget.questions[index].answer = value;
                                    });
                                  },
                                  activeColor: Colors.lightGreen[700],
                                ),
                                Text('No', style: GoogleFonts.openSans()),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                      ],
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 20),
            Column(
              children: [
                LinearProgressIndicator(
                  value: (widget.pageIndex + 1) / 5,
                  backgroundColor: Colors.grey[300],
                  color: Color.fromRGBO(155, 177, 104, 1.0),
                  minHeight: 10,
                ),
                SizedBox(height: 10),
                Text(
                  'Page ${widget.pageIndex + 1} of 5',
                  style: GoogleFonts.openSans(
                    fontSize: 16,
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () {
                    if (widget.pageIndex > 0) {
                      widget.onBack();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.lightGreen[700],
                    side: BorderSide(color: Color(0xFF96A784), width: 1.5),
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    'Back',
                    style: GoogleFonts.openSans(fontSize: 16),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (widget.isLastPage) {
                      //result page:
                      print("Answers submitted");
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ResultPage(answers: {},),
                        ),
                      );

                    } else {
                      widget.onNext();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromRGBO(155, 177, 104, 1.0),
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    widget.isLastPage ? 'Submit' : 'Next',
                    style: GoogleFonts.openSans(fontSize: 16),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
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

class DiamondPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.fill;

    Path path = Path();
    path.moveTo(size.width / 2, 0);
    path.lineTo(size.width, size.height / 2);
    path.lineTo(size.width / 2, size.height);
    path.lineTo(0, size.height / 2);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
