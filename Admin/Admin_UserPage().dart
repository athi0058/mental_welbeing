//JmSg0yk3CzgaBYyV4njZ

import "package:flutter/material.dart";
import "package:mental_wellbeing/Admin/ResultPage1.dart";


class Admin_UserPage extends StatefulWidget {
  @override
  _AdminPageState createState() => _AdminPageState();
}

class _AdminPageState extends State<Admin_UserPage> {
  final TextEditingController _idController = TextEditingController();
  Map<String, dynamic>? _patientDetails;

  final Map<String, Map<String, dynamic>> _patientData = {
    '1234': {'Name': 'ABC', 'ID': '1234', 'Age': 26, 'Gender': 'Male'},
  };

  void _fetchPatientDetails() {
    setState(() {
      _patientDetails = _patientData[_idController.text];
    });
  }

  void _navigateToResultPage() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ResultPage1(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Stack(
              children: [
                ClipPath(
                  clipper: CircularAppBarClipper(),
                  child: Container(
                    height: 180.0, // Adjust height as needed
                    color: Color.fromRGBO(155, 177, 104, 1.0),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 50.0), // Adjust top padding as needed
                        child: Text(
                          'Admin Page',
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
              child: Scrollbar(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Enter ID', style: TextStyle(fontSize: 18)),
                        SizedBox(height: 8),
                        TextField(
                          controller: _idController,
                          decoration: InputDecoration(
                            hintText: 'Enter ID',
                            border: OutlineInputBorder(),
                          ),
                        ),
                        SizedBox(height: 30),
                        Center(
                          child: ElevatedButton(
                            onPressed: _fetchPatientDetails,
                            child: Text('Search'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xFF9BB168),
                            ),
                          ),
                        ),
                        SizedBox(height: 32),
                        if (_patientDetails != null)
                          Card(
                            elevation: 3,
                            child: Padding(
                              padding: EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Patient Details',
                                    style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 16),
                                  Text('Name: ${_patientDetails!['Name']}'),
                                  Text('ID: ${_patientDetails!['ID']}'),
                                  Text('Age: ${_patientDetails!['Age']}'),
                                  Text('Gender: ${_patientDetails!['Gender']}'),
                                  SizedBox(height: 16),
                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      ElevatedButton(
                                        onPressed: () {
                                          setState(() {
                                            _idController.clear();
                                            _patientDetails = null;
                                          });
                                        },
                                        child: Text('Back'),
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.lightGreen.shade200,
                                        ),
                                      ),
                                      ElevatedButton(
                                        onPressed: _navigateToResultPage,
                                        child: Text('Result'),
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Color(0xFF9BB168),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        if (_patientDetails == null &&
                            _idController.text.isNotEmpty)
                          Center(
                            child: Text(
                              'No patient found with ID ${_idController.text}',
                              style: TextStyle(
                                  color: Color(0xFF9BB168), fontSize: 18),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
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

