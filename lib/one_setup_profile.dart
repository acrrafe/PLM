import 'package:flutter/material.dart';

import 'http_request_method/http_request.dart';

class SetupProfilePage extends StatefulWidget {
  const SetupProfilePage({Key? key, required this.text}) : super(key: key);
  final String? text;

  @override
  _SetupProfilePageState createState() => _SetupProfilePageState();
}

class _SetupProfilePageState extends State<SetupProfilePage> {
  Map<String, dynamic> studentData = {};
  final _formKey = GlobalKey<FormState>();

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
          await remoteService.addData(context,
            studentData['email'],
            studentData['firstName'],
            studentData['middleName'],
            studentData['lastName'],
            studentData['studentNum'],
            studentData['college'],
            studentData['course'],
            studentData['year'],
            studentData['mobileNum'],
            studentData['birthdate'],
            studentData['currentGwa'],
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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF343BA6),
        centerTitle: true,
        title: const Text(
          'SETUP PROFILE',
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
                    'Setup your Profile',
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
                          initialValue: studentData['email'] ?? widget.text ?? '',
                          enabled: false,
                          onSaved: (value) {
                            studentData['email'] = widget.text; // Set the value of email to widget.text
                          },
                        ),
                        SizedBox(height: 16),
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: 'First Name',
                            hintText: 'e.g. Juan',
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your first name';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            studentData['firstName'] = value;
                          },
                        ),
                        SizedBox(height: 16),
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Middle Name',
                            hintText: 'e.g. Ponce',
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your middle name';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            studentData['middleName'] = value;
                          },
                        ),
                        SizedBox(height: 16),
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Last Name',
                            hintText: 'e.g. Dela cruz',
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your last name';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            studentData['lastName'] = value;
                          },
                        ),
                        SizedBox(height: 16),
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Student Number',
                            hintText: 'e.g. 202132049',
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your student number';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            studentData['studentNum'] = value;
                          },
                        ),
                        SizedBox(height: 16),
                        DropdownButtonFormField<String>(
                          decoration: InputDecoration(labelText: 'College'),
                          value: studentData['college'],
                          items: collegeCourses.keys.map((String college) {
                            return DropdownMenuItem<String>(
                              value: college,
                              child: Text(college),
                            );
                          }).toList(),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please select your college';
                            }
                            return null;
                          },
                          onChanged: (value) {
                            setState(() {
                              studentData['college'] = value;
                              studentData['course'] = null; // Reset the course value when college changes
                            });
                          },
                        ),
                        SizedBox(height: 16),
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
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please select your course';
                            }
                            return null;
                          },
                          onChanged: (value) {
                            setState(() {
                              studentData['course'] = value;
                            });
                          },
                        ),

                        SizedBox(height: 16),
                        DropdownButtonFormField<int>(
                          decoration: InputDecoration(
                            labelText: 'Year',
                            hintText: 'Select your year level',
                          ),
                          value: selectedYear,
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
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your mobile number';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            studentData['mobileNum'] = value;
                          },
                        ),
                        SizedBox(height: 16),
                        TextFormField(
                          decoration: InputDecoration(labelText: 'Birth Date'),
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
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your current GWA';
                            }
                            return null;
                          },
                          onSaved: (value) {
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
                    'SET UP',
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

