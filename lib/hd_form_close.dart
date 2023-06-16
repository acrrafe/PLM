import 'package:flutter/material.dart';

void main() {
  runApp(HDClosePage());
}

class HDClosePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HealthDeclarationFormClosePage(title: '',),
    );
  }
}

class HealthDeclarationFormClosePage extends StatelessWidget {
  final String title;
  const HealthDeclarationFormClosePage({Key? key, required this.title}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('HD Form Close'),
        backgroundColor: Color(0xFF343BA6),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 26.0),
            Image.asset('images/ic_hd_img.png'),
            SizedBox(height: 16.0),
            Container(
              width: 330,
              margin: EdgeInsets.all(16.0),
              child: Card(
                color: Color(0xFFFCFCFC),
                elevation: 1,
                child: Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Wrap(
                          alignment: WrapAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                Text(
                                  "Student HD isn’t",
                                  style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFFDDB438), fontSize: 20.0),
                                  textAlign: TextAlign.center,
                                ),
                                SizedBox(height: 4),
                                Text(
                                  "available right now",
                                  style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFFDDB438), fontSize: 20.0),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 30),
                      Text(
                        "Only enrolled students can use Health Declaration Form",
                        textAlign: TextAlign.justify,
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                      ),
                      SizedBox(height: 14),
                      Text(
                        "Students must complete the Student Health Declaration daily between 4 AM and 3 PM. If Student Health Declaration is not completed, students must arrive at the campus an hour before the start of class/activity for screening by UHS.",
                           textAlign: TextAlign.justify,),
                      SizedBox(height: 14),
                      Text(
                        "Reports of non-compliance will be submitted to OSDS and may result in disciplinary action. Maximum 7 days of non-compliance per semester.",
                        textAlign: TextAlign.justify,
                      ),
                    ],
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
