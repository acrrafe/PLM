import 'package:flutter/material.dart';

import 'http_request_method/http_request.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({Key? key, required this.email, this.studentNumber, this.currentGwa, this.firstName, this.middleName, this.lastName, this.college, this.course, this.year, this.mobileNumber, this.birthdate}) : super(key: key);
  final String email;
  final int? studentNumber ;
  final int? currentGwa;
  final String? firstName;
  final String? middleName;
  final String? lastName;
  final String? college;
  final String? course;
  final int? year;
  final int? mobileNumber;
  final String? birthdate;

  // this.studentNumber, this.currentGwa, this.firstName, this.lastName, this.college, this.course, this.year, this.mobileNumber, this.birthdate, this.middleName


  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  Map<String, dynamic> studentData = {};
  final _formKey = GlobalKey<FormState>();

  // String studentCollege = widget.college; // Initialize with empty string
  // String studentCourse = collegeCourses[widget.college]?.contains(widget.course) == true ? widget.course : ''; Initialize with empty string

  @override
  void initState() {
    super.initState();
    // Fetch data when the widget is initialized
    fetchData();
  }

  void fetchData() async {
    if (widget.email != null) {
      RemoteService remoteService = RemoteService();
      Map<String, dynamic> data = await remoteService.fetchData(widget.email);
      print(data);
      setState(() {
        studentData = data;
         // studentCollege = studentData['college'] ?? 'No College';
         // print(studentCollege);
         // studentCourse = studentData['course'] ?? 'No Course';
         // print(studentCourse);

      });
    }
  }

  Map<String, List<String>> collegeCourses = {
    'CET': ['BSCS', 'BSCE', 'BSCIT'],
    'CE': ['BEEd', 'BECEd', 'BSNEd'],
    'PLM-BS': ['BS-ACCTG', 'BSBA-BE', 'BSBA-HRM'],
  };

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      if (studentData.isNotEmpty) {
        try {
          RemoteService remoteService = RemoteService();
          await remoteService.updateData(context,
            studentData['email'],
            studentData['firstName'],
            studentData['middleName'],
            studentData['lastName'],
            studentData['studentNum'].toString(),
            studentData['college'],
            studentData['course'],
            studentData['year'],
            studentData['mobileNum'].toString(),
            studentData['birthdate'],
            studentData['currentGwa'].toString(),
          );
          // Handle successful form submission
        } catch (e) {
          print(e);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    int? selectedYear;
    String studentFName = studentData['firstName'] ?? 'No Name';
    String studentMiddleName = studentData['middleName'] ?? 'No Name';
    String studentLName = studentData['lastName'] ?? 'No Name';
    String studentName = '$studentFName $studentLName' ;
    String studentNo = studentData['studentNum'].toString() ?? 'No Student Nuber';
    String studentEmail = studentData['email'] ?? 'No Email';
    String studentYearLevel = studentData['year'].toString() ?? 'No Year Level';
    String studentMobileNum = studentData['mobileNum'].toString() ?? 'No Mobile Number';
    String studentBirtDate = studentData['birthdate'] ?? 'No Birthday';
    String studentCurrentGWA = studentData['currentGwa'].toString() ?? 'No GWA';


    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF343BA6),
        centerTitle: true,
        title: const Text(
          'EDIT PROFILE',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Image.asset(
                    'images/plm_logo.png',
                    height: 68,
                    width: 68,
                  ),
                  SizedBox(width: 8),
                  Text(
                    'Edit your Profile',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Email',
                            hintText: 'Enter your PLM email',
                          ),
                          initialValue: studentData['email'] ?? widget.email ?? '',
                          enabled: false,
                          onSaved: (value) {
                            studentData['email'] = widget.email; // Set the value of email to widget.text
                          },
                        ),
                        SizedBox(height: 16),
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: 'First Name',
                            hintText: 'e.g. Robert',
                          ),
                          controller: TextEditingController(
                              text: studentData['firstName']),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your first name';
                            }
                            return null;
                          },
                          onChanged: (value) {
                            studentData['firstName'] = value;
                          },
                        ),
                        SizedBox(height: 16),
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Middle Name',
                            hintText: 'e.g. Demagiba',
                          ),
                          controller: TextEditingController(
                              text: studentData['middleName']),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your middle name';
                            }
                            return null;
                          },
                          onChanged: (value) {
                            studentData['middleName'] = value;
                          },
                        ),
                        SizedBox(height: 16),
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Last Name',
                            hintText: 'e.g. Dela cruz',
                          ),
                          controller: TextEditingController(
                              text: studentData['lastName']),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your last name';
                            }
                            return null;
                          },
                          onChanged: (value) {
                            studentData['lastName'] = value;
                          },
                        ),

                        SizedBox(height: 16),
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Student Number',
                            hintText: 'e.g. 202132049',
                          ),
                          controller: TextEditingController(
                            text: (studentData['studentNum'] ?? 0).toString(),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your student number';
                            }
                            return null;
                          },
                          onChanged: (value) {
                            studentData['studentNum'] = value;
                          },
                        ),
                        SizedBox(height: 16),
                        // College dropdown
                        DropdownButtonFormField<String>(
                          decoration: InputDecoration(labelText: 'College'),
                          value: studentData['college'],
                          items: collegeCourses.keys.map((String college) {
                            return DropdownMenuItem<String>(
                              value: college,
                              child: Text(college),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              studentData['college'] = value;
                              studentData['course'] = null; // Reset the course value when college changes// Reset the selected course value
                            });
                          },
                        ),

                        DropdownButtonFormField<String>(
                          decoration: InputDecoration(labelText: 'Course'),
                          value: studentData['course'],
                          items: studentData['college'] != null
                              ? collegeCourses[studentData['college']]!.map((String course) {
                            return DropdownMenuItem<String>(
                              value: course,
                              child: Text(course),
                            );
                          }).toList()
                              : null,
                          onChanged: (value) {
                            setState(() {
                              studentData['course'] = value;
                            });
                          },
                          validator: (value) {
                            if (value != null &&
                                collegeCourses[studentData['college']]!
                                    .where((course) => course == value)
                                    .length > 1) {
                              return 'Duplicate course value found';
                            }else if (value == null || value.isEmpty) {
                              return 'Please select your college';
                            }
                            return null;
                          },
                        ),

                        SizedBox(height: 16),
                        DropdownButtonFormField<int>(
                          decoration: InputDecoration(
                            labelText: 'Year',
                            hintText: 'Select your year level',
                          ),
                          value: int.tryParse(studentYearLevel),
                          items: [
                            DropdownMenuItem<int>(
                              value: 1,
                              child: Text('1st Year'),
                            ),
                            DropdownMenuItem<int>(
                              value: 2,
                              child: Text('2nd Year'),
                            ),
                            DropdownMenuItem<int>(
                              value: 3,
                              child: Text('3rd Year'),
                            ),
                            DropdownMenuItem<int>(
                              value: 4,
                              child: Text('4th Year'),
                            ),
                            DropdownMenuItem<int>(
                              value: 5,
                              child: Text('5th Year'),
                            ),
                            DropdownMenuItem<int>(
                              value: 6,
                              child: Text('6th Year'),
                            ),
                          ],
                          validator: (value) {
                            if (value == null || value.toString().isEmpty) {
                              return 'Please select your year level';
                            }
                            return null;
                          },
                          onChanged: (value) {
                            setState(() {
                              selectedYear = value;
                            });
                          },
                          onSaved: (value) {
                            studentData['year'] = value;
                          },
                        ),
                        SizedBox(height: 16),
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Mobile Number',
                            hintText: 'Enter your mobile number',
                          ),
                          controller: TextEditingController(
                            text: (studentData['mobileNum'] ?? 0).toString(),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your mobile number';
                            }
                            return null;
                          },
                          onChanged: (value) {
                            studentData['mobileNum'] = value;
                          },
                        ),
                        SizedBox(height: 16),
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Birth Date',
                          ),
                          controller: TextEditingController(
                            text: studentData['birthdate'],
                          ),
                          onTap: () async {
                            final DateTime? pickedDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(1900),
                              lastDate: DateTime.now(),
                            );
                            if (pickedDate != null) {
                              setState(() {
                                studentData['birthdate'] = pickedDate.toString().split(' ')[0];
                              });
                            }
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your birth date';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 16),
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Current GWA',
                            hintText: 'Enter your current GWA',
                          ),
                          controller: TextEditingController(
                            text: (studentData['currentGwa'] ?? 0).toString(),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your current GWA';
                            }
                            return null;
                          },
                          onChanged: (value) {
                            studentData['currentGwa'] = value;
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    _submitForm();
                    studentData.forEach((key, value) {
                      print('$key: $value');
                    });
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Color(0xFFDDB438)),
                    minimumSize: MaterialStateProperty.all<Size>(Size(200, 50)), // Increase button size
                  ),
                  child: Text(
                    'UPDATE',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}