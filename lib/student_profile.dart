import 'package:flutter/material.dart';
import 'package:plm_enhancement_application/edit_student_profile.dart';

import 'http_request_method/http_request.dart';

class StudentProfilePage extends StatefulWidget {
  const StudentProfilePage({Key? key, this.text}) : super(key: key);
  final String? text;
  @override
  _StudentProfileWidgetState createState() => _StudentProfileWidgetState();
}

class _StudentProfileWidgetState extends State<StudentProfilePage> {
  Map<String, dynamic> studentData = {}; // Store the fetched data

  @override
  void initState() {
    super.initState();
    // Fetch data when the widget is initialized
    fetchData();
  }

  void fetchData() async {
    if (widget.text != null) {
      RemoteService remoteService = RemoteService();
      Map<String, dynamic> data = await remoteService.fetchData(widget.text!);
      print(data);
      setState(() {
        studentData = data;
        print(studentData);
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    String studentFName = studentData['firstName'] ?? 'No Name';
    String studentMiddleName = studentData['middleName'] ?? 'No Name';
    String studentLName = studentData['lastName'] ?? 'No Name';
    String studentName = '$studentFName $studentLName' ;
    String studentNo = studentData['studentNum'].toString() ?? 'No Student Nuber';
    String studentEmail = studentData['email'] ?? 'No Email';
    String studentCollege = studentData['college'] ?? 'No College';
    String studentCourse = studentData['course'] ?? 'No Course';
    String studentYearLevel = studentData['year'].toString() ?? 'No Year Level';
    String studentMobileNum = studentData['mobileNum'].toString() ?? 'No Mobile Number';
    String studentBirtDate = studentData['birthdate'] ?? 'No Birthday';
    String studentCurrentGWA = studentData['currentGwa'].toString() ?? 'No GWA';
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF343BA6),
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        centerTitle: true,
        title: const Text(
          'STUDENT PROFILE',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EditProfilePage(
                    email: widget.text ?? '',
                    studentNumber: int.tryParse(studentNo),
                    currentGwa: int.tryParse(studentCurrentGWA),
                    firstName: studentFName,
                    middleName: studentMiddleName,
                    lastName: studentLName,
                    college: studentCollege,
                    course: studentCourse,
                    year: int.tryParse(studentYearLevel),
                    mobileNumber: int.tryParse(studentMobileNum),
                    birthdate: studentBirtDate,
                  ),
                ),
              );
              },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 6, left: 14, right: 14),
              child: Stack(
                alignment: Alignment.topCenter,
                children: [
                  Container(
                    height: 200,
                    width: double.infinity,
                    child: Image.asset(
                      'images/ic_profile_bg.png',
                      fit: BoxFit.contain,
                    ),
                  ),
                  // Container(
                  //   height: 100,
                  //   margin: const EdgeInsets.only(top: 120),
                  //   decoration: BoxDecoration(
                  //     shape: BoxShape.circle,
                  //     border: Border.all(
                  //       color: Colors.white,
                  //       width: 2, // Adjust the width of the stroke
                  //     ),
                  //   ),
                  //   child: const CircleAvatar(
                  //     radius: 50,
                  //     backgroundColor: Colors.white,
                  //     backgroundImage: AssetImage('images/user_profile.jpg'),
                  //   ),
                  // ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            Align(
              alignment: Alignment.centerLeft, // Align the text to the start (left)
              child: Padding(
                padding: const EdgeInsets.only(left: 16),
                child: Text(
                  'MY INFORMATION',
                  style: TextStyle(
                    color: Color(0xFFDDB438),
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Card(
              elevation: 2.0,
              color: const Color(0xFFFAF9F6),
              margin: const EdgeInsets.symmetric(horizontal:16),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children:  [
                    Text(
                      'Student Nane',
                      style: TextStyle(
                        fontSize: 10,
                      ),
                    ),
                    SizedBox(height: 6),
                    Text(
                      studentName,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Divider(color: Colors.grey, height: 16),
                    Text(
                      'Student No.',
                      style: TextStyle(
                        fontSize: 10,
                      ),
                    ),
                    SizedBox(height: 6),
                    Text(
                      studentNo,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Divider(color: Colors.grey, height: 16),
                    Text(
                      'College',
                      style: TextStyle(
                        fontSize: 10,
                      ),
                    ),
                    SizedBox(height: 6),
                    Text(
                      studentCollege,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Divider(color: Colors.grey, height: 16),
                    Text(
                      'Degree Program',
                      style: TextStyle(
                        fontSize: 10,
                      ),
                    ),
                    SizedBox(height: 6),
                    Text(
                      studentCourse,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Divider(color: Colors.grey, height: 16),
                    Text(
                      'Year Level',
                      style: TextStyle(
                        fontSize: 10,
                      ),
                    ),
                    SizedBox(height: 6),
                    Text(
                      studentYearLevel,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Divider(color: Colors.grey, height: 16),
                    Text(
                      'Official PLM Email',
                      style: TextStyle(
                        fontSize: 10,
                      ),
                    ),
                    SizedBox(height: 6),
                    Text(studentEmail,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Divider(color: Colors.grey, height: 16),
                    Text(
                      'Birth Date',
                      style: TextStyle(
                        fontSize: 10,
                      ),
                    ),
                    SizedBox(height: 6),
                    Text(
                      studentBirtDate,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Divider(color: Colors.grey, height: 16),
                    Text(
                      'Current GWA',
                      style: TextStyle(
                        fontSize: 10,
                      ),
                    ),
                    SizedBox(height: 6),
                    Text(
                      studentCurrentGWA,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Divider(color: Colors.grey, height: 16),
                    Text(
                      'Mobile Number',
                      style: TextStyle(
                        fontSize: 10,
                      ),
                    ),
                    SizedBox(height: 6),
                    Text(
                      studentMobileNum,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}