import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'home_guest.dart';
import 'home_student.dart';

void main() {
  runApp(HDPage());
}

class HDPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HealthDeclarationFormPage(
        email: '',
        name: '',
        studNum: 0,
      ),
    );
  }
}

class HealthDeclarationFormPage extends StatefulWidget {
  final String email;
  final String name;
  final int studNum;

  const HealthDeclarationFormPage({
    Key? key,
    required this.email,
    required this.name,
    required this.studNum,
  }) : super(key: key);

  @override
  _HealthDeclarationFormPageState createState() =>
      _HealthDeclarationFormPageState();
}

class _HealthDeclarationFormPageState extends State<HealthDeclarationFormPage> {
  bool privacyActAnswer = false;
  bool firstAnswer = false;
  bool secondAnswer = false;
  bool thirdAnswer = false;
  bool fourthAnswer = false;

  bool get canSubmit {
    return !privacyActAnswer;
  }

  Future<void> _submitForm() async {
    final tomorrow = DateTime.now().add(Duration(days: 1));
    final formattedDate = "${tomorrow.year}/${tomorrow.day}/${tomorrow.month}";
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("${widget.email}_hdDate", formattedDate);
    print("FORMATTED DATE: $formattedDate");

    if (firstAnswer || secondAnswer || thirdAnswer || fourthAnswer) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          prefs.setString('${widget.email}_hdResult', 'failed');
          print(prefs.setString('${widget.email}_hdResult', 'failed'));
          return AlertDialog(
              content: SingleChildScrollView(
                child: Container(
                  width: double.maxFinite,
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
                        "Please wait for clearance from our officials of the University Health Services", textAlign: TextAlign.justify,
                        style: TextStyle(fontSize: 12),
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
                                "Please always wear your mask, wash your hands and maintain social distancing. Don't forget to use PLM Health Declaration the day before you go to PLM to protect yourself, your loved ones, and the PLM community.",
                                textAlign: TextAlign.justify,),
                              SizedBox(height: 14),
                              Text(
                                "Thank you for using PLM Health Declaration Form.", textAlign: TextAlign.justify,
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      Center(
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.popUntil(context, (route) => route.isFirst);
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MyDashboard(text: widget.email)));
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Color(0xFFDDB438),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.send), // Add the airplane icon
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
              )
          );
        },
      );
    } else {
      final tomorrow = DateTime.now().add(Duration(days: 1));
      final formattedDate =
          "${tomorrow.year}/${tomorrow.day}/${tomorrow.month}";
      print(formattedDate);
      showDialog(
        context: context,
        builder: (BuildContext context) {
          prefs.setString('${widget.email}_hdResult', 'success');
          print(prefs.setString('${widget.email}_hdResult', 'success'));
          return AlertDialog(
            content: SingleChildScrollView(
              child: Container(

                width: double.maxFinite,
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
                      "You are now cleared to enter the PLM premises on the date:", textAlign: TextAlign.justify,
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
                              "Please always wear your mask, wash your hands and maintain social distancing. Don't forget to use PLM Health Declaration the day before you go to PLM to protect yourself, your loved ones, and the PLM community.",
                              textAlign: TextAlign.justify,),
                            SizedBox(height: 14),
                            Text(
                              "Thank you for using PLM Health Declaration Form.", textAlign: TextAlign.justify,
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Center(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.popUntil(context, (route) => route.isFirst);
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MyDashboard(text: widget.email)));
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Color(0xFFDDB438),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.send), // Add the airplane icon
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
            )
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Health Declaration Form"),
        backgroundColor: Color(0xFF343BA6),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                'images/ic_hd_img.png', // Replace with the actual image path
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              SizedBox(height: 16.0),
              Text(
                "Declaration and Data Privacy Consent Form",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0,
                ),
              ),
              SizedBox(height: 16.0),
              Text(
                "I declare that the information I have given is true, correct, and complete. I understand that failure to answer any question or giving a false answer can be penalized according to the law.\n\nI also voluntarily and freely consent to the collection and sharing of the above information only in relation to PLM's compliance to health and safety protocols under the guidelines and standards of the Inter-Agency Task Force for the Management of Emerging Infectious Diseases (IATF) and Republic Act 11332.",
                style: TextStyle(fontSize: 16.0),
              ),
              SizedBox(height: 16.0),
              Container(
                color: Color(0xFFF0F0F0), // Add grey background color
                child: Row(
                  children: [
                    Radio(
                      value: true,
                      groupValue: privacyActAnswer,
                      onChanged: (value) {
                        setState(() {
                          privacyActAnswer = value!;
                        });
                      },
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      activeColor: Colors.black, // Change radio button color to black
                    ),
                    Text(
                      "Yes",
                      style: TextStyle(color: Colors.black), // Change text color to black
                    ),
                  ],
                ),
              ),
              SizedBox(height: 4),
              Container(
                color: Color(0xFFF0F0F0), // Add grey background color
                child: Row(
                  children: [
                    Radio(
                      value: false,
                      groupValue: privacyActAnswer,
                      onChanged: (value) {
                        setState(() {
                          privacyActAnswer = value!;
                        });
                      },
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      activeColor: Colors.black, // Change radio button color to black
                    ),
                    Text(
                      "No",
                      style: TextStyle(color: Colors.black), // Change text color to black
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16.0),
              Text(
                "1. Have you been sick in the past 7 Days?",
                style: TextStyle(fontSize: 16.0),
              ),
              SizedBox(height: 6),
              Column(
                children: [
                  Container(
                    color: Color(0xFFF0F0F0), // Add grey background color
                    child: Row(
                      children: [
                        Radio(
                          value: true,
                          groupValue: firstAnswer,
                          onChanged: (value) {
                            setState(() {
                              firstAnswer = value!;
                            });
                          },
                          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          activeColor: Colors.black, // Change radio button color to black
                        ),
                        Text(
                          "Yes",
                          style: TextStyle(color: Colors.black), // Change text color to black
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 4),
                  Container(
                    color: Color(0xFFF0F0F0), // Add grey background color
                    child: Row(
                      children: [
                        Radio(
                          value: false,
                          groupValue: firstAnswer,
                          onChanged: (value) {
                            setState(() {
                              firstAnswer = value!;
                            });
                          },
                          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          activeColor: Colors.black, // Change radio button color to black
                        ),
                        Text(
                          "No",
                          style: TextStyle(color: Colors.black), // Change text color to black
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16.0),
              Text(
                "2. In the last 7 Days did you have any of the following:",
                style: TextStyle(fontSize: 16.0),
              ),
              SizedBox(height: 6),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("* Fever"),
                  Text("* Coughs"),
                  Text("* Colds"),
                  Text("* Sore throat"),
                  Text("* Loss of Smell and Taste"),
                  Text("* Muscle Pain"),
                  Text("* Headache"),
                  Text("* Difficulty in Breathing"),
                  SizedBox(height: 8),
                  Container(
                    color: Color(0xFFF0F0F0), // Add grey background color
                    child: Row(
                      children: [
                        Radio(
                          value: true,
                          groupValue: secondAnswer,
                          onChanged: (value) {
                            setState(() {
                              secondAnswer = value!;
                            });
                          },
                          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          activeColor: Colors.black, // Change radio button color to black
                        ),
                        Text(
                          "Yes",
                          style: TextStyle(color: Colors.black), // Change text color to black
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 4),
                  Container(
                    color: Color(0xFFF0F0F0), // Add grey background color
                    child: Row(
                      children: [
                        Radio(
                          value: false,
                          groupValue: secondAnswer,
                          onChanged: (value) {
                            setState(() {
                              secondAnswer = value!;
                            });
                          },
                          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          activeColor: Colors.black, // Change radio button color to black
                        ),
                        Text(
                          "No",
                          style: TextStyle(color: Colors.black), // Change text color to black
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16.0),
              Text(
                "3. Have you had close contact or exposure to a confirmed COVID-19 case in the last 14 days?",
                style: TextStyle(fontSize: 16.0),
              ),
              SizedBox(height: 6),
              Column(
                children: [
                  Container(
                    color: Color(0xFFF0F0F0), // Add grey background color
                    child: Row(
                      children: [
                        Radio(
                          value: true,
                          groupValue: thirdAnswer,
                          onChanged: (value) {
                            setState(() {
                              thirdAnswer = value!;
                            });
                          },
                          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          activeColor: Colors.black, // Change radio button color to black
                        ),
                        Text(
                          "Yes",
                          style: TextStyle(color: Colors.black), // Change text color to black
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 4),
                  Container(
                    color: Color(0xFFF0F0F0), // Add grey background color
                    child: Row(
                      children: [
                        Radio(
                          value: false,
                          groupValue: thirdAnswer,
                          onChanged: (value) {
                            setState(() {
                              thirdAnswer = value!;
                            });
                          },
                          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          activeColor: Colors.black, // Change radio button color to black
                        ),
                        Text(
                          "No",
                          style: TextStyle(color: Colors.black), // Change text color to black
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16.0),
              SizedBox(height: 16.0),
              Center(
                child: ElevatedButton(
                  onPressed: canSubmit ? null : _submitForm,
                  child: Text(
                    "SUBMIT",
                    style: TextStyle(color: Colors.white, fontSize: 25.0),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: Color(0xFFDDB438),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    minimumSize: Size(200.0, 50.0),
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
