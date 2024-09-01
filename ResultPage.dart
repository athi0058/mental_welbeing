import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:open_file/open_file.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ResultPage extends StatefulWidget {
  final Map<String, List<String>> answers;

  const ResultPage({Key? key, required this.answers}) : super(key: key);

  @override
  _ResultPageState createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  String _patientId = '';
  bool _showButtons = true;
  bool _showAnswers = false; // Added for controlling answers visibility

  @override
  void initState() {
    super.initState();
    _savePatientData();
  }

  Future<void> _savePatientData() async {
    try {
      // Generate a unique ID for the patient
      final docRef = FirebaseFirestore.instance.collection('patients').doc();
      _patientId = docRef.id;

      // Save the patient data to Firestore
      await docRef.set({
        'answers': widget.answers,
        'created_at': Timestamp.now(),
      });

      // Update the UI with the new patient ID
      setState(() {});
    } catch (e) {
      // Print or handle error
      print('Error saving patient data: $e');
    }
  }

  Future<void> generateAndOpenPdf() async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Container(
                color: PdfColor.fromHex('9BB168'),
                height: 200.0,
                child: pw.Center(
                  child: pw.Text(
                    'Result',
                    style: pw.TextStyle(
                      fontSize: 28,
                      fontWeight: pw.FontWeight.bold,
                      color: PdfColors.white,
                    ),
                  ),
                ),
              ),
              pw.SizedBox(height: 30),
              pw.Padding(
                padding: pw.EdgeInsets.symmetric(horizontal: 24.0),
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Text(
                      'ID : $_patientId',
                      style: pw.TextStyle(fontSize: 20, fontWeight: pw.FontWeight.bold),
                    ),
                    pw.SizedBox(height: 20),
                    pw.Row(
                      children: [
                        pw.Expanded(
                          child: pw.Container(
                            height: 10,
                            color: PdfColors.grey300,
                            child: pw.Container(
                              width: 80.0,
                              color: PdfColor.fromHex('9BB168'),
                            ),
                          ),
                        ),
                        pw.SizedBox(width: 10),
                        pw.Text(
                          '80%',
                          style: pw.TextStyle(
                            fontWeight: pw.FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                    pw.SizedBox(height: 20),
                    pw.Text(
                      'Dr. AT_AA will contact the following person..',
                      style: pw.TextStyle(fontSize: 16),
                    ),
                    pw.SizedBox(height: 10),
                    pw.Text(
                      'Neurologist at Govt. Hospital',
                      style: pw.TextStyle(fontSize: 16),
                    ),
                    pw.Text(
                      'Contact.No: 9025111251',
                      style: pw.TextStyle(fontSize: 16),
                    ),
                    pw.SizedBox(height: 20),
                    pw.Text(
                      'Answers:',
                      style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold),
                    ),
                    ...widget.answers.entries.map(
                          (entry) => pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          pw.Text(
                            '${entry.key}',
                            style: pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold),
                          ),
                          pw.Text(
                            '${entry.value.join(', ')}',
                            style: pw.TextStyle(fontSize: 16),
                          ),
                          pw.SizedBox(height: 10),
                        ],
                      ),
                    ).toList(),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );

    final outputFile = await _getOutputFilePath();
    final file = File(outputFile);
    await file.writeAsBytes(await pdf.save());
    await OpenFile.open(outputFile);
  }

  Future<String> _getOutputFilePath() async {
    final directory = await getApplicationDocumentsDirectory();
    return '${directory.path}/result_page.pdf';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              ClipPath(
                clipper: RoundedAppBarClipper(curveHeight: 80.0),
                child: Container(
                  color: Color.fromRGBO(155, 177, 104, 1.0),
                  height: 200.0,
                  child: Center(
                    child: Text(
                      'Result',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'ID : $_patientId',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(
                          child: LinearProgressIndicator(
                            value: 0.8, // This represents the 80% progress
                            backgroundColor: Colors.grey[300],
                            valueColor: AlwaysStoppedAnimation<Color>(
                              Color.fromRGBO(155, 177, 104, 1.0),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        const Text(
                          '95%',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Dr. AT_AA will contact the following person..',
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(height: 10),
                    const Text(
                      'Neurologist at Govt. Hospital',
                      style: TextStyle(fontSize: 16),
                    ),
                    const Text(
                      'Contact.No: 9025111251',
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(height: 20),
                    if (_showAnswers) // Conditional rendering of answers
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Answers:',
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          ...widget.answers.entries.map(
                                (entry) => Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${entry.key}',
                                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  '${entry.value.join(', ')}',
                                  style: TextStyle(fontSize: 16),
                                ),
                                SizedBox(height: 10),
                              ],
                            ),
                          ).toList(),
                        ],
                      ),
                    SizedBox(height: 20),
                    if (_showButtons) // Conditional rendering of buttons
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24.0),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween, // Center the buttons in the Row
                              children: [
                                OutlinedButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  style: OutlinedButton.styleFrom(
                                    foregroundColor: const Color.fromRGBO(155, 177, 104, 1.0),
                                    side: const BorderSide(
                                      color: Color.fromRGBO(155, 177, 104, 1.0),
                                    ),
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 30.0, vertical: 12.0),
                                  ),
                                  child: Text('Back'),
                                ),
                                SizedBox(width: 20), // Space between buttons
                                ElevatedButton(
                                  onPressed: () {
                                    setState(() {
                                      _showAnswers = !_showAnswers; // Toggle answers visibility
                                    });
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Color.fromRGBO(155, 177, 104, 1.0),
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 30.0, vertical: 12.0),
                                  ),
                                  child: Text(_showButtons ? 'Done' : 'Show', style: TextStyle(color: Colors.white)),
                                ),
                              ],
                            ),
                            SizedBox(height: 20),
                            if (!_showButtons)
                              ElevatedButton(
                                onPressed: generateAndOpenPdf,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Color.fromRGBO(155, 177, 104, 1.0),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 30.0, vertical: 12.0),
                                ),
                                child: Text('Download PDF', style: TextStyle(color: Colors.white)),
                              ),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class RoundedAppBarClipper extends CustomClipper<Path> {
  final double curveHeight;

  RoundedAppBarClipper({required this.curveHeight});

  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, size.height - curveHeight);
    path.quadraticBezierTo(
        size.width / 2, size.height, size.width, size.height - curveHeight);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
