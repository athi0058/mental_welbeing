import 'package:flutter/material.dart';
import 'package:mental_wellbeing/LoginPage.dart';
import 'Admin/Admin_UserPage().dart';

class LanguageSwitchPage extends StatefulWidget {
  const LanguageSwitchPage({Key? key}) : super(key: key);

  @override
  _LanguageSwitchPageState createState() => _LanguageSwitchPageState();
}

class _LanguageSwitchPageState extends State<LanguageSwitchPage> {
  String _selectedLanguage = 'English';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(200.0),
        child: ClipPath(
          clipper: MyCustomClipper(),
          child: Container(
            color: Color.fromRGBO(155, 177, 104, 1.0),
            child: Center(
              child: Text(
                'Select Language',
                style: TextStyle(
                  fontSize: 28,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Choose your preferred language:',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color.fromRGBO(30, 42, 74, 1.0),
              ),
            ),
            SizedBox(height: 20),
            Column(
              children: [
                _languageContainer(
                  'English',
                  'assets/english.jpg',
                ),
                SizedBox(height: 20),
                _languageContainer(
                  'Tamil',
                  'assets/tamil.jpg',
                ),
              ],
            ),
            SizedBox(height: 40),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  if (_selectedLanguage == 'English') {
                    //Navigator.pushNamed(context, '/LoginPage.dart');
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => LoginPage(),
                      ),
                    );
                  } else if (_selectedLanguage == 'Tamil') {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text('Information'),
                        content: Text('Yet underprocessed'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text('OK'),
                          ),
                        ],
                      ),
                    );
                  }
                },
                child: Text(
                  'Confirm',
                  style: TextStyle(fontSize: 20),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromRGBO(155, 177, 104, 1.0),
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _languageContainer(String language, String imagePath) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedLanguage = language;
        });
      },
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: _selectedLanguage == language
              ? Color.fromRGBO(155, 177, 104, 1.0)
              : Colors.grey[200],
          borderRadius: BorderRadius.circular(15.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 6.0,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            Image.asset(
              imagePath,
              height: 80,
            ),
            SizedBox(width: 20),
            Text(
              language,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: _selectedLanguage == language
                    ? Colors.white
                    : Color.fromRGBO(30, 42, 74, 1.0),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MyCustomClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0.0, size.height - 50);

    var firstControlPoint = Offset(size.width / 4, size.height);
    var firstEndPoint = Offset(size.width / 2, size.height - 50.0);
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstEndPoint.dx, firstEndPoint.dy);

    var secondControlPoint =
    Offset(size.width - (size.width / 4), size.height - 100);
    var secondEndPoint = Offset(size.width, size.height - 50);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondEndPoint.dx, secondEndPoint.dy);

    path.lineTo(size.width, 0.0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
