import 'package:flutter/material.dart';
import 'package:mental_wellbeing/Admin/Admin_UserPage().dart';


class ResultPage1 extends StatelessWidget {
  final Map<String, dynamic> dummyData = {
    'id': '1234',
    'percentage': 90,
    'contactPerson': 'Mr.ABC',
    'specialist': 'Child Specialist at Govt.Hospital',
    'contactNumber': '1234567890'
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ResultUI(
        id: dummyData['id'],
        percentage: dummyData['percentage'],
        contactPerson: dummyData['contactPerson'],
        specialist: dummyData['specialist'],
        contactNumber: dummyData['contactNumber'],
      ),
    );
  }
}

class ResultUI extends StatelessWidget {
  final String id;
  final int percentage;
  final String contactPerson;
  final String specialist;
  final String contactNumber;

  ResultUI({
    required this.id,
    required this.percentage,
    required this.contactPerson,
    required this.specialist,
    required this.contactNumber,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Stack(
            children: [
              ClipPath(
                clipper: CircularAppBarClipper(),
                child: Container(
                  height: 180.0,
                  color: Color(0xFF9BB168),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 50.0),
                      child: Text(
                        'Result',
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
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 20),
                Text('ID : $id', style: TextStyle(fontSize: 18)),
                SizedBox(height: 20),
                CustomPaint(
                  painter: CustomLinearProgressPainter(percentage: percentage),
                  child: Container(
                    height: 20,
                    width: 200,
                  ),
                ),
                SizedBox(height: 10),
                Text('$percentage%', style: TextStyle(fontSize: 18)),
                SizedBox(height: 20),
                Text('$contactPerson will contact the following person..',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 18)),
                SizedBox(height: 10),
                Text(specialist, style: TextStyle(fontSize: 18)),
                SizedBox(height: 10),
                Text('Contact.No: $contactNumber',
                    style: TextStyle(fontSize: 18)),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Color(0xFF9BB168), backgroundColor: Colors.white,
                        side: BorderSide(color: Color(0xFF9BB168)),
                      ),
                      child: Text('Back'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        _navigateToAdminPage(context);
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white, backgroundColor: Color(0xFF9BB168),
                      ),
                      child: Text('Done'),
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

  void _navigateToAdminPage(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => Admin_UserPage(),
      ),
    );
  }
}

class CircularAppBarClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, size.height - 30);
    var firstControlPoint = Offset(size.width / 2, size.height);
    var firstEndPoint = Offset(size.width, size.height - 30);
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstEndPoint.dx, firstEndPoint.dy);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class CustomLinearProgressPainter extends CustomPainter {
  final int percentage;

  CustomLinearProgressPainter({required this.percentage});

  @override
  void paint(Canvas canvas, Size size) {
    final Paint backgroundPaint = Paint()
      ..color = Color.fromARGB(255, 77, 75, 75)
      ..style = PaintingStyle.fill;

    final Paint progressPaint = Paint()
      ..color = const Color(0xFF9BB168)
      ..style = PaintingStyle.fill;

    final Paint circlePaint = Paint()
      ..color = const Color(0xFF9BB168)
      ..style = PaintingStyle.fill;

    double progressWidth = size.width * (percentage / 100);
    double circleRadius = 10.0;

    canvas.drawRect(
      Rect.fromLTWH(0, 0, size.width, size.height),
      backgroundPaint,
    );

    canvas.drawRect(
      Rect.fromLTWH(0, 0, progressWidth, size.height),
      progressPaint,
    );

    if (percentage > 0) {
      canvas.drawCircle(
        Offset(progressWidth, size.height / 1.5),
        circleRadius,
        circlePaint,
      );
    }
    if (percentage > 0) {
      canvas.drawCircle(
        Offset(progressWidth, size.height / 3),
        circleRadius,
        circlePaint,
      );
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
