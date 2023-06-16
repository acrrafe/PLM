import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'home_student.dart';

class HDSuccessPage extends StatefulWidget {
  final String email;
  final String name;
  final int studNum;

  HDSuccessPage({required this.email, required this.name, required this.studNum});

  @override
  _HDSuccessPageState createState() => _HDSuccessPageState();
}

class _HDSuccessPageState extends State<HDSuccessPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF343BA6),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MyDashboard(text: widget.email)));
          },
        ),
        title: Text('HD Success'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      Text(
                        widget.name,
                        style: TextStyle(color: Color(0xFF860303), fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 20),
                Text(
                  DateFormat('yyyy/MM/dd').format(DateTime.now()),
                ),
              ],
            ),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      Text(
                        widget.studNum.toString(),
                        style: TextStyle(color: Color(0xFF860303), fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 20),
                Text(
                  DateFormat('HH:mm').format(DateTime.now()),
                ),
              ],
            ),
            SizedBox(height: 50),
            Center(
              child: Text(
                "HEALTH DECLARATION SAVED",
                style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFFDDB438), fontSize: 20.0),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 30),
            Text(
              "You are now cleared to enter the PLM premises on the date:",
              textAlign: TextAlign.justify,
              style: TextStyle(fontSize: 12),
            ),
            SizedBox(height: 30),
            Center(
              child: Text(
                DateFormat('yyyy/MM/dd').format(DateTime.now().add(Duration(days: 1))),
                style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF343BA6), fontSize: 30.0),
              ),
            ),
            SizedBox(height: 30),
            Card(
              color: Color(0xFFFCFCFC),
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Subject to standard security and health protocols.",
                      textAlign: TextAlign.justify,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 14),
                    Text(
                      "Please always wear your mask, wash your hands, and maintain social distancing. Don't forget to use the PLM Health Declaration the day before you go to PLM to protect yourself, your loved ones, and the PLM community.",
                      textAlign: TextAlign.justify,
                    ),
                    SizedBox(height: 14),
                    Text(
                      "Thank you for using the PLM Health Declaration Form.",
                      textAlign: TextAlign.justify,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MyDashboard(text: widget.email)));
                },
                style: ElevatedButton.styleFrom(
                  primary: Color(0xFFDDB438),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.send), // Use the back arrow icon
                    SizedBox(width: 8), // Add some spacing between the icon and text
                    Text(
                      "Back to dashboard",
                      style: TextStyle(fontSize: 16),
                    ),
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
