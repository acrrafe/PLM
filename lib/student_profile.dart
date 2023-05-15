import 'package:flutter/material.dart';

class StudentProfilePage extends StatefulWidget {
  const StudentProfilePage({Key? key}) : super(key: key);

  @override
  _StudentProfileWidgetState createState() => _StudentProfileWidgetState();
}

class _StudentProfileWidgetState extends State<StudentProfilePage> {
  @override
  Widget build(BuildContext context) {
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
                  Container(
                    height: 100,
                    margin: const EdgeInsets.only(top: 120),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.white,
                        width: 2, // Adjust the width of the stroke
                      ),
                    ),
                    child: const CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.white,
                      backgroundImage: AssetImage('images/ic_kap.jpg'),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              'Robert Matobato',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: const [
                    Text(
                      '4',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text('Pending requirements'),
                  ],
                ),
                Column(
                  children: const [
                    Text(
                      '364',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text('Units Complete'),
                  ],
                ),
              ],
            ),
            SizedBox(height: 16),
            Card(
              elevation: 2.0,
              color: const Color(0xFFFAF9F6),
              margin: const EdgeInsets.symmetric(horizontal: 16),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Student No.',
                      style: TextStyle(
                        fontSize: 10,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      '2020-123456',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Divider(color: Colors.grey, height: 16),
                    Text(
                      'Registration Status',
                      style: TextStyle(
                        fontSize: 10,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Regular',
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
                    SizedBox(height: 4),
                    Text(
                      'Bachelor of Science in Computer Science',
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
                    SizedBox(height: 4),
                    Text(
                      '3',
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
                    SizedBox(height: 4),
                    Text(
                      'rbmatobato@plm.edu.ph',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Divider(color: Colors.grey, height: 16),
                    Text(
                      'Contact Number',
                      style: TextStyle(
                        fontSize: 10,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      '09123456789',
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