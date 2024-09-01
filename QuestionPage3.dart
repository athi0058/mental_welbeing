import 'package:flutter/material.dart';
import 'ResultPage.dart';

class QuestionPage3 extends StatefulWidget {
  const QuestionPage3({super.key});

  @override
  _QuestionPageState createState() => _QuestionPageState();
}

class _QuestionPageState extends State<QuestionPage3> {
  int _currentPage = 1;
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
                        'Do you have any of the following symptoms for 7 days or more?',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
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
                          '$_currentPage',
                          style: TextStyle(
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
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: _buildQuestions(_currentPage),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 10.0),
            child: LinearProgressIndicator(
              value: _currentPage / 3,
              backgroundColor: Colors.grey[300],
              color: Color.fromRGBO(155, 177, 104, 1.0),
              minHeight: 10,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: Text(
              'Page $_currentPage of 3',
              style: TextStyle(color: Colors.black54, fontWeight: FontWeight.bold),
            ),
          ),
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
                  borderRadius: BorderRadius.circular(8.0), // Optional: rounded corners
                ),
                child: TextButton(
                  onPressed: _currentPage > 1
                      ? () {
                    setState(() {
                      _currentPage--;
                    });
                  }
                      : null,
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
                  borderRadius: BorderRadius.circular(8.0), // Optional: rounded corners
                ),
                child: TextButton(
                  onPressed: _currentPage <= 3
                      ? () {
                    setState(() {
                      _currentPage++;
                      print('Answers: $_answers');
                      print(_answers.length);
                    });
                    if (_currentPage > 3) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ResultPage(answers: _answers),
                        ),
                      );
                      _currentPage--;
                    }
                  }
                      : null,
                  child: Text(
                    'Next',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  List<Widget> _buildQuestions(int page) {
    switch (page) {
      case 1:
        return [
          const Text(
            'Answer the questions!',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          buildQuestion('Do you have Physical illness?', ['Yes', 'No', 'Sometimes']),
          buildQuestion('How is your Vision?', ['Good', 'Poor', 'Some Problem']),
          buildQuestion('Do you have sleep disturbances?', ['No', 'Often', 'Sometimes']),
          buildQuestion('Do you have memory disturbances for recent activities?', ['No', 'Often', 'Sometimes']),
        ];
      case 2:
        return [
          const Text(
            'Answer the questions!',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          buildQuestion('How is your mental state most of the time?', ['Positive', 'Variable', 'Distressed']),
          buildQuestion('Do you experience mental distress or difficulties in your family?', ['No', 'Often', 'Sometimes']),
          buildQuestion('Do you have difficulty dressing yourself?', ['No', 'Often', 'Sometimes']),
        ];
      case 3:
        return [
          const Text(
            'Answer the questions!',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          buildQuestion('Do you feel suspicious about your activities or those of others?', ['No', 'Often', 'Sometimes']),
          buildQuestion('Do you notice any changes in your movements?', ['No', 'Often', 'Sometimes']),
          buildQuestion('Do you have difficulties with speech?', ['No', 'Often', 'Sometimes']),
        ];
      default:
        return [];
    }
  }

  Widget buildQuestion(String question, List<String> options) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: QuestionWidget(
        question: question,
        options: options,
        onSelected: (value) {
          setState(() {
            _answers[question] = [value];
          });
        },
      ),
    );
  }
}


class QuestionWidget extends StatefulWidget {
  final String question;
  final List<String> options;
  final ValueChanged<String> onSelected;

  const QuestionWidget({
    required this.question,
    required this.options,
    required this.onSelected,
  });

  @override
  _QuestionWidgetState createState() => _QuestionWidgetState();
}

class _QuestionWidgetState extends State<QuestionWidget> {
  String? _selectedOption;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.question,
          style: TextStyle(fontSize: 16),
        ),
        Row(
          children: widget.options.map((option) {
            return Row(
              children: [
                Checkbox(
                  value: _selectedOption == option,
                  onChanged: (value) {
                    setState(() {
                      _selectedOption = option;
                      print('options : $_selectedOption');
                    });
                    widget.onSelected(option);
                  },
                  checkColor: Color.fromRGBO(255, 255, 255, 1.0),
                  activeColor: Color.fromRGBO(155, 177, 104, 1.0),
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
