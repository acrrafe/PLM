import 'package:flutter/material.dart';

class CollegeCoursesPage extends StatefulWidget {
  const CollegeCoursesPage({Key? key}) : super(key: key);
  @override
  _CoursesWidgetState createState() => _CoursesWidgetState();
}

class _CoursesWidgetState extends State<CollegeCoursesPage> {
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
          'College Courses',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 14),
            // Card view CAUP
            Card(elevation: 2.0, color: const Color(0xFF860303),
              margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Expanded(
                          child: Text('College of Architecture and Urban Planning',
                            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
                          ),
                        ),
                        Image.asset('images/ic_archi.png', height: 70, width: 70),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(width: 8, height: 8,
                          decoration: BoxDecoration(color: const Color(0xFFFAA885),
                            border: Border.all(color: Colors.black, width: 1),
                          ),
                        ),
                        const SizedBox(width: 6),
                        const Expanded(child: Text('Bachelor of Science in Architecture - BS Arch',
                            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
            // Card view EDUCATION
            Card(elevation: 2.0, color: const Color(0xFF343BA6),
              margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: Padding(padding: const EdgeInsets.all(16),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Expanded(
                          child: Text('Education',
                            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
                          ),
                        ),
                        Image.asset('images/ic_educ.png', height: 70, width: 70,
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Column(
                      children: [
                        Row(crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(width: 8, height: 8,
                              decoration: BoxDecoration(color: const Color(0xFFFAA885),
                                border: Border.all(color: Colors.black, width: 1),
                              ),
                            ),
                            const SizedBox(width: 6),
                            const Expanded(
                              child: Text('Bachelor of Elementary Education - BEEd',
                                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(width: 8, height: 8,
                              decoration: BoxDecoration(color: const Color(0xFFFAA885),
                                border: Border.all(color: Colors.black, width: 1),
                              ),
                            ),
                            const SizedBox(width: 6),
                            const Expanded(
                              child: Text(
                                'Bachelor of Early Childhood Education - BECEd',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(width: 8, height: 8, decoration: BoxDecoration(
                                color: const Color(0xFFFAA885),
                                border: Border.all(color: Colors.black, width: 1),
                              ),
                            ),
                            const SizedBox(width: 6),
                            const Expanded(
                              child: Text('Bachelor of Special Needs Education (Generalist) - BSNEd',
                                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(width: 8, height: 8,
                              decoration: BoxDecoration(color: const Color(0xFFFAA885),
                                border: Border.all(color: Colors.black, width: 1),
                              ),
                            ),
                            const SizedBox(width: 6),
                            const Expanded(
                              child: Text('Bachelor of Secondary Education major in English - BSEd-Eng',
                                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(width: 8, height: 8,
                              decoration: BoxDecoration(color: const Color(0xFFFAA885),
                                border: Border.all(color: Colors.black, width: 1),
                              ),
                            ),
                            const SizedBox(width: 6),
                            const Expanded(
                              child: Text('Bachelor of Secondary Education major in Mathematics - BSEd-Math',
                                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(width: 8, height: 8,
                              decoration: BoxDecoration(color: const Color(0xFFFAA885),
                                border: Border.all(color: Colors.black, width: 1),
                              ),
                            ),
                            const SizedBox(width: 6),
                            const Expanded(
                              child: Text('Bachelor of Secondary Education major in Sciences - BSEd-Sciences',
                                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold,),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(width: 8, height: 8,
                              decoration: BoxDecoration(color: const Color(0xFFFAA885),
                                border: Border.all(color: Colors.black, width: 1),
                              ),
                            ),
                            const SizedBox(width: 6),
                            const Expanded(
                              child: Text('Bachelor of Secondary Education major in Social Studies - BSEd-SS',
                                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(width: 8, height: 8,
                              decoration: BoxDecoration(color: const Color(0xFFFAA885),
                                border: Border.all(color: Colors.black, width: 1),
                              ),
                            ),
                            const SizedBox(width: 6),
                            const Expanded(
                              child: Text('Bachelor of Physical Education - BPE',
                                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                    ],)

                  ],
                ),
              ),
            ),
            // Card view CET
            Card(elevation: 2.0, color: const Color(0xFFD5A106),
              margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: Padding(padding: const EdgeInsets.all(16),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Expanded(
                          child: Text('College of Engineering and Technology',
                            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
                          ),
                        ),
                        Image.asset('images/ic_cet.png', height: 70, width: 70),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(width: 8, height: 8,
                              decoration: BoxDecoration(color: const Color(0xFFFAA885),
                                border: Border.all(color: Colors.black, width: 1),
                              ),
                            ),
                            const SizedBox(width: 6),
                            const Expanded(
                              child: Text('Bachelor of Science in Chemical Engineering - BSCHE',
                                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(width: 8, height: 8, decoration: BoxDecoration(
                                color: const Color(0xFFFAA885),
                                border: Border.all(color: Colors.black, width: 1),
                              ),
                            ),
                            const SizedBox(width: 6),
                            const Expanded(
                              child: Text('Bachelor of Science in Civil Engineering - BSCE',
                                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(width: 8, height: 8,
                              decoration: BoxDecoration(color: const Color(0xFFFAA885),
                                border: Border.all(color: Colors.black, width: 1),
                              ),
                            ),
                            const SizedBox(width: 6),
                            const Expanded(
                              child: Text('Bachelor of Science in Computer Engineering - BSCpE',
                                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(width: 8, height: 8,
                              decoration: BoxDecoration(color: const Color(0xFFFAA885),
                                border: Border.all(color: Colors.black, width: 1),
                              ),
                            ),
                            const SizedBox(width: 6),
                            const Expanded(
                              child: Text('Bachelor of Science in Computer Science - BSCS',
                                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(width: 8, height: 8,
                              decoration: BoxDecoration(color: const Color(0xFFFAA885),
                                border: Border.all(color: Colors.black, width: 1),
                              ),
                            ),
                            const SizedBox(width: 6),
                            const Expanded(
                              child: Text('Bachelor of Science in Electrical Engineering - BSEE',
                                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(width: 8, height: 8,
                              decoration: BoxDecoration(color: const Color(0xFFFAA885),
                                border: Border.all(color: Colors.black, width: 1),
                              ),
                            ),
                            const SizedBox(width: 6),
                            const Expanded(
                              child: Text('Bachelor of Science in Electronics Engineering - BSECE',
                                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(width: 8, height: 8,
                              decoration: BoxDecoration(color: const Color(0xFFFAA885),
                                border: Border.all(color: Colors.black, width: 1),
                              ),
                            ),
                            const SizedBox(width: 6),
                            const Expanded(
                              child: Text(
                                'Bachelor of Science in Information Technology = BSIT)',
                                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(width: 8, height: 8,
                              decoration: BoxDecoration(color: const Color(0xFFFAA885),
                                border: Border.all(color: Colors.black, width: 1),
                              ),
                            ),
                            const SizedBox(width: 6),
                            const Expanded(
                              child: Text('Bachelor  of Science in Mechanical Engineering - BSME',
                                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}